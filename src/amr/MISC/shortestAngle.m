function angle = shortestAngle(angle)
%angle = shortestAngle(angle)
% This function will spread an arbitrary angle in [-pi,pi]
n=numel(angle);
for i=1:n
    if abs(angle(i))>=2*pi       % Angle ofverflow check
        angle(i) =rem(angle(i),2*pi);
    end
    if angle(i)>pi
        angle(i)=-2*pi+angle(i);  % Go reverse, negative sign convention
    elseif angle(i)<-pi
        angle(i)=2*pi+angle(i);
    end
    
end
end