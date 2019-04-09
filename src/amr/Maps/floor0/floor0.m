function [obs_in,obs_out] = floor0()
%[obs_in,obs_out] = floor0()
%   Detailed explanation goes here
split=[NaN,NaN];
n=1;

obs_in_fl0_sprl=csvread('floor0_spiraal.csv');
obs_in_fl0_sprl=obs_in_fl0_sprl(:,1:2)/100;
obs_in_fl0_sprl=[obs_in_fl0_sprl;obs_in_fl0_sprl(1,:);split];

obs_in_fl0_plCR=csvread('floor0_pilaar_CR.csv');
obs_in_fl0_plCR=obs_in_fl0_plCR(:,1:2)/100;
obs_in_fl0_plCR=obs_in_fl0_plCR(1:n:end,:);
obs_in_fl0_plCR=[obs_in_fl0_plCR;obs_in_fl0_plCR(1,:);split];

obs_in_fl0_plE=csvread('floor0_pilaar_E.csv');
obs_in_fl0_plE=obs_in_fl0_plE(:,1:2)/100;
obs_in_fl0_plE=obs_in_fl0_plE(1:n:end,:);
obs_in_fl0_plE=[obs_in_fl0_plE;obs_in_fl0_plE(1,:);split];

obs_in_fl0_plSE=csvread('floor0_pilaar_SE.csv');
obs_in_fl0_plSE=obs_in_fl0_plSE(:,1:2)/100;
obs_in_fl0_plSE=obs_in_fl0_plSE(1:n:end,:);
obs_in_fl0_plSE=[obs_in_fl0_plSE;obs_in_fl0_plSE(1,:);split];

obs_in=[obs_in_fl0_sprl;obs_in_fl0_plCR;obs_in_fl0_plE;obs_in_fl0_plSE];

obs_out = csvread('floor0_buitenomtrek.csv');
obs_out=obs_out(:,1:2)/100;
obs_out=obs_out(1:n:end,:);
obs_out=[obs_out;obs_out(1,:)];

end

