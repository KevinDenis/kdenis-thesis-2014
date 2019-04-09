function [totalProbability] = Update(nRays,nParticles,rayData,lidarData)
%UPDATE Summary of this function goes here
% Updating is done with sensor model which is based of a mixture of 4
% densities:
% 1: Correct range with local measurement noise. Gaussian distribution mean=
% Ray casted value. Zmax is hard limit. Normal Distribution + Normalizer 155
% 2:  Unexpected objects. Maps are static, environments are dynamic.
% Considering them as noise is easy + better solution. Exponential
% distribution with ray casted value as max. + normalizer see 156
% 3: Failures: NOT CONSIDERED (max range values are filtered before
% 4: Random values: uniform over zmax 1/zmax
% P(zreal|xt,map) = [zhit;zshort;rand]*(phit,pshort,prand) zhit,zshort,zrand
% zijn parameters sum = 1.
% http://stackoverflow.com/questions/3644037/help-understanding-a-definitive-integral


%% Defining Parameters
zMax = 600;                         % Maximum Sensor Range
oHit = 20;                          % Std Deviation of my measurement
thetaStep = 360/nRays;
lidarData = lidarData(:,1);


%% 1: Correct range with local measurement noise.
hitProbability = [];
ncdf = [];
normaliser = zeros(nParticles,nRays);
hitProbability = zeros(nParticles,nRays);

for i = 1:nParticles                
normaliser(i,:) = 1 ./(normcdf(zMax,rayData(i,:), oHit) - normcdf(0,rayData(i,:) , oHit));
hitProbabilty(i,:)= normaliser(i,:).*normpdf(transpose(lidarData(:,1)),rayData(i,:), oHit);
end

%% Unexpected objects
lambda = .1;
normaliser = zeros(nParticles,nRays);
unexpProb = zeros(nParticles,1);
unexpProbability = zeros(nParticles,nRays);

for j = 1:nParticles
normaliser(j,:) = 1 ./(expcdf(rayData(j,:),inv(lambda)));
unexpProb(j,:) = exppdf(inv(lambda),lidarData(1,:)); 
unexpProbability(j,:)= normaliser(j,:).*unexpProb(j,:);
end

 
%% Random errors 
randProb(1,:) = unifpdf(lidarData(1,:),0,zMax); %1 number, maybe not necessary beccause of LIDAR script

%% Total density (W.I.P))
totalProbability = 0.95.*hitProbabilty+0.05.*unexpProbability;%+0.1.*randProb;
end
