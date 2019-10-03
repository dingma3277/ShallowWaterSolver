
function x = legtranOLa(sf,nj,mm,nn,kk,P) 
% Compute a Legendre transform synthesis
%  Input: 
%    sf - complex Fourier coeffecients ordered (m,j) 
%    nj = number of Gauss latitudes
%    mm, nn,kk are the truncation parameters
%    P - associated Legendre functions ordered (j,n,m)
% Output:
%    x - matrix of spectral coefficients ordered (n,m)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by John Drake
% Based on Spherical harmonic transform formulation based on open loops
% Date: Jan. 2003
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
njo2=nj/2;
x = zeros(nn+1,mm+1);
%tic;
for m=0:mm
%    for j=1:njo2
         j=1:njo2;
        for n=m:2:nn
          x(n+1,m+1) = x(n+1,m+1) + (sf(m+1,j) + sf(m+1,nj-j+1))*P(j,n+1,m+1);
        end
        for n=m+1:2:nn
          x(n+1,m+1) = x(n+1,m+1) + (sf(m+1,j) - sf(m+1,nj-j+1))*P(j,n+1,m+1);
        end
%    end
end
%timtota   = toc          %print the time spent in analysis
