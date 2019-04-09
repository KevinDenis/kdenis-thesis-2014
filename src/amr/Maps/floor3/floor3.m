function [obs_in,obs_out] = floor3()
%[obs_in,obs_out] = floor3()
%   Detailed explanation goes here
split=[NaN,NaN];
n=1;
obs_in_fl3_sprl=csvread('floor3_binnencirkel.csv');
obs_in_fl3_sprl=obs_in_fl3_sprl(:,1:2)/100;
obs_in_fl3_sprl=obs_in_fl3_sprl(1:n:end,:);
obs_in_fl3_sprl=[obs_in_fl3_sprl;obs_in_fl3_sprl(1,:);split];

obs_in=obs_in_fl3_sprl;

obs_out = csvread('floor3_buitenomtrek.csv');
obs_out=obs_out(:,1:2)/100;
obs_out=obs_out(1:n:end,:);
obs_out=[obs_out;obs_out(1,:)];
end

