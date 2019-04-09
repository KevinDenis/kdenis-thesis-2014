function UDP = LidarInit(LocalPort)
%UDP = LidarInit(LocalPort)
%   InputBufferSize is neeeded, ontherwise it is capped by default at 512.
%   InputBufferSize will never exeed 1400 because 1500/4 = 375, and normaly
%   is will be around 360*4= 1440. (the 4 is because 1 measurement = 4 bytes)

host='LocalHost';   % default : 'LocalHost'
RemotePort=51000;   % not very important
UDP = udp(host, 'RemotePort',RemotePort, 'LocalPort', LocalPort,'InputBufferSize', 1600);
stat=UDP.status;
if ~strcmp(stat,'open')
    fclose(UDP);
end
fopen(UDP);
end

