function goForward(serPort,v,t,ratiomax)
%GOFORWARD Summary of this function goes here
%   Detailed explanation goes here

tmax=ratiomax*t;

acc_time=(t-tmax)/2;
dec_time=(t-tmax)/2;
a=v/acc_time;

time=0;
tic
while time<acc_time
    v_acc=a*time;
    SetFwdVelRadiusRoomba(serPort,v_acc,inf)
    time=toc;
    pause(0.015)
end

SetFwdVelRadiusRoomba(serPort,v,inf)
pause(tmax)

time=0;
tic
while time<dec_time
    v_dec=v-a*time;
    SetFwdVelRadiusRoomba(serPort,v_dec,inf)
    time=toc;
    pause(0.015)
end

SetFwdVelRadiusRoomba(serPort,0,inf)
end

