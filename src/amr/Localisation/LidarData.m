function [lidarData] = LidarData(nRays,scan)
%LIDARSCAN Summary of this function goes here
%   Gets Sensor data from sensor and filters data to the amount of data
%   necessary for localization (depending on the amount of rays used during localization! = nRays)


%% Get Lidar Data
%Basic funtion, distance in meters, angles in degrees
dist=scan(:,1)*100;                                 % Converting to cm
angle=round(scan(:,2)*180/pi);                      % Rounding the angles
rawLidarData = horzcat(dist,angle);                 % Merging to column matrices
assignin('base', 'rawLidarData', rawLidarData);     % Assign a variable in workspace for debugging

%% Selecting rays
deltaAngle = floor(length(scan)/nRays);             %Step between each angle depends on number of scans made and required
lidarData = zeros(nRays,2);                         %Creating lidarData matrix which holds the data for the selected measurements
for j = 0:nRays-1
    lidarData(j+1,:) = rawLidarData(1+j*deltaAngle,:); 
end
% assignin('base', 'lidarData', lidarData);


