function [y_spline, z_spline] = unicycle_spline(t0, tf)
%UNICYCLE_SPLINE returns a MATLAB spline object representing a path from
% (y(t0),z(t0)) = (0,0) to (y(t0),z(t0)) = (10,0) that avoids a circular
% obstacle of radius 3 centered at (5,0), such that d\dt y(t) > 0
%   @param t0 - initial time
%   @param tf - final time
%
%   @output y_spline - spline object for desired y trajectory
%   @output z_spline - spline object for desired z trajectory


y0 = 0;
z0 = 0;

yf = 10;
zf = 0;

t = [t0:(tf-t0)/4:tf];
y = [y0 2 5 8 yf];
z = [z0 2 4 3 zf];

y_spline = spline(t, y);
z_spline = spline(t, z);

end

