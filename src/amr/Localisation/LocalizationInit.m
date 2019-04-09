function [ bel,nParticles,nRays,scan,lidarData,obs_in,obs_out,map,rawRayData,rayData,totalProbability,robotPos,robotPlot,w ] = LocalizationInit(startPos_L,startDir_L,LocalPort,currentMap)
%LOCALIZATIONINIT Summary of this function goes here
%   Detailed explanation goes here

% nRays
[bel,nParticles,nRays] = Initialise(startPos_L,startDir_L);
% scan
disp('waiting for LIDAR data ...')
scan=getLidarScan(LocalPort); % [dist(m),angle(rad)]
disp('... LIDIAR data received')
lidarData = LidarData(nRays,scan);
% localisation
[obs_in,obs_out,map,rawRayData]=Map2Obs(currentMap);
rayData = getRaysScan(bel,rawRayData,nParticles,nRays,lidarData);
totalProbability = Update(nRays,nParticles,rayData,lidarData);
[robotPos,robotPlot,~,w] = PositioningInit(totalProbability,bel,map);

end

