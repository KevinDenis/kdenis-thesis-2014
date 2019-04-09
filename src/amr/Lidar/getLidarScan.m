function scan=getLidarScan(LocalPort)
%scan=getLidarScan(LocalPort)
%   Input Parameters:
%   LocalPort   = has to be the same as C++ code, used for LidarInit
%
%   Output parameters:
%   scan        = dist[m],angle[°]
%
%   Notes :
%   reads the data send over UDP from the C++ code by RPLIDAR & Lin Zang
%   UDP object is here created and cleared every cycle (explanation below)
%   with LidarInit
%   UDP.LocalPort must be the same as C++ code
%   UDP.InputBufferSize has to be specefied, default to low
%   there are 360 measurements, 4 bytes per measurement, at least 1440
%
%   IMPORTANT REMARKS
%   * To be certain to have the newest data from the lidar, the UDP object
%     has to be initiated and deleted every cycle. flushinput worked slower
%     in this case, then creating/delete.
%   * Receved angle is sometimes not inb the wright order, therefor sortrows
%   * while true loop is there to wait until correct data has been send.
%     WARNING --> this could lead to a crash (never happend)
%   
%   UDP obj
%   host='LocalHost';   % default : 'LocalHost'
%   RemotePort=51000;   % not very important
%   LocalPort=51068;    % Same as C-code
%   u = udp(host, 'RemotePort',RemotePort, 'LocalPort', LocalPort,'InputBufferSize', 1600);

UDP = LidarInit(LocalPort);
while true   
    data = fread(UDP);            
    n=length(data);
    % check if valid && enough measurements
    if rem(n,4) == 0 && n>100
        % Allocate space
        angle=zeros(n/4,1);
        dist=zeros(n/4,1);
        j=0;        
        for i=1:4:n % for (pos = 0;pos<(int)n;pos+=4){
            j=j+1;
            % 2 bytes each, needs to be converted to float
            % angle is in deg, dist is in mm 
            angle_short=uint8([data(i+0) data(i+1)]);                               % temp_angle=((unsigned short)(buf[pos+1]<<8)&0x0000FF00)|(buf[pos]&0x000000FF);
            angle_int=typecast(angle_short,'uint16'); 
            angle(j)=double(bitshift(angle_int,-1,'uint16'))/64;                    % temp_angle_float=(temp_angle>>RPLIDAR_RESP_MEASUREMENT_ANGLE_SHIFT)/64.0f;

            dist_short=uint8([data(i+2) data(i+3)]);                                % temp_dist=((unsigned short)(buf[pos+3]<<8)&0x0000FF00)|(buf[pos+2]&0x000000FF);
            dist_int=typecast(dist_short,'uint16');
            dist(j) = double(dist_int)/4;                                           % temp_dist_float=temp_dist/4.0f;   
        end
        scan=sortrows([dist/1000,fullAngle(-angle*pi/180)],2); %[dist(m),angle(rad)]
        scan=scan(scan(:,1)~=0,:); % this is quicker than below (commented)
%         for i=1:length(scan)
%             if scan(i,1) == 0
%                 toDelete = [toDelete;i];
%             end
%         end
%         scan(toDelete,:)=[];
        % check enough valid (non-zero) measurements
        if length(scan)>100
            break
        end
    end       
end
% Delete UDP for clean next scan
fclose(UDP);
delete(UDP);
clear UDP
