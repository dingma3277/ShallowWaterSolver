function [ sc_tmp3 ] = func_assemble_RHS( Tprime,DIVprime )

    Globals_var

    g = shtrana(Tprime);    % transform the field to spectral space
    sc_T = func_get(g,'sc');   % get the spectral coeffients
    sc_T = reshape(sc_T,[mm1*mm1 1]);

    g = shtrana(DIVprime);    % transform the field to spectral space
    sc_DIV = func_get(g,'sc');   % get the spectral coeffients
    sc_DIV = reshape(sc_DIV,[mm1*mm1 1]);

    sc_tmp3 = [sc_T,sc_DIV];


end

