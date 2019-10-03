function [ Tprime,Tprime_old2,Tprime_old,DIVprime,DIVprime_old2,DIVprime_old ] = ...
    func_semi_implicit_dt_test( Tprime,Tprime_old,TprimeRHS,...
    DIVprime,DIVprime_old,DIVprimeRHS)

    Globals_var

    [ sc_tmp_old ] = func_assemble_RHS( Tprime_old,DIVprime_old )  ;
    [ sc_tmp3 ] = func_sc_multiply( sc_tmp_old,Amat );
    [ sc_tmp_rhs ] = func_assemble_RHS( TprimeRHS,DIVprimeRHS )  ;
    
    [ sc_tmp4] = 2*delta_t*sc_tmp_rhs + sc_tmp3;
    [ sc_new ] = func_sc_multiply( sc_tmp4,Amat_inv );
%
    if damping_flag==1
        sc_new_T = (reshape(sc_new(:,1),[mm1 mm1]))*(1-delta_t/epsl);
        sc_new_DIV = (reshape(sc_new(:,2),[mm1 mm1]))*(1-delta_t/epsl);
    else
        sc_new_T = reshape(sc_new(:,1),[mm1 mm1]);
        sc_new_DIV = reshape(sc_new(:,2),[mm1 mm1]);
    end


    
    
    [ Tprime,Tprime_old,Tprime_old2 ] = func_update_var_sc( Tprime,Tprime_old,sc_new_T );
    
    [ DIVprime,DIVprime_old,DIVprime_old2 ] = func_update_var_sc( DIVprime,DIVprime_old,sc_new_DIV );

end

