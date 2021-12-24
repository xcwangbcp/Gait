function [tmax,vmax,tmin,vmin] = extrem_num(f,p);
v = p;
t = f;
Lmax = diff(sign(diff(v)))== -2; % logic vector for the local max value
Lmin = diff(sign(diff(v)))== 2; % logic vector for the local min value
% match the logic vector to the original vecor to have the same length
Lmax = [false; Lmax; false];
Lmin =  [false; Lmin; false];
tmax = t (Lmax); % locations of the local max elements
tmin = t (Lmin); % locations of the local min elements
vmax = v (Lmax); % values of the local max elements
vmin = v (Lmin); % values of the local min elements
 
% plot them on a figure
plot(t,v);
xlabel('t'); ylabel('v');
hold on;
% plot(tmax, vmax, 'r+');
plot(tmin,vmin, 'g+');
hold off;
end

