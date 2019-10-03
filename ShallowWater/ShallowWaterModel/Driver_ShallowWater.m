
% shallow water model - with forcing (white noise) and damping
% Ding Ma 
% dingma3277@gmail.com 

% The prognostic variables for the model are:
% Tprime: geopotential, a.k.a height, and it is equivalent to temperature
% DIVprime: divergence of the flow
% CURLprime: vorticity of the flow
% Uprime: zonal wind
% Vprime: meridional wind

% model parameters:
% c0: prescribed gravity wave speed, in m/s; c0^2 is equivalent to the depth of
% the shallow water
% delta_t: time step, in seconds
% snapshot_t: interval between snapshots stored, in days
% integrate_d: how long it is integrated, in days
% forcing_flag = 1: there is white noise forcing
% forcing = 20: normalized magnitude of white-noise forcing
% damping_flag = 1: there is damping on each variable
% epsl = 40: damping time scale in days
% Q_switch = 0: there is no convective heating

% IC_casename: initial condition. options: gaussian, kelvin, random
% wave_casename = 'gravity' (non-rotating earth);
%              or 'full' (rotating earth)

%%
clear;clc;
addpath('../sphPACK/');
% the package to generate spherical harmonics and grids, and conduct
% spherical harmonic tramsform
% for a prognostic varible f (e.g. Tprime, DIVprime), it contains:
% f.G - field gauss_grid
% f.gp - field grid point values
% f.sc - complex spectral coeffiecients

Globals_var;
% declare global variables
%% model parameters
NNN = 64;
% resolution: NNN is the number of points from 90S - 90N
% so that there are 2*NNN points along the equator

c0=16;c1 = 1; % c0: the gravity wave speed in m/s, c1 is normlized

delta_t = 3600;%1200; % Time_step, in seconds
delta_t = delta_t/86400; %to normalize the time_step into days
snapshot_t = 1/4; %how often it output the results: one output every snapshot_t days
integrate_d = 180; %how long it is integrated, in days

forcing_flag = 1;
forcing = 20; % some normalized magnitude of white-noise forcing
damping_flag = 1;
epsl = 40; % damping time scale in days

Q_switch = 0; % 0 - no convective heating; 1 - with convective heating

IC_casename='gaussian' % initial condition:
% options: gaussian, kelvin, random

wave_casename='full'
%options: (1)gravity (non-rotating earth); (2)full (rotating earth)

% temporal scheme:
% forward, leap_frog, semi_implicit
scheme_casename='semi_implicit'
switch scheme_casename
    case('forward')
        semi_implicit_flag=0;robert_flag=0;alpha=0;
    case('leap_frog')
        semi_implicit_flag=0;
        robert_flag=1;robert_filter = 0.03;alpha=0;
        % robert filtering is used to stablize leap frog
    case('semi_implicit')
        semi_implicit_flag=1;
        robert_flag=1; robert_filter = 0.03;
        alpha = 0.5; %explicit: alpha = 0; fully implicit: alpha = 1;
end

%%
sub_initialize; 
% initilize the spherical harmonics, grids and the matrice for semi-implicit scheme 
sub_set_IC;
% set up the initial condition
func_plot(Tprime,'T',1);title('Initial consition')
% plot the initial condition
TT = [];
% the snapshots are stored in TT
%%
tic;
ii = 1;jj = 1;
for no_step = 1:integrate_d/delta_t;

    display([num2str(no_step),' step out of ',num2str(integrate_d/delta_t)]);

    [ TprimeRHS,Q] = func_assemble_T( Tprime,DIVprime );
    % calculate the RHS in the geopotential equation

    [ DIVprimeRHS,CURLprimeRHS ] = func_assemble_mmt( Tprime, DIVprime, CURLprime );
    % calculate the RHS in the momentum equations

    [Tprime, Tprime_old2, Tprime_old,DIVprime, DIVprime_old2, DIVprime_old, CURLprime, CURLprime_old2,CURLprime_old] = ...
        sub_stepforward_dt(Tprime, Tprime_old, TprimeRHS, ...
                           DIVprime, DIVprime_old, DIVprimeRHS, ...
                           CURLprime,CURLprime_old, CURLprimeRHS);
    % step forward...

    if robert_flag ==1
    % do robert filtering
        [Tprime, Tprime_old2, Tprime_old,DIVprime, DIVprime_old2, DIVprime_old, CURLprime, CURLprime_old2,CURLprime_old] = ...
            func_robert_filter(Tprime, Tprime_old2, Tprime_old, ...
                               DIVprime, DIVprime_old2, DIVprime_old, ...
                               CURLprime, CURLprime_old2,CURLprime_old);
    end

%%
    % plot and store the snapshots 
    if (mod(no_step,ceil(snapshot_t/delta_t))==0)
        toc;tic;
        T_tmp = func_get(Tprime,'gp');
        TT(ii,:,:)=T_tmp;ii = ii +1;
        if (ii==21)
            filename = int2str(jj);jj=jj+1;
            filename = ['TT_',filename,'.mat'];
            save(filename,'TT');TT=[];ii=1;
        end
        func_plot(Tprime,'T',5);grid on;shading flat
        title_n = [num2str(no_step*delta_t*24),' hours integrated out of ',int2str(integrate_d),' days']
        title(title_n);
    end                 
end

%save('TT_final','TT')
% store the last part of the results
