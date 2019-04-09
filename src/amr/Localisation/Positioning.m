function [position,plotPos,indices,meanProbability,resultReliability,prevProbability] = Positioning(totalProbability,pred,map,w)
%POSITIONING Outputs best position estimate 
%   Wanted output from the MCL algoritm
% 
% for j = 1:length(totalProbability)
%     meanProbability(j)= prod(totalProbability(j,:));
%         if meanProbability(j) == Inf;
%         meanProbability(j) = 0;
%     end
% end

meanProbability  = mean(totalProbability,2); %Takes mean from all the weights of a particle
for i=1:length(meanProbability)              %Check if values are valid
    if meanProbability(i) == Inf;
        meanProbability(i) = 0;
    end
end
prevProbability = meanProbability.*w;

indices = find(prevProbability == max(prevProbability)); %Save index of particle with highest mean
resultReliability = max(prevProbability);                %The probability of best particle
xPos = pred(indices(1),1);                               %Select xPos
yPos = pred(indices(1),2);                               %Select yPos
thetaPos = fullAngleDeg(pred(indices(1),3));                           %Deleted shortest angle degree

plotPos  = [xPos,yPos,thetaPos];
position = [plotPos(2)/100,(size(map,1)-plotPos(1))/100,shortestAngle(plotPos(3)*pi/180-pi/2)];

end
