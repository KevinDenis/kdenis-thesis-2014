function stopRoomba(serPort)
%STOPROOMBA Stop de Roomba et zet hem weer in start

%% Parameters
v = 0;
r = inf;
Start=128;
Safe=131;

SetFwdVelRadiusRoomba(serPort,v,r)

fwrite(serPort,Start);  % zet Roomba terug in start modus.
pause(.1)

end

