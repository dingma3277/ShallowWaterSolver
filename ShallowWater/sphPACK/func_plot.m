function func_plot(f,stitle,flag)
%PLOT Spectral_field 
% Input:   f is a spectral_field instantiated before call.
% Output:  on return there is no change to the object f
%          plots are produced of grid-point values on a sphere
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Field on a Gaussian Grid with spherical harmonic coefficients
%    spectral_field([name],[GG],[gp])
%    The spectral coefficients may be obtained by a spherical
%    harmonic transform of the grid point values.  The transform and the inverse
%    transform are public methods of this class.
%  The data structure contains
%    f.name - (string) name of the field, eg. 'temperature'
%    f.G   -  the gauss_grid on which the field is defined, 
%             with spherical harmonics, etc..
%             Note: G.gg  -  the Gaussian grid (gauss_grid(nj)) ni x nj 
%             oriented north to south (ni = 2*nj)
%    f.gp  -  grid point values of the field (ni x nj) lon-lat
%    f.sc  -  spectral coefficients in a triangular truncations
%             with mtrunc=(2*nj -1 )/3 and kk=mm=nn=mtrunc
% Methods:  get, set, shtrans, shtrana, tesSpecify resolutions
if nargin == 1
  stitle = ''
end
if nargin == 2
    flag=0;
end
ni = func_get(f.G,'ni');
nj = func_get(f.G,'nj');
xg = func_get(f.G,'xg');
yg = func_get(f.G,'yg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get the grid point values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gp = func_get(f,'gp');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get the xg and yg from the gauss_grid and plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
theta = [ xg 0];
phi = asin(yg)';
X = cos(phi)*cos(theta);
Y = cos(phi)*sin(theta);
Z = sin(phi)*ones(size(theta));
C = gp';
C = [C C(:,1)];  %make the periodic extension to match the theta extension.
%{
if flag==1
    figure(1);clf
    h=surf(X,Y,Z,C);
else
    figure;
    h=surf(X,Y,Z,C);
end
axis square;
title(stitle);
%}
if flag==1
    figure(99);clf;contourf(C);colorbar;
else
    figure(flag);clf;contourf(C);colorbar;
end
    

