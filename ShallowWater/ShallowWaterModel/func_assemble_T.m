function [ TprimeRHS,Q ] = func_assemble_T( Tprime,DIVprime )
% calculate the RHS in the geopotential equation
Globals_var

if semi_implicit_flag == 0
    % if it's semi-implicit, this part is calculated later using matrix...
    div = -c1*c1*func_get(DIVprime,'gp');
else
    div = 0;
end

    if Q_switch ==0
    % allow convective heating
        Q = 0;
    else
        Q = func_param_heating( Tprime );
    end
    
    %% add white noise
    if forcing_flag==1
        [yyy,xxx] = meshgrid(1:G.nj,1:G.ni);
        tmp = random('Normal',0,1,G.ni,G.nj);
        f_gp = (6.*tmp)/forcing;
%        f_gp = (6*exp(-abs(yyy-NNN/2-0.5)/(4*NNN/64)).*tmp)/forcing;
    else
        f_gp = 0;
    end
    
%    if damping_flag==1
%        T_gp = func_get(Tprime,'gp');
%        damp_gp = -T_gp/epsl;
%    else
        damp_gp = 0;
%    end
    
    %%
    TprimeRHS = Tprime;
    TprimeRHS = func_set(TprimeRHS,'gp',div+Q + f_gp + damp_gp);
    TprimeRHS = shtrana(TprimeRHS);
    TprimeRHS = shtrans(TprimeRHS);

end

