function f = spectral_field(casename,G)
%SPECTRAL_FIELD Constructor method
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
% Methods:  get, set, shtrans, shtrana, test, plot

 f.name  = casename;
 f.G     = G; % gauss_grid type
 ni      = func_get(f.G,'ni');
 nj      = func_get(f.G,'nj');
 f.gp    = zeros(ni,nj);
 nn      = func_get(f.G,'nn');
 mm      = func_get(f.G,'mm');
 f.sc    = complex(zeros(mm+1,nn+1),zeros(mm+1,nn+1));
%Note:  ESMF_COORD_SYSTEM_SPHERICAL  (or lat,lon)
%Note:  ESMF_GRID_TYPE_LATLON


end
