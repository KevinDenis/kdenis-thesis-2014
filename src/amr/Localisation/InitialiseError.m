function [bel,nParticles,nRays] = Initialise(robot,angle,obs_in,obs_out)
%INITIALISE [bel,nParticles,nRays] = Initialise()
%Only used first repetition, parameters get defined (nParticles, nRays)
%Particles get defined normally distributed around user input with a
%defined standard deviation, all angles in this algorithm are in DEGREES
%(front robot = 0 => 359.

%%  Define constants
nParticles = 1000; %Define amount of particles
nRays = 18;
oPos = 80; %Error on the user defined position [cm]
oAnglePos = 20;   %Error on the user defined angle

%set(gca,'YDir','reverse')

%% Get approximate starting position +- 0.5m

% close all;
% Initiate figure
% figure(1);
% bw = imread('floor0.png');
% imshow(bw)
% axis on
% grid on
% hold on
% 
% f = text(-90,-40,'click/enter starting point');
% [robot] = ginput(1);
% plot(robot(1),robot(2),'blu*')
% set(f,'String','click/enter facing angle from robot');
% [angle] = ginput(1);
% plot(angle(1),angle(2),'blu*')
% pause(0.4);
% close;


angle = rad2deg(atan2(angle(1)-robot(1),angle(2)-robot(2)));



%% Initiate particles around starting position, homogeneous
toGenerate = nParticles;
bel = zeros(nParticles,3);
while toGenerate ~= 0 
    x_points(1,:)=robot(2)+oPos*randn(toGenerate,1); % Entering X data in initial belief matrix
    y_points(1,:)=robot(1)+oPos*randn(toGenerate,1); % Entering Y data in inital belief matrix
    assignin('base', 'y_points', y_points)
    in=inpolygon(x_points,y_points,obs_in(:,1),obs_in(:,2));
    x_points(in)=[];
    y_points(in)=[];
    in=inpolygon(x_points,y_points,obs_out(:,1),obs_out(:,2));
    x_points(~in)=[];
    y_points(~in)=[];
    assignin('base', 'x_points', x_points)
    bel(:,1) = [bel(:,1);x_points];
    bel(:,2) = [bel(:,2);y_points];

    
    toGenerate= nParticles - length(bel);

end

randtheta = angle + oAnglePos*randn(nParticles,1);   %Initiate Theta particles
bel(:,3) = bel(:,3) + randtheta;    %Entering theta data in inital belief matrix

for i = 1:length(bel)
    if bel(i,3) >360
        bel(i,3) = angle-360;
    end
    if bel(i,3) <-360
        bel(i,3) = angle+360;
    end
    
    
end
% assignin('base', 'bel', bel);
% figure()
% bw = imread('laboMap.bmp');
% imshow(bw)
% axis on
%
% grid on
% hold on
% scatter(bel(:,1),bel(:,2));


end

