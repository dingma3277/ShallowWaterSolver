function [ DIVprimeRHS,CURLprimeRHS ] = func_assemble_mmt( Tprime, DIVprime, CURLprime )
% calculate the RHS in the momentum equations
Globals_var

    [U,V] = func_UVinv(CURLprime, DIVprime);
    u = func_get(U,'gp');v = func_get(V,'gp');
    
    switch(wave_casename)
        case 'full'
            u = u.* Fcor*86400; % normalized Coriolis Force
            v = v.* Fcor*86400;
        case 'gravity'
            % no Coriolis force for the non-rotating case
            u = u.* Fcor.*0;
            v = v.* Fcor.*0;
    end

    U = func_set(U,'gp',u); V = func_set(V,'gp',v);
    U = shtrana(U); V = shtrana(V);

    DIV1 = func_div(U,V);CURL1 = func_curl(U,V);
    div1 = func_get(DIV1,'gp');      
    
    curl1 = func_get(CURL1,'gp');
    
    if semi_implicit_flag ==0
        DIV2 = func_del2(Tprime);
        div2 = func_get(DIV2,'gp');
    else
        % if it's semi-implicit, this part is added later using matrix
        div2 = 0;
    end

    DIVprimeRHS = DIVprime;
    DIVprimeRHS = func_set(DIVprimeRHS,'gp',-div2+curl1);
    DIVprimeRHS = shtrana(DIVprimeRHS);

    CURLprimeRHS = CURLprime;
    CURLprimeRHS = func_set(CURLprimeRHS,'gp',-div1);
    CURLprimeRHS = shtrana(CURLprimeRHS);

end
