function [ startPos_L,startDir_L,startPos,startModule,currentMapID] = startFloorSelect()
%STARTFLOORSELECT Function to select the Start Position, OUTPUTS [startPos,startDir,startModule]
%   Detailed explanation goes here
% startup_Debug
warning off
load('axisValues.mat')
floorSelected  = false;
while floorSelected == false
    prompt = 'On what module are you starting? (0-14) :  ';
    startModule = input(prompt);
    if isempty(startModule) ~= 1 && startModule >= 0 && startModule <= 14 %Amount of valid modules on GroupT
        floorSelected  = true;
    end
end

if (0<=startModule) && (startModule<=2) %Load map 0
    startMap = 'floor0.png';
    currentMapID = 1;
elseif (3<=startModule) && (startModule<=6) %Load map 1
    startMap = 'floor1.png';
    currentMapID = 3;
elseif (7<=startModule) && (startModule<=10) %Load map 2
    startMap = 'floor2.png';  
    currentMapID = 4;
elseif (11<=startModule) && (startModule<=14) %Load map 3
    startMap = 'floor3.png';
    currentMapID = 5;
end
figure(1);    
map=imread(startMap);
imshow(map)
title('Start Position/Direction Selector')
axis([axisValues(startModule+1,1) axisValues(startModule+1,2) axisValues(startModule+1,3) axisValues(startModule+1,4)])
grid
hold on
[startPos_L] = ginput2(1);
plot(startPos_L(1),startPos_L(2),'blu*')
[startDir_L] = ginput2(1);
plot(startDir_L(1),startDir_L(2),'blu*')
startDir = [startDir_L(1),size(map,1)-startDir_L(2)]/100; % [x(m),y(m),th(rad)]
startPos = [startPos_L(1),size(map,1)-startPos_L(2)]/100; % [x(m),y(m),th(rad)]
th=atan2(startDir(1)-startPos(1),startDir(2)-startPos(2));
startPos=[startPos,th];
pause(0.01)
clf
close(gcf)
warning on
end