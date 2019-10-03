
function [Ucos,T,Fcor] = init_case9(nlon,nlat,X,Y)
%  Usage [Psi,Phi] = init_case6(nlon,nlat,X,Y);
%  Input:  
%          nlon   - number of longitudes
%          nlat   - number of latitudes
%          X      - meshgrid output (or slt_grid) of longitudes (lambda)
%          Y      - meshgrid output (or slt_grid) of latitudes (theta=asin(mu))
%  Output: 
%          Ucos   - u*cos velocity
%          Vcos   - v*cos velocity
%          Xi     - vorticity
%          Psi	  - stream function
%          Phi    - geopotential height (on unit sphere of radius a)  (nlon x nlat)
%	   Fcor   - Coriolis term
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Set the Test Case 6 values:  kelvin wave
Globals_var

lon = X';  % note transpose so that lon corresponds to row dimension
lat = Y';
Omega   = 7.292e-5;  % units 1/s (earth angular velocity)

%
Ucos = zeros(nlon,nlat);
Vcos = zeros(nlon,nlat);
T = zeros(nlon,nlat);
Fcor = zeros(nlon,nlat);

for i=1:numel(lat)
    Fcor(i) = 2.0*Omega*sin(lat(i));
    Ucos(i) = ( exp(-Fcor(i).*lat(i).*6371000./2./c1 ) )* cos(10*lon(i)) ;

    T(i) = c1.*Ucos(i);
end

