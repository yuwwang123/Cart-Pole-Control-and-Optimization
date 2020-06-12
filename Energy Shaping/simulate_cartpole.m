function simulate_cartpole
% SIMULATE_CARTPOLE simulates a trajectory for the cartpole system
tf = 10;
x_0 = [0; pi/4; 0; 0];


p = params();
    g = p.g;
    mc = p.mc;
    mp = p.mp;
    L = p.L;
Al = [0 0 1 0;
      0 0 0 1;
      0 g*mp/mc 0 0;
      0 g*(mc+mp)/(L*mc) 0 0];
Bl = [0;0; 1/mc; 1/(L*mc)];
K = lqr(Al,Bl,diag([1 1 1 10]),1);

        
opts = odeset('MaxStep', 0.1,'RelTol',1e-4,'AbsTol',1e-4);

[t, x] = ode45(@(t,x) f(t, x, K), [0 tf], x_0, opts);

plot_cartpole_trajectory(t, x);

end

function dx = f(t, x, K)
    x(2) = mod(x(2),2*pi);
    p = params();
    g = p.g;
    mc = p.mc;
    mp = p.mp;
    L = p.L;
    M = [mc + mp, mp*L*cos(x(2));
         mp*L*cos(x(2)), mp*L^2];
    C = [-mp*L*sin(x(2))*x(4)^2;
         mp*g*L*sin(x(2))];
    B = [1;
         0];
    Etilde = .5*x(4)^2 - g*cos(x(2)) - g;
    angular_distance  = x(4)^2 + (x(2)-pi)^2;
    
    if abs(Etilde) < 1 && angular_distance < 1
        % if we are close enough to desired state, let LQR take over
        u = - K*(x-[0;pi;0;0]);
    else
        % else, use energy shaping
        u = cartpole_input(t, x, p);
    end
    dx = [x(3:4);
          M \ (B*u - C)];
end
