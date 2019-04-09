function [bel,w] = Resampling(nParticles,prevProbability,pred)
%RESAMPLING Resample function
%   After each localization the robot's particle cloud has to be filtered
%   so the best particles are kept and the worst stay.
N = nParticles;
w = prevProbability/sum(prevProbability); %Normalizing
weight = cumsum(w);
% bel = zeros(nParticles,3); %W.I.P
addit = 1/N;
stt = addit*rand(1);
selection_points = [stt : addit : stt+(N-1)*addit];
j=1;
for i = 1:N
    while selection_points(i)>=weight(j);
        j=j+1;
    end
    
    bel(i,1) = pred(j,1); %AANGEPAST
    bel(i,2) = pred(j,2);
    bel(i,3) = fullAngleDeg(pred(j,3));  %+5*randn(1)
    w(i) = w(j);
end
% bel = pred;
% w = w;
end



