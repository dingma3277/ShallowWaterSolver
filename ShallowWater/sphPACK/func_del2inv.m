
function g = func_del2inv(f) 
% DEL2INV - Inverse Laplacian of a spectral_grid field.
% Usage: g = del2inv(f)
% Compute the Laplacian from the grid point values using the spectral
% transform and modifying the spectral coefficients.  The grid point
% values are returned from a spherical harmonic transform synthesis
%--------------------------------------------------------
%  Input: 
%    f - spectral_field class object
%        In particular:
%           f.G  - field gauss_grid
%           f.gp - field grid point values
%           f.sc - field spectral coefficients
%  Output:
%    g - spectral_field object = del2inv(f)
%  Local
%    xf - matrix of Fourier coefficients ordered (m,j)
%--------------------------------------------------------
% Written by John Drake
% Method of spectral_field class: Sept 2005
%--------------------------------------------------------
mm = func_get(f.G,'mm');
nn = func_get(f.G,'nn');
kk = func_get(f.G,'kk');
aradius = func_get(f.G,'radius');
%--------------------------------------------------------
g = shtrana(f);    % transform the field to spectral space
sc = func_get(g,'sc');   % get the spectral coeffients
% modify the spectral coefficients
for n = 1:nn
  	m = 0:n;
	sc(n+1,m+1) = -(aradius^2)/((n+1)*(n)) * sc(n+1,m+1);
end
%sc(1,1) = 0.0;   %leave constant the same to establish level
g = func_set(g,'sc',sc);% set the new coefficients
g = shtrans(g);    % inverse transform to get new grid point values 
% all done  - f is unchanged, but new spectral_field g created.
