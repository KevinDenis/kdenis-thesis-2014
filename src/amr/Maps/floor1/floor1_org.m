function [obs_in,obs_out] = floor1_org()
%[obs_in,obs_out] = floor1_org()
%   Detailed explanation goes here
split=[NaN,NaN];

obs_in_fl1_sprl=csvread('floor1_binnenomtrek.csv');
obs_in_fl1_sprl=obs_in_fl1_sprl(:,1:2)/100;
obs_in_fl1_sprl=[obs_in_fl1_sprl;obs_in_fl1_sprl(1,:);split];

obs_in_fl1_plNE=csvread('floor1_pilaar_NE.csv');
obs_in_fl1_plNE=obs_in_fl1_plNE(:,1:2)/100;
obs_in_fl1_plNE=[obs_in_fl1_plNE;obs_in_fl1_plNE(1,:);split];

obs_in_fl1_plNW=csvread('floor1_pilaar_NW.csv');
obs_in_fl1_plNW=obs_in_fl1_plNW(:,1:2)/100;
obs_in_fl1_plNW=[obs_in_fl1_plNW;obs_in_fl1_plNW(1,:);split];

obs_in_fl1_plN=csvread('floor1_pilaar_SE.csv');
obs_in_fl1_plN=obs_in_fl1_plN(:,1:2)/100;
obs_in_fl1_plN=[obs_in_fl1_plN;obs_in_fl1_plN(1,:);split];

obs_in_fl1_plSW=csvread('floor1_pilaar_SW.csv');
obs_in_fl1_plSW=obs_in_fl1_plSW(:,1:2)/100;
obs_in_fl1_plSW=[obs_in_fl1_plSW;obs_in_fl1_plSW(1,:);split];

obs_in=[obs_in_fl1_sprl;obs_in_fl1_plNE;obs_in_fl1_plNW;obs_in_fl1_plN;
        obs_in_fl1_plSW];

obs_out = csvread('floor1_buitenomtrek.csv');
obs_out=obs_out(:,1:2)/100;
obs_out=[obs_out;obs_out(1,:)];

end

