function [lidarData,robotPos,robotPlot,bel,pred,w]=Localization(nRays,scan,nParticles,steerAngle_R,dDistance,dAngle,bel,robotPlot,rawRayData,map,w,i)
%LOCALIZATION Summary of this function goes here
%   Detailed explanation goes here
[lidarData] = LidarData(nRays,scan); % scan data modified for Alex's use.
[rotAngle,transR,transAngle] = MotionModel(nParticles,steerAngle_R,dDistance,dAngle);
[pred] = Actie(nParticles,bel, rotAngle,transR,transAngle,robotPlot);
[rayData] = getRaysScan(pred,rawRayData,nParticles,nRays,lidarData);
[totalProbability] = Update(nRays,nParticles,rayData,lidarData);
[robotPos,robotPlot,~,~,~,Probability] = Positioning(totalProbability,pred,map,w);
  if rem(i,10)==0 || i<5
   [bel,w] = Resampling(nParticles,Probability,pred);
  else
      bel = pred;
      w=w;
      

end

