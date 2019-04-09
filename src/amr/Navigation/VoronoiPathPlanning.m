function xy_opt_path = VoronoiPathPlanning(xy_start,xy_dest,obs_in,obs_out,d_thr)
% xy_opt_path = VoronoiPathPlanning(xy_start,xy_dest,obs_in,obs_out,d_thr)
%   Important inupts :
%   * xy_start [x(m),y(m)]Start position of robot. Will be added to Voronoi
%                       Diagram automaticly 
%   * xy_dest [x(m),y(m)] Destination position of robot. Will be added to
%                       Voronoi Diagram automaticly 
%   * d_thr(m)          Threshold for distance between nodes between 
%                       destination and clossest Voronoi Node. Will create
%                       as many extra node as needed. This is for smoothing
%                       reasons.
%   * obs_in [x(m),y(m)]  Contains each polygon-obstacle where points inside 
%                       will be deleted. Each polygon should start and end
%                       with the same coordinated. Each different polygon
%                       is separated with a NaN.
%   * obs_out [x(m),y(m)] Contains each polygon-obstacle where points inside
%                       will be deleted. Each polygon should start and end
%                       with the same coordinated. Each different polygon
%                       is separated with a NaN.
%
% The Voronoi Path Planning code was inspired from the following YouTube video https://www.youtube.com/watch?v=SRg9l0GmQMY.
%
%% Parameters
% Start & Dest. Just making sure there is no theta in xy_start.
xy_start = [xy_start(1),xy_start(2)];
xy_dest = [xy_dest(1),xy_dest(2)];
% Obstacle
% obs_in
if ~isempty(obs_in)         % Just controlling if there is something in obs_in
    x_obs_in=obs_in(:,1);
    y_obs_in=obs_in(:,2);
else
    x_obs_in=[];
    y_obs_in=[];
end
% obs_out
x_obs_out=obs_out(:,1);
y_obs_out=obs_out(:,2);
% Grouping
x_obs=[x_obs_in;x_obs_out];
y_obs=[y_obs_in;y_obs_out];

% Filtering out NaN's for polysplitting just for Voronoi
x_obs_v=x_obs;
y_obs_v=y_obs;
toDelete=[];
for i=1:length(x_obs)
    if isnan(x_obs(i))
        toDelete=[toDelete;i];
    end
end
x_obs_v(toDelete,:)=[];
y_obs_v(toDelete,:)=[];

% Voronoi Diagram created with the obstacle points
warning off
[vx,vy] = voronoi(x_obs_v,y_obs_v);
warning on

%% redraw obstacles
vx_new=vx;
vy_new=vy;
% clf;
% plot(vx_new,vy_new,'b.-'); hold on;
% plot(xv,yv,'k-','LineWidth',2);

%% find the points outside the polygon_out and delete them
vx_start=vx_new(1,:);
vy_start=vy_new(1,:);
in = inpolygon(vx_start,vy_start,x_obs_out,y_obs_out);
vx_new(:,~in)=[];
vy_new(:,~in)=[];

vx_end=vx_new(2,:);
vy_end=vy_new(2,:);
in = inpolygon(vx_end,vy_end,x_obs_out,y_obs_out);
vx_new(:,~in)=[];
vy_new(:,~in)=[];

%% find the points inside the polygon_in and delete them
if ~isempty(obs_in)
    vx_start=vx_new(1,:);
    vy_start=vy_new(1,:);
    in = inpolygon(vx_start,vy_start,x_obs_in,y_obs_in);
    vx_new(:,in)=[];
    vy_new(:,in)=[];

    vx_end=vx_new(2,:);
    vy_end=vy_new(2,:);
    in = inpolygon(vx_end,vy_end,x_obs_in,y_obs_in);
    vx_new(:,in)=[];
    vy_new(:,in)=[];
end

%% add starting point and find closest Voronoi Node
vx_all = vx_new(:);
vy_all = vy_new(:);

dr = kron(ones(length(vx_all),1),xy_start) - [vx_all vy_all];
[~, min_id] = min(sum(dr.^2,2));

vx_new = [vx_new [xy_start(1); vx_all(min_id)]];
vy_new = [vy_new [xy_start(2); vy_all(min_id)]];

%% add destination point and find closest Voronoi Node
dr = kron(ones(length(vx_all),1),xy_dest) - [vx_all vy_all];
[~, min_id] = min(sum(dr.^2,2));

vx_new = [vx_new [xy_dest(1); vx_all(min_id)]];
vy_new = [vy_new [xy_dest(2); vy_all(min_id)]];

%% construct of graph
xy_all = unique([vx_new(:) vy_new(:)], 'rows');
dv = [vx_new(1,:); vy_new(1,:)] - [vx_new(2,:); vy_new(2,:)];
edge_dist = sqrt(sum(dv.^2));

G = sparse(size(xy_all,1),size(xy_all,1)); % sparse for quicker computation

for kdx = 1:length(edge_dist)
    xy_s = [vx_new(1,kdx) vy_new(1,kdx)];
    idx = find(sum((xy_all-kron(ones(size(xy_all,1),1),xy_s)).^2,2)==0);
    xy_d = [vx_new(2,kdx) vy_new(2,kdx)];
    jdx = find(sum((xy_all-kron(ones(size(xy_all,1),1),xy_d)).^2,2)==0);
    G(idx,jdx) = edge_dist(kdx);
    G(jdx,idx) = edge_dist(kdx);
end

%% starting index and destination index
st_idx = find(sum((xy_all-kron(ones(size(xy_all,1),1),xy_start)).^2,2)==0);
dest_idx = find(sum((xy_all-kron(ones(size(xy_all,1),1),xy_dest)).^2,2)==0);

%% Dijkstra's algoritm to find shortes path
[dist,path,pred] = graphshortestpath(G,st_idx,dest_idx);
xy_opt_path = xy_all(path,:); % select all collums from choses indexes

% %% adding interpolated path between clossest voronoi node and destination
% % the NodeInterpolation function will automaticaly recover end-1 and end
% n=length(xy_opt_path);
% % determining the number of interpolation points needed, by using d_thr
% dx_int = xy_opt_path(end,1) - xy_opt_path(end-1,1);
% dy_int = xy_opt_path(end,2) - xy_opt_path(end-1,2);
% dr_int = sqrt(dx_int^2+dy_int^2);
% points = (round(dr_int/d_thr)+1)*2;
% xy_opt_path_temp = xy_opt_path(1:n-2,:); % deleting two last rows
% xy_int=NodeInterpolation(xy_opt_path(end-1,:),xy_opt_path(end,:),points);
% xy_opt_path_temp = [xy_opt_path_temp;xy_int];
% xy_opt_path = xy_opt_path_temp;

%% plot optimal path
% figure()
% scatter(x_obs,y_obs, 'k'); hold on;
% plot(vx_new,vy_new,'b.-');  hold on;
% plot(xy_opt_path(:,1),xy_opt_path(:,2), 'go-','LineWidth',2);
% hold off;
end
