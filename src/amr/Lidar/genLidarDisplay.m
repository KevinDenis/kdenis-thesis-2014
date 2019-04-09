%% Clean matlab
clear all
close all
clc
if ~isempty(instrfindall)
    fclose(instrfindall);
    delete(instrfindall);
end

%% Parameters
LocalPort=51068;
n=100;
dt=zeros(n,1);

%% read data
for i=1:n
    tic
    scan = getLidarScan(LocalPort);
    dt(i)=toc;
    dist=(scan(:,1));
    angle=(scan(:,2));
    [x,y]=pol2cart(angle,dist);
    figure(1)
    scatter(x,y)
    axis([-6,6,-6,6])
    text(5,5,num2str(i));
    pause(0.01);
end

pd = fitdist(dt,'Normal')