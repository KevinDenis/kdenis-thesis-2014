function [rayData] = getRaysScan( pred,rawRayData,nParticles,nRays,lidarData)
%GETRAYSSCAN Look up correct data in rayData tables [rayData] = getRaysScan( pred,rawRayData,nParticles,nRays,lidarData)
%   The raycasting process is done offline instead of online, this makes
%   the algorithm faster and allows the process to be reduced to a look up
%   function. The tables are created with the raycasting function and
%   Dimension 1 are the X-coordinates, Dimension 2 are the Y-coordinates,
%   Dimension 3 are the angles.

%% Preparing particles
xLocs = round(pred(:,1)/5);         %xLocations of particles in table (/5 for SCALE)
yLocs = round(pred(:,2)/5);         %yLocations of particles in table (/5 for SCALE)
degrees = round(pred(:,3));         %%Angular information of particles (degrees)

%% Initializing matrices
rowsToScan(:,1) = lidarData(:,2);               %Copying necessary angles in to "rowsToScan" matrix
rayData = zeros(nParticles,nRays);              %Initialising rayData matrix
theoryScan = zeros(nParticles,nRays);           %Theoretical scan values matrix is initialised

%% Selecting Process
for i = 1:nParticles                            %For every particle
    theoryScan(i,:) = rowsToScan + degrees(i);  %The angle of the measurement has to be corrected
end                                             %with the angle of the particle.
theoryScan=fullAngleDeg(theoryScan);            %Checked if angles are still between 1-360
assignin('base', 'theoryScan', theoryScan);     %Variable for debugging

for l = 1:nParticles                            %For every particle
    for m = 1:nRays                             %For each ray of the particle
        rayData(l,m) = rawRayData(xLocs(l),yLocs(l),theoryScan(l,m));   %The raydata is looked up in the matrix
    end                                         %Added to rayData matrix for further calculation
end


