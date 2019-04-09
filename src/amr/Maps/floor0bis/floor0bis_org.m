function [obs_in,obs_out] = floor0bis_org()
%[obs_in,obs_out] = floor0bis_org()
%   Detailed explanation goes here
obs_in=[];
obs_out = csvread('floor0bis_buitenomtrek.csv');
obs_out=obs_out(:,1:2)/100;
obs_out=[obs_out;obs_out(1,:)];
end

