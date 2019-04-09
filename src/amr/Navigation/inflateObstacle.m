function D = inflateObstacle(scan,R)
%D = inflateObstacle(scan,R)
%   This function will inflate all obstacles seen from the scan, by the
%   radius of the robot. This is done twice, once going in CCW and CW (both
%   directions give different result, combining them will result in safest
%   distance calculation, without loss in computational speed)

n=length(scan);
d=scan(:,1);                    % m, afstand tot obstacle

D = d - R;                      % Allocate memory for D, true dist to obj
D_pos = D;                      % Allocate memory for D_pos, true dist to obj
D_neg = D;                      % Allocate memory for D_neg, true dist to obj

% CCW
for i=1:n
    angle_search = tan(R/d(i));
    j_search = round(angle_search*180/pi)+1;
    for j= -j_search:1:j_search
        k=rem(i+j,n);
        if k <= 0
            k = n + k;
        end
        if (D(k)> D(i))  
            D_pos(k) = D(i);
        end
    end
end

% CW
for i=n:-1:1
    angle_search = tan(R/d(i));
    j_search = round(angle_search*180/pi)+3;
    for j= -j_search:1:j_search
        k=rem(i+j,n);
        if k <= 0
            k = n + k;
        end
        if (D(k)> D(i))
            D_neg(k) = D(i);
        end
    end
end

% Taking shortest distance bewteen CCW en CW
for i=1:n
    if D_pos(i) < D_neg(i)
        D(i) = D_pos(i);
    else
        D(i) = D_neg(i);
    end
end

end

