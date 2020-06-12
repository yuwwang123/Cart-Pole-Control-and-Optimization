function [g,dG] = trajectory_cost(z, N, nx, nu, dt)
%TRAJECTORY_COST(z) computes the cost and cost jacobian.
%   @param z: decision variable (column) vector containing the x_i and u_i
%   @param N: number of sample points; scalar
%   @param nx: dimension of state vector, x; scalar
%   @param nu: dimension of input vector, u; scalar
%   @param dt: \Delta t, the inter-sample interval duration; scalar

%   @output g: total accrued cost; scalar
%   @output dG: gradient of total accrued cost; nz by 1 vector

    g = 0;
    dG = zeros(N*(nx + nu),1);

    for i=1:(N-1)
        
        % TODO: add cost and cost gradient for interval between u_i and
        % u_{i+1}
        u_i = z(i*(nx+nu)-nu+1: i*(nx+nu));
        u_ip1 = z((i+1)*(nx+nu)-nu+1: (i+1)*(nx+nu));
        g = (dt/2)*(sum(u_i.^2)+sum(u_ip1.^2));
        dG((i-1)*(nx+nu)+1: i*(nx+nu)-nu) = 0;
        for j = 1:nu
            dG(i*(nx+nu)-nu+j) = 2*dt*z(i*(nx+nu)-nu+j);
        end
    end

end