function [bel,nParticles,nRays] = Initialise(robot,angle)
%INITIALISE [bel,nParticles,nRays] = Initialise()
%Only used first repetition, parameters get defined (nParticles, nRays)
%Particles get defined normally distributed around user input with a
%defined standard deviation, all angles in this algorithm are in DEGREES
%(front robot = 0 => 359.

%%  Define Parameters
nParticles = 500;      %Define amount of particles
nRays = 36;             %Amount of Rays used for localization (best to use 18/36)
oPos = 75;             %Error on the user defined position [cm]
oAnglePos = 20;         %Error on the user defined angle
angle = rad2deg(atan2(angle(1)-robot(1),angle(2)-robot(2)));    %Defining angle in Localization system

%% Initiate particles around starting position, homogeneous
bel = zeros(nParticles,3);                          %Creating believe matrix
randx =  robot(2)+ oPos*randn(nParticles,1);        %Initiate X particles
randy = robot(1) + oPos*randn(nParticles,1);        %Initiate Y particles
randtheta = angle + oAnglePos*randn(nParticles,1);  %Initiate Theta particles
bel(:,1) = bel(:,1) + randx;                        %Entering X data in initial belief matrix
bel(:,2) = bel(:,2) + randy;                        %Entering Y data in inital belief matrix
bel(:,3) = bel(:,3) + randtheta;                    %Entering theta data in inital belief matrix

for i = 1:length(bel)   %Check if particles are inserted in a valid position, STILL TO BE CHANGED
    if  bel(i,1) <3
        bel(i,1) = robot(1)+ 5*randn(1);
        bel(i,2) = robot(2)+ 5*randn(1);
        
    end
    if bel(i,2) <3
        bel(i,1) = robot(1)+ 5*randn(1);
        bel(i,2) = robot(2)+ 5*randn(1);
    end
    if bel(i,1) >4998
        bel(i,1) = robot(1)+ 5*randn(1);
        bel(i,2) = robot(2)+ 5*randn(1);
    end
    if bel(i,2) >4998
        bel(i,1) = robot(1)+ 5*randn(1);
        bel(i,2) = robot(2)+ 5*randn(1);
        
    end
    if bel(i,3) >360
        bel(i,3) = angle-360;
    end
    if bel(i,3) <-360
        bel(i,3) = angle+360;
    end
    
    
end

end

