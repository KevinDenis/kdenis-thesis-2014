function [dtheta,endLeftTicOrg,endRightTicOrg] = getTrueAngle(serPort,v,startLeftTic,startRightTic)
%GETDISTANGLE Summary of this function goes here
%   Detailed explanation goes here
%% Robot constants 
b=0.233;
circ=0.232; % m/revolution (circumference)
revTic=500;
overflowTic=65535;
ticDist=circ/revTic;
OF=false;
maxdTic=500;
smallerZone=maxdTic;
biggerZone=overflowTic-maxdTic;

% get current encoder values
[endLeftTicOrg,endRightTicOrg] = getEncoders(serPort);
endLeftTic=endLeftTicOrg;
endRightTic=endRightTicOrg;

if  abs(startLeftTic-endLeftTic) < 10 || abs(startRightTic-endRightTic) < 10
    dtheta=0;
    endLeftTicOrg=startLeftTic;
    endRightTicOrg=startRightTic;
else
    if v >= 0
        if endLeftTic > startLeftTic && endLeftTic>biggerZone && startLeftTic<smallerZone
            startLeftTic=startLeftTic+overflowTic;
            if ~OF
                disp('I just overflowed')
                OF=true;
            end            
        end
        if endRightTic < startRightTic && endRightTic<smallerZone && startRightTic>biggerZone
            endRightTic=endRightTic+overflowTic;
            if ~OF
                disp('I just overflowed')
                OF=true;
            end
        end
        % Calculate Distance and Angle of both wheels
        ds_left =ticDist*(endLeftTic -startLeftTic );
        ds_right=ticDist*(endRightTic-startRightTic);
        dtheta= (ds_right-ds_left)/b;
    else
        if endLeftTic < startLeftTic  && endLeftTic<smallerZone && startLeftTic>biggerZone
            endLeftTic=endLeftTic+overflowTic;
            if ~OF
                disp('I just overflowed in Left')
                OF=true;
            end
        end
        if endRightTic > startRightTic  && endRightTic>biggerZone && startRightTic<smallerZone
            startRightTic=startRightTic+overflowTic;
            if ~OF
                disp('I just overflowed in Right')
                OF=true;
            end
        end
        % Calculate Distance and Angle of both wheels
        ds_left =ticDist*(endLeftTic -startLeftTic );
        ds_right=ticDist*(endRightTic-startRightTic);
        dtheta= (ds_right-ds_left)/b;
    end
    
end

