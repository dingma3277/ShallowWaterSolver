function G = gauss_grid_2(casename,num_lat,c0)
%Gauss_grid Creates a Gaussian Grid with Gauss weights and the
%    associated Legendre functions evaluated on this grid.
% Input:  name, nj
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  The data structure contains
%    ni, nj           the number of lons and lats
%    mm,nn,kk         with mtrunc=(2*nj -1 )/3 and kk=mm=nn=mtrunc, settings for
%                     a triangular spectral truncation
%    gg   -  the Gaussian grid ni x nj oriented north to south (ni = 2*nj)
%    wg   -  Gauss weights, nj
%    P    -  associated Legendre functions evaluated at the latitudes
%    H    -  derivative of associated Legendre functions evaluated at the latitudes
%  Note on usage:  this is primarily used for computations of spectral fields.
%                  The spectral transform of a field over this grid must pass the
%                  handle of this object to the methods.


 G.name  = casename;
 G.nj = num_lat; % nj is number of latitudes
 G.ni=2*G.nj;               % number of longitudes
 mtrunc = floor((2*G.nj -1)/3);
 G.mm=mtrunc; G.nn=mtrunc; G.kk=mtrunc; % triangular spectral truncation (nn=mm=kk)
 G.radius = 6371000/86400/c0;   % default unit sphere (can be set later on)
 [G.xg,G.yg,G.wg,G.P,G.H] = shtraninit(G.ni,G.nj,G.mm,G.nn,G.kk);
%Note:  ESMF_COORD_SYSTEM_SPHERICAL  (or lat,lon)
%Note:  ESMF_GRID_TYPE_LATLON
%Fill the coordinate arrays
% G.gg = meshgrid(G.xg,G.yg);
% G = class(G,'gauss_grid');
end

