
function A = slt_grid(xg,yg)
%SLT Creates an extended Grid from an input Grid
%  Usage:  Adv = slt(xg,yg)
%    Once the extended grid is established, with index mappings for
%    halo updates, then particle tracking and interpolation at departure
%    points can be done from input fields.
% Input:  G  - grid
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  The grid data structure contains
%    ni, nj           the number of internal lons and lats
%    nie, nje         the number of total lons and lats in extend slt_grid
%    xg,yg   -  the Gaussian grid ni x nj oriented north to south (ni = 2*nj)
%  The extended grid for advection contains
%    nix, njx
%    xge,yge  -   the extended grid
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% form the slt extended grid
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  -------------------------------------
%  |                                   |
%  |       C                D          |
%  |  +++++++++++++++N++++++++++++++   +1.0
%  |  +                            +   |
%  |  +                            +   |
%  |  +            interior        + periodic
%  |  +                            +   |
%  |  +                            +   |
%  |  +++++++++++++++S++++++++++++++   -1.0 (= sin lat)
%  | 0.0   A                B      2*pi
%  |                                   |
%  |                                   |
%  -------------------------------------
%     +nxpt+1                      +nxpt+nx
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 nx = length(xg);
 yg = asin(yg);
 ny = length(yg);
% Periodic Longitude
 nxpt = 3;  % number of extra points in periodic x extension
 exl = [xg(nx-nxpt+1) xg(nx-nxpt+2) xg(nx-nxpt+3) ]- 2*pi;
 exr = [xg(1) xg(2) xg(3) ]+ 2*pi;
 xge   = [exl xg exr];
% Latitude as \sin \phi in [-1,1]
 nypt = 3;  % number of extra points in pole y extension (skipping the pole)
 eyb = [(-2 - yg(3)) (-2 - yg(2)) (-2 - yg(1)) ];       % bottom (south pole)
 eyt = [(2 - yg(ny)) (2 - yg(ny-1)) (2 - yg(ny-2)) ];   % top    (north pole)
 yge   = [eyb yg eyt];
%Note:  ESMF_COORD_SYSTEM_SPHERICAL  (or lat,lon)
%Note:  ESMF_COORD_ORDER_UNKNOWN  (or lat,lon)
%Note:  ESMF_GRID_TYPE_LATLON
%Note:  ESMF_GRID_TYPE_LATLON
%Fill the coordinate arrays
 A.xge = xge;
 A.yge = yge;
 [A.X A.Y]   = meshgrid(xg,yg);
 [A.Xe A.Ye] = meshgrid(xge,yge);
 A.nie       = length(A.xge);
 A.nje       = length(A.yge);
 A.ni       = length(xg);
 A.nj       = length(yg);
 A.nxpt      = nxpt;
 A.nypt      = nypt;

