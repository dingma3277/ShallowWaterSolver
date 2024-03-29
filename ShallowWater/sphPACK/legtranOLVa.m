
function x = legtranOLVa(sf,nj,mm,nn,kk,P) 
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
%tic
for m=0:mm
    x(m+1:2:nn+1,m+1) = transpose((sf(m+1,1:njo2) + sf(m+1,nj:-1:njo2+1))*P(:,m+1:2:nn+1,m+1));
    x(m+2:2:nn+1,m+1) = transpose((sf(m+1,1:njo2) - sf(m+1,nj:-1:njo2+1))*P(:,m+2:2:nn+1,m+1));
end    
%toc      %print the time spent in analysis
