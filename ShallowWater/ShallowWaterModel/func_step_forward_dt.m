function [ Tprime,Tprime_old2,Tprime_old ] = ...
    func_step_forward_dt( Tprime,Tprime_old,TprimeRHS )

Globals_var

switch(scheme_casename)
    case 'forward'

        gp_T_old = func_get(Tprime,'gp');
        gp_T_rhs = func_get(TprimeRHS,'gp');
        if damping_flag==1
            gp_T_tmp = (gp_T_old + delta_t*gp_T_rhs)*(1-delta_t/epsl);
        else
            gp_T_tmp = gp_T_old + delta_t*gp_T_rhs;
        end
        
        [ Tprime,Tprime_old,Tprime_old2 ] = func_update_var_gp( Tprime,Tprime_old,gp_T_tmp );
    case 'leap_frog'

        gp_T_old = func_get(Tprime_old,'gp');
        gp_T_rhs = func_get(TprimeRHS,'gp');
        
        if damping_flag==1
            gp_T_tmp = (gp_T_old + 2*delta_t*gp_T_rhs)*(1-delta_t/epsl);
        else
            gp_T_tmp = gp_T_old + 2*delta_t*gp_T_rhs;
        end

        [ Tprime,Tprime_old,Tprime_old2 ] = func_update_var_gp( Tprime,Tprime_old,gp_T_tmp );       
        
    case 'semi_implicit'

        gp_T_old = func_get(Tprime_old,'gp');
        gp_T_rhs = func_get(TprimeRHS,'gp');
        
        
        if damping_flag==1
            gp_T_tmp = (gp_T_old + 2*delta_t*gp_T_rhs)*(1-delta_t/epsl);
        else
            gp_T_tmp = gp_T_old + 2*delta_t*gp_T_rhs;
        end
        
        [ Tprime,Tprime_old,Tprime_old2 ] = func_update_var_gp( Tprime,Tprime_old,gp_T_tmp );
end


end

