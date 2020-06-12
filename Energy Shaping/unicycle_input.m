function u = unicycle_input(t, y_spline, z_spline)
%UNICYCLE_INPUT returns a function handle that calculates inputs as a
%function of time
%(y(t),z(t)) = (t, sin(t)).
%   @param t - current time
%   @param y_spline - spline object for desired y trajectory
%   @param z_spline - spline object for desired z trajectory
%   
%   @output u - input u(t) to the unicycle system

% modify this line to return the correct input for time t.
u = zeros(2,1);
ydot = ppval(fnder(y_spline),t);
yddot = ppval(fnder(y_spline, 2),t);
zdot = ppval(fnder(z_spline),t);
zddot = ppval(fnder(z_spline, 2),t);

 u(2) = sqrt(ydot^2 + zdot^2);
 u(1) = (-zdot/(ydot^2+zdot^2))*yddot + (ydot/(ydot^2+zdot^2))*zddot; 

end

