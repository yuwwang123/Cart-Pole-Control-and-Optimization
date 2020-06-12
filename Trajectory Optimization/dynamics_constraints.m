function [h,dH] = dynamics_constraints(z, N, nx, nu, dt)
%DYNAMICS_CONSTRAINTS(z) compiles the dynamics constraints generated by
%dynamics_constraint_with_derivative.
%   @param z: decision variable (column) vector containing the x_i and u_i
%   @param N: number of sample points; scalar
%   @param nx: dimension of state vector, x; scalar
%   @param nu: dimension of input vector, u; scalar
%   @param dt: \Delta t, the inter-sample interval duration; scalar

%   @output h: compiled h_i from dynamics_constraint_with_derivative;
%   (N-1)*nx by 1 vector
%   @output dH_i: compiled dH_i from dynamics_constraint_with_derivative;
%   (N-1)*nx by nz matrix

    h = zeros((N-1)*nx, 1);
    dH = zeros((N-1)*nx, N*(nx + nu));

    for i=1:(N-1)

        % TODO: call dynamics_constraint_with_derivative ith sample
        [x_i_inds, u_i_inds] = sample_indices(i, nx, nu);
        [x_ip1_inds, u_ip1_inds] = sample_indices(i+1, nx, nu);
        [h_i,dH_i] = dynamics_constraint_with_derivative(z(x_i_inds), z(u_i_inds), z(x_ip1_inds), z(u_ip1_inds), dt);
        h((i-1)*nx+1:i*nx) = h_i;
        dH((i-1)*nx+1:i*nx,(i-1)*(nx+nu)+1:(i+1)*(nx+nu))= dH_i;
        % TODO fit h_i and dH_i into h and dH, respectively.

    end

end