
maxiterations = integrate_d*86400/delta_t;
%%
% initilize the spherical harmonics and grids
G = gauss_grid_2('T10',NNN,c0);

convection_time = zeros([2*NNN NNN]);
convection_flag = convection_time;

Tprime = spectral_field('temp',G);
Uprime = spectral_field('U',G);
Vprime = spectral_field('V',G);
CURLprime = spectral_field('curl',G);
DIVprime = spectral_field('div',G);

Tprime_old2 = spectral_field('temp',G);
Uprime_old2 = spectral_field('U',G);
Vprime_old2 = spectral_field('V',G);
CURLprime_old2 = spectral_field('curl',G);
DIVprime_old2 = spectral_field('div',G);

Tprime_old = spectral_field('temp',G);
Uprime_old = spectral_field('U',G);
Vprime_old = spectral_field('V',G);
CURLprime_old = spectral_field('curl',G);
DIVprime_old = spectral_field('div',G);

Tprime_tmp = spectral_field('temp',G);
Uprime_tmp = spectral_field('U',G);
Vprime_tmp = spectral_field('V',G);
CURLprime_tmp = spectral_field('curl',G);
DIVprime_tmp = spectral_field('div',G);

TprimeRHS = spectral_field('temp',G);
UprimeRHS = spectral_field('U',G);
VprimeRHS = spectral_field('V',G);
CURLprimeRHS = spectral_field('curl',G);
DIVprimeRHS = spectral_field('div',G);

A = slt_grid(G.xg,G.yg);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initilize the matrix for semi-implicit scheme
mm = func_get(G,'mm');
mm1 = mm+1;
nn = func_get(G,'nn');
kk = func_get(G,'kk');
aradius= func_get(G,'radius');

L = zeros([mm1*mm1 2 2]);
L(1:end,2,1) = -c1*c1;
for ii = 1:mm
    for jj = 0:ii
        L(jj*mm1+ii+1,1,2) = ii*(ii+1)/(aradius^2);
    end
end
%

Amat = zeros(size(L));
Bmat = zeros(size(L));
for ii = 1:mm1*mm1
    Amat(ii,:,:) = eye([2,2]) + 2*delta_t*squeeze(L(ii,:,:))*(1-alpha);
    Bmat(ii,:,:) = eye([2,2]) - 2*delta_t*squeeze(L(ii,:,:))*(alpha);
    Amat_inv(ii,:,:) = squeeze(Bmat(ii,:,:))^-1;
end


