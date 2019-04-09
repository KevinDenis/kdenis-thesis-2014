function JB_flag=JukeBox(JB_flag,nextNode,GPP_length)
%JUKEBOX Summary of this function goes here
%   Detailed explanation goes here
%   JB_flag :
%   1 = start
%   2 = 25%
%   3 = 50%
%   4 = 75%
%   5 =100% + easter egg :) 

global start_data quarter_data half_data near_data arrived_data easteregg_data

done=nextNode/GPP_length;
Fs=44100;

if JB_flag==1
    soundsc(start_data,Fs);
    JB_flag=2;  
end

if JB_flag == 2 && done>0.25
    soundsc(quarter_data,Fs);
    JB_flag = 3;
end

if JB_flag == 3 && done>0.50
    soundsc(half_data,Fs);
    JB_flag = 4;
end

if JB_flag == 4 && done>0.75
    soundsc(near_data,Fs);
    JB_flag = 5;    % force stop JB during run
end

if JB_flag == 7
    soundsc(arrived_data,Fs);
    pause(3)
    % Happy easter egg :)
    soundsc(easteregg_data,8192);
end
    
end





