clearvars -except rawRayData0 rawRayData0b rawRayData1 rawRayData2 rawRayData3
close all
clc
warning off

disp('AMR Navigation Routine: (c) Kevin Denis, Alexander Meynen 2014-2015')
disp(' ')
disp('-------------------------------------------------------------------')
disp(' ')
disp('  Loading Directories:')
path = fileparts( mfilename('fullpath') );

roombapath = fullfile(path, 'Roomba');
if exist(roombapath,'dir')
    addpath(roombapath);
    startup_Roomba
end

lidarpath = fullfile(path, 'Lidar');
if exist(lidarpath,'dir')
    addpath(lidarpath);
    startup_Lidar
end

localisationpath = fullfile(path, 'Localisation');
if exist(localisationpath,'dir')
    addpath(localisationpath);
    startup_Localisation
end

navigationpath = fullfile(path, 'Navigation');
if exist(navigationpath,'dir')
    addpath(navigationpath);
    startup_Navigation
end


miscpath = fullfile(path, 'MISC');
if exist(miscpath,'dir')
    addpath(miscpath);
    startup_MISC
end

mappath = fullfile(path, 'Maps');
if exist(mappath,'dir')
    addpath(mappath);
    startup_Maps
end

jbpath = fullfile(path, 'JukeBox');
if exist(jbpath,'dir')
    addpath(jbpath);
    startup_JB
end



disp(' ')
disp('-------------------------------------------------------------------')
disp(' ')

if (exist('rawRayData0', 'var') ~= 1)
    load('rawRayDataFloor0.mat');
end
if (exist('rawRayData0b', 'var') ~= 1)
     load('rawRayDataFloor0b.mat');
end
if (exist('rawRayData1', 'var') ~= 1)
     load('rawRayDataFloor1.mat');
end
if (exist('rawRayData2', 'var') ~= 1)
     load('rawRayDataFloor2.mat');
end
if (exist('rawRayData3', 'var') ~= 1)
     load('rawRayDataFloor3.mat');
end

global rawRayData0 rawRayData0b rawRayData1 rawRayData2 rawRayData3

warning on

clear path roombapath  lidarpath localisationpath navigationpath mappath miscpath
