function [destPos,destModule ] = destFloorSelect()
%DESTFLOORSELECT Function to select the Destination Position, OUTPUTS [destPos,destModule]
%   Detailed explanation goes here
% startup_Debug
warning off
floorSelected  = false;
load('axisValues.mat')
while floorSelected == false
    prompt = 'What module do you want to go to? (0-14) :  ';
    destModule = input(prompt);
    if isempty(destModule) ~= 1 && destModule >= 0 && destModule <= 14 %Amount of valid modules on GroupT
        floorSelected  = true;
    end
end

if (0<=destModule) && (destModule<=2)       %Load map 0
    destMap = 'floor0.png';
    
elseif (3<=destModule) && (destModule<=6)   %Load map 1
    destMap = 'floor1.png';
    
elseif (7<=destModule) && (destModule<=10)  %Load map 2
    destMap = 'floor2.png';
    figure(1);
    
elseif (11<=destModule) && (destModule<=14) %Load map 3
    destMap = 'floor3.png';
end

figure(1);    
map=imread(destMap);
imshow(map)
title('Destination Position Selector')
axis([axisValues(destModule+1,1) axisValues(destModule+1,2) axisValues(destModule+1,3) axisValues(destModule+1,4)])
grid
hold on
[destPos_L]=ginput2(1);
plot(destPos_L(1),destPos_L(2),'blu*')
destPos = [destPos_L(1),size(map,1)-destPos_L(2)]/100; % [x(m),y(m)]
axis([0 size(map,2) 0 size(map,1)])
hold off
pause(0.3);
clf
close(gcf)
clf
close(gcf)
pause(0.1);
warning on
end


