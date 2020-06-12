function u = cartpole_input(t, x, constants)
%CARTPOLE_INPUT calculates PFL / energy pumping input for cartpole.
%   @param t - time in seconds
%   @param x - state of cartpole at time t
%   @param constants - struct containing inertial and geometric constants,
%   which may be referenced as constants.mp, constants.L, etc.
%
%   @output u - input u(t) to the cartpole system

% modify this line to return the correct input for time t.
g = constants.g;
mc = constants.mc;
mp = constants.mp;
L = constants.L;
M = [mc + mp, mp*L*cos(x(2));
     mp*L*cos(x(2)), mp*L^2];
 
C = [-mp*L*sin(x(2))*x(4)^2;
      mp*g*L*sin(x(2))];

q1ddot_d = x(4)* cos(x(2))*(0.5*x(4)^2 - g*cos(x(2)) - g) - 5*x(3) - x(1);
u = (M(1,1)-M(1,2)^2/M(2,2))*q1ddot_d + C(1) - (M(1,2)/M(2,2))*C(2);

end