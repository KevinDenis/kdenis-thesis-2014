% Code to perform Raycasting on a Supplied Map to return simulated Lidar
% Range values.
% % Author- Alexander Meynen based on Shikhar Shrestha, IIT Bhubaneswar
% % Returned Range values are obtained on scanning clockwise.
function [rays]=CastRays()
%% Defining range

lidarrange = 120; %Lidarrange/scale
nRays = 360;    %Raycasting resolution
thetastep=360/nRays; %Defining ray step angle
%% Initiating arrays
map = not(imread('861-02_BO_GP_03_AI-Model.bmp')); %Occupancy grid map, white empty,black occupied
[mapX,mapY] = size(map);
rays=zeros(mapX,mapY,nRays,'int16');
r=linspace(0,lidarrange,1000);

%% Check if inside obstacle
for t = 1:size(map,2)
    xc = t;
    for s = 1:size(map,1)
        yc = s;
        if map(yc,xc)==1 %if inside
            rays(yc,xc,:) = 0; %zero
        else
            
            %Only use for plotting
            %     figure(2);
            %     hold off;
            %     imshow(map);
            %     hold on;
            %     plot(xc,yc,'b*');
            
            %% Real ray-cating
            for i=1:nRays %For every angle
                theta=-thetastep*i+90; %Start angle
                x=xc+(r*cosd(theta)); %X coordinates of 1 ray
                y=yc+(r*sind(theta));   %Y coordinates of 1 ray
                % Removing points out of map
                for k=1:numel(x)
                    if x(k)>size(map,2) || y(k)>size(map,1) || x(k)<=0 || y(k)<=0   %if point is outside map or negative
                        index = k;
                        break
                    end
                end
                x(k:end)=[]; %delete all X-coordinates
                y(k:end)=[]; %delete all Y-coordinates
                
                %Only use for plotting
                %         figure(2);
                %         plot(x,y,'r');
                
                %Computing Intersections
                xint=round(x); %round X
                yint=round(y);  %round Y
                % Correcting zero map indexing
                for l=1:numel(xint) %For every ray element
                    if xint(l)==0 %If ray element is equal to 0 make 1
                        xint(l)=1;
                    end
                    if yint(l)==0 %If ray element is equal to 0 make 1
                        yint(l)=1;
                    end
                end
                xb = [0];
                yb = [0];
                for j=1:numel(xint) %For every ray coordinate save coordinates of end point
                    if map(yint(j),xint(j)) == 1
                        xb = x(j);
                        yb = y(j);
                        break;
                    end
                end
                %only use if plotting
                %         figure(2);
                %         plot(xb,yb,'g*');
                %% Calculate distances between start point and end point
                dist=sqrt((xc-xb).^2 + (yc-yb).^2);
                if dist > lidarrange %if distance is bigger than lidarrange => distance is lidarrange
                    dist = lidarrange;
                end
                rays(yc,xc,i) =dist*5;
                
            end
            
            % Converting to mm from pixels.
            %rays=rays*1*pixeltocm;
            % % % % % % % range=flipud(range);
        end
    end
end