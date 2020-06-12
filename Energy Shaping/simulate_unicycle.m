function simulate_unicycle
% SIMULATE_UNICYCLE simulates a trajectory for the unicycle system

opts = odeset('MaxStep',0.1);

t0 = 0;
tf = 10;

% get unicycle desired path
[y_spline, z_spline] = unicycle_spline(t0, tf);

% verify that \dot y > 0 for the given spline.
t_chk = t0:0.001:tf;

ydot_min = min(ppval(fnder(y_spline),t_chk));

if ydot_min <= 0.
    error('ERROR: \dot y is not positive over the entire trajectory!');
end


x_0 = [0;
       0;
       atan(ppval(fnder(z_spline),t0)/ppval(fnder(y_spline),t0))];

% simulate unicycle
[t_sim, x_sim] = ode45(@(t, x) f(t, x, y_spline, z_spline), [t0 tf], x_0, opts);

plot_unicycle_trajectory(t_sim, x_sim, y_spline, z_spline);

end

function dx = f(t, x, y_spline, z_spline)
    u = unicycle_input(t, y_spline, z_spline);
    dx = [cos(x(3))*u(2); sin(x(3))*u(2); u(1)];
end
