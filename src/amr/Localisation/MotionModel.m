function [rotAngle,transR,transAngle] = MotionModel(nParticles,dAngle,dDistance,distAngle)
%Motion model for iRobot Roomba values
%Based on Thrun Probabilistic robotics p. 139
%Motion model to generate uncertainty after AMR motion
%STILL W.I.P.

%% Parameters (TBD)
a1 = 0.001;                    %0.0005 ROTATION
%a2 = 0.00;                     %Rotation during translation or 
                                %translation during rotation
a3 = 0.005;                    %0.0005 TRANSLATION
deltaAngle = dAngle*180/pi;     %Angle from odometry convertion to [Degrees]
deltaDistance = dDistance*100;  %Distance from odometry conversion to [centimeters]
deltaDAngle = distAngle*180/pi;

%% Prediction
rotError = normrnd(0,a1*(deltaAngle)^2,nParticles,1);       %Normal Distributed error particles generated +a2*deltaDistance 
transError = normrnd(0,a3*(deltaDistance)^2,nParticles,1);  %Normal Distributed error particles generated +a2*deltaAngle
transRotError = normrnd(0,a1*(deltaDAngle)^2,nParticles,1);
rotAngle = deltaAngle - rotError;                           %Matrix with rotation angles for all particles
transR = deltaDistance- transError;                         %Matrix with distances for all particles
transAngle = deltaDAngle - transRotError;
