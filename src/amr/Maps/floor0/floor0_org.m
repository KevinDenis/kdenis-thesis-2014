function [obs_in,obs_out] = floor0_org()
%[obs_in,obs_out] = floor0_org()
%   Detailed explanation goes here
split=[NaN,NaN];

obs_in_fl0_sprl=csvread('floor0_spiraal.csv');
obs_in_fl0_sprl=obs_in_fl0_sprl(:,1:2)/100;
obs_in_fl0_sprl=[obs_in_fl0_sprl;obs_in_fl0_sprl(1,:);split];

obs_in_fl0_plCR=csvread('floor0_pilaar_CR.csv');
obs_in_fl0_plCR=obs_in_fl0_plCR(:,1:2)/100;
obs_in_fl0_plCR=[obs_in_fl0_plCR;obs_in_fl0_plCR(1,:);split];

obs_in_fl0_plCV=csvread('floor0_pilaar_CV.csv');
obs_in_fl0_plCV=obs_in_fl0_plCV(:,1:2)/100;
obs_in_fl0_plCV=[obs_in_fl0_plCV;obs_in_fl0_plCV(1,:);split];

obs_in_fl0_plN=csvread('floor0_pilaar_N.csv');
obs_in_fl0_plN=obs_in_fl0_plN(:,1:2)/100;
obs_in_fl0_plN=[obs_in_fl0_plN;obs_in_fl0_plN(1,:);split];

obs_in_fl0_plNE=csvread('floor0_pilaar_NE.csv');
obs_in_fl0_plNE=obs_in_fl0_plNE(:,1:2)/100;
obs_in_fl0_plNE=[obs_in_fl0_plNE;obs_in_fl0_plNE(1,:);split];

obs_in_fl0_plE=csvread('floor0_pilaar_E.csv');
obs_in_fl0_plE=obs_in_fl0_plE(:,1:2)/100;
obs_in_fl0_plE=[obs_in_fl0_plE;obs_in_fl0_plE(1,:);split];

obs_in_fl0_plNW=csvread('floor0_pilaar_NW.csv');
obs_in_fl0_plNW=obs_in_fl0_plNW(:,1:2)/100;
obs_in_fl0_plNW=[obs_in_fl0_plNW;obs_in_fl0_plNW(1,:);split];

obs_in_fl0_plS=csvread('floor0_pilaar_S.csv');
obs_in_fl0_plS=obs_in_fl0_plS(:,1:2)/100;
obs_in_fl0_plS=[obs_in_fl0_plS;obs_in_fl0_plS(1,:);split];

obs_in_fl0_plSE=csvread('floor0_pilaar_SE.csv');
obs_in_fl0_plSE=obs_in_fl0_plSE(:,1:2)/100;
obs_in_fl0_plSE=[obs_in_fl0_plSE;obs_in_fl0_plSE(1,:);split];

obs_in_fl0_plW=csvread('floor0_pilaar_W.csv');
obs_in_fl0_plW=obs_in_fl0_plW(:,1:2)/100;
obs_in_fl0_plW=[obs_in_fl0_plW;obs_in_fl0_plW(1,:);split];

obs_in=[obs_in_fl0_sprl;obs_in_fl0_plCR;obs_in_fl0_plCV;obs_in_fl0_plN; ...
        obs_in_fl0_plNE;obs_in_fl0_plE;obs_in_fl0_plNW;obs_in_fl0_plS;...
        obs_in_fl0_plSE;obs_in_fl0_plW;];

obs_out = csvread('floor0_buitenomtrek.csv');
obs_out=obs_out(:,1:2)/100;
obs_out=[obs_out;obs_out(1,:)];

end

