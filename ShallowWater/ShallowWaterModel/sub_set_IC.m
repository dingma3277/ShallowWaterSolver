% set up initial conditions

%%
switch(IC_casename)
    %%
    case 'gaussian'
        % to begin with a hump of high geopotential
        [Ucos,T,Fcor] = init_case9(NNN*2,NNN,A.X,A.Y);
        clear Ucos T
        [yyy,xxx] = meshgrid(1:G.nj,1:G.ni);
        gp = exp(-abs(yyy-NNN/2-0.5)/(5*NNN/64)).*exp(-abs(xxx-NNN)/(5*NNN/64));
        Tprime=func_set(Tprime,'gp',gp);
        Tprime = shtrana(Tprime);
        Tprime = shtrans(Tprime);
        Tprime_old2 = Tprime;
        Tprime_old = Tprime;
        
        DIV2 = func_del2(Tprime);
        div2 = func_get(DIV2,'gp');
        
        gp_DIV_tmp = - delta_t*div2;
        DIVprime_tmp = Tprime;
        DIVprime_tmp = func_set(DIVprime_tmp,'gp',gp_DIV_tmp);
        DIVprime_tmp = shtrana(DIVprime_tmp);
        DIVprime = DIVprime_tmp;
        clear xxx yyy
    case 'kelvin'
        % Kelvin waves...
        [Ucos,T,Fcor] = init_case9(NNN*2,NNN,A.X,A.Y);

        Tprime = func_set(Tprime,'gp',T);
        Uprime = func_set(Uprime,'gp',Ucos);
        DIVprime = func_div(Uprime,Vprime);
        CURLprime = func_curl(Uprime,Vprime);

        Tprime_old = Tprime;
        Uprime_old = Uprime;
        DIVprime_old = DIVprime;
        CURLprime_old = CURLprime_old;
        
    case 'random'
        % start with white noise
        [Ucos,T,Fcor] = init_case9(NNN*2,NNN,A.X,A.Y);
        clear Ucos T
        [yyy,xxx] = meshgrid(1:G.nj,1:G.ni);
        tmp = random('Normal',0,1,G.ni,G.nj);
        gp = 6*exp(-abs(yyy-NNN/2-0.5)/(4*NNN/64)).*tmp;
        Tprime=func_set(Tprime,'gp',gp);
        Tprime = shtrana(Tprime);
        Tprime = shtrans(Tprime);
        
        tmp = random('Normal',0,1,G.ni,G.nj);
        gp = 6*exp(-abs(yyy-NNN/2)/(4*NNN/64)).*tmp;
        Tprime_old=func_set(Tprime_old,'gp',gp);
        Tprime_old = shtrana(Tprime_old);
        Tprime_old = shtrans(Tprime_old);        
        clear xxx yyy        
end