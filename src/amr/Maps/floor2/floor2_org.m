function [obs_in,obs_out] = floor2_org()
%[obs_in,obs_out] = floor2_org()
%   Detailed explanation goes here
split=[NaN,NaN];

obs_in_fl2_sprl=csvread('floor2_binnencirkel.csv');
obs_in_fl2_sprl=obs_in_fl2_sprl(:,1:2)/100;
obs_in_fl2_sprl=[obs_in_fl2_sprl;obs_in_fl2_sprl(1,:);split];

obs_in_fl2_plNE=csvread('floor2_pilaar_NE.csv');
obs_in_fl2_plNE=obs_in_fl2_plNE(:,1:2)/100;
obs_in_fl2_plNE=[obs_in_fl2_plNE;obs_in_fl2_plNE(1,:);split];

obs_in_fl2_plNW=csvread('floor2_pilaar_NW.csv');
obs_in_fl2_plNW=obs_in_fl2_plNW(:,1:2)/100;

obs_in_fl2_plNW=[obs_in_fl2_plNW;obs_in_fl2_plNW(1,:);split];

obs_in_fl2_plSE=csvread('floor2_pilaar_SE.csv');
obs_in_fl2_plSE=obs_in_fl2_plSE(:,1:2)/100;

obs_in_fl2_plSE=[obs_in_fl2_plSE;obs_in_fl2_plSE(1,:);split];


obs_in_fl2_plSW=csvread('floor2_pilaar_SW.csv');
obs_in_fl2_plSW=obs_in_fl2_plSW(:,1:2)/100;
obs_in_fl2_plSW=[obs_in_fl2_plSW;obs_in_fl2_plSW(1,:);split];


obs_in=[obs_in_fl2_sprl;obs_in_fl2_plNE;obs_in_fl2_plNW;...
        obs_in_fl2_plSE;obs_in_fl2_plSW];

obs_out = csvread('floor2_buitenomtrek.csv');
obs_out=obs_out(:,1:2)/100;
obs_out=[obs_out;obs_out(1,:)];

end

