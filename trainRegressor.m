function [ param ] = trainRegressor(in, out)

% Number of Guassian basis function
numGaussians_X = 6;
numGaussians_Y = 5;
baseFuncs=cell((numGaussians_X*numGaussians_Y)+1,1);
TrainingData = [in, out];

%%%%%% LONGITUDE AND LATITUDE FOR THE GREATER LONDON %%%%%%
% % LATITUDE: -0.51 to 0.34
x1 = -0.51; x2 = 0.34;
% % LONGITUDE: 51.3 to 51.7
y1 = 51.3; y2 = 51.7;

% Greter London Range
X = abs(x2-x1);
Y = abs(y2-y1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Creating the grid
for d = 1:(numGaussians_X+1)
   Xaxis(d) = (d-1)*X/(numGaussians_X);
end
for d = 1:(numGaussians_Y+1)
   Yaxis(d) = (d-1)*Y/(numGaussians_Y);
end
% matrix with the X and Y values of the Grid
Xaxis = x1 + Xaxis;
Yaxis = y1 + Yaxis;

% initializing the starting indexes
n = 1; 
number = [];
newTrainingData = []; newTrainingData = [0,0,0];

% Calculating Means and Sigma
for e=1:numGaussians_Y
    for r=1:numGaussians_X
        
        % Calculating points in one box
        u = []; u = 1;
        for m = 1:length(TrainingData)
            if  TrainingData(m,1) > Xaxis(r) && TrainingData(m,1) <= Xaxis(r+1) && TrainingData(m,2) > Yaxis(e) && TrainingData(m,2) <= Yaxis(e+1)
                newTrainingData(u,:) = TrainingData(m,:);
                u = u + 1;
            else
            end
        end
               
        % mean (mu) and variance (sig)
        %===========================================%
        
        % calculating the mean of the prices in one box
        muZ = mean(newTrainingData(:,3));
        % calculating the standard deviation of the prices in one box
        sigZ = cov(newTrainingData(:,3));
        z1 = muZ - sigZ;
        z2 = muZ + sigZ;
        k = 1;
        size_newTrainingData = size(newTrainingData);
        % creating matrix with the data in one box which price is in the
        % range of the standard deviation.
        for index = 1:size_newTrainingData(1,1)
            
            if  newTrainingData(index,3)>=z1 && newTrainingData(index,3)<=z2
                new2TrainingData(k,:) = newTrainingData(index,:);
                k = k + 1;
                index;
            else
                index;
            end
        end
        
        
        % mu calculated for every long and lat of the points which are
        % within each box
        mu = [mean(new2TrainingData(:,1)), mean(new2TrainingData(:,2))];
        % sig calculated as covariance for every long and lat of the 
        % points which are within each box
        sig = cov(new2TrainingData(:,1),  new2TrainingData(:,2));
        sig = pinv(sig);
        
        %===========================================%
        baseFuncs{n}=@(x)myGaussian(x,mu,sig);
        param.mu{n}=mu;
        param.sig{n}=sig;
        
        n = n+1;
        newTrainingData = []; newTrainingData = [0, 0, 0];
        new2TrainingData = []; new2TrainingData = [0,0,0];
        
        
    end
end
baseFuncs{end}=@(x)1;

%calculate the values of each basis function at each training datapoint
val=zeros(length(in),length(baseFuncs));

parfor n=1:length(in)
    valTemp=zeros(1,length(baseFuncs));
    for j=1:length(baseFuncs)
        valTemp(1,j)=baseFuncs{j}(in(n,:));
    end
    val(n,:)=valTemp;
end

%pseudoinverse for least squares solution
param.w=pinv(val)*out;
param.baseFuncs=baseFuncs;
end

function val=myGaussian(x,mu,sig)
%a gaussian basis function
val=exp(-(x-mu)*sig*(x-mu)');
end


