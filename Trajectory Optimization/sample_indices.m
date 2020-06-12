function [x_i_inds, u_i_inds] = sample_indices(i, nx, nu)
%SAMPLE_INDICES calculates the indices of z such that z(x_i_inds) = x_i and
% z(u_i_inds) = u_i.
%   @param i: sample number; scalar
%   @param nx: dimension of state vector, x; scalar
%   @param nu: dimension of input vector, u; scalar
%
%   @output x_i_inds: indices such that z(x_i_inds) = x_i; 1 by n_x vector
%   @output u_i_inds: indices such that z(u_i_inds) = u_i; 1 by n_u vector
    x_i_inds = (i-1)*(nx+nu)+1:i*(nx+nu)-nu;
    u_i_inds = i*(nx+nu)-nu+1:i*(nx+nu);

end

