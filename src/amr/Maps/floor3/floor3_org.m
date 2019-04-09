function [obs_in,obs_out] = floor3_org()
%[obs_in,obs_out] = floor3_org()
%   Detailed explanation goes here
split=[NaN,NaN];
obs_in_fl3_sprl=csvread('floor3_binnencirkel.csv');
obs_in_fl3_sprl=obs_in_fl3_sprl(:,1:2)/100;
obs_in_fl3_sprl=[obs_in_fl3_sprl;obs_in_fl3_sprl(1,:);split];

obs_in_fl3_plNE=csvread('floor3_pilaar_NE.csv');
obs_in_fl3_plNE=obs_in_fl3_plNE(:,1:2)/100;
obs_in_fl3_plNE=[obs_in_fl3_plNE;obs_in_fl3_plNE(1,:);split];

obs_in_fl3_plNW=csvread('floor3_pilaar_NW.csv');
obs_in_fl3_plNW=obs_in_fl3_plNW(:,1:2)/100;
obs_in_fl3_plNW=[obs_in_fl3_plNW;obs_in_fl3_plNW(1,:);split];

obs_in_fl3_plSE=csvread('floor3_pilaar_SE.csv');
obs_in_fl3_plSE=obs_in_fl3_plSE(:,1:2)/100;
obs_in_fl3_plSE=[obs_in_fl3_plSE;obs_in_fl3_plSE(1,:);split];

obs_in_fl3_plSW=csvread('floor3_pilaar_SW.csv');
obs_in_fl3_plSW=obs_in_fl3_plSW(:,1:2)/100;
obs_in_fl3_plSW=[obs_in_fl3_plSW;obs_in_fl3_plSW(1,:);split];

obs_in=[obs_in_fl3_sprl;obs_in_fl3_plNE;obs_in_fl3_plNW;...
        obs_in_fl3_plSE;obs_in_fl3_plSW];

obs_out = csvread('floor3_buitenomtrek.csv');
obs_out=obs_out(:,1:2)/100;
obs_out=[obs_out;obs_out(1,:)];
end

