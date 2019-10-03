function [Tprime_old ] = ...
    func_robert_filter_s( Tprime,Tprime_old2,Tprime_old )

Globals_var

        gp_T_old2 = func_get(Tprime_old2,'gp');
        gp_T_old = func_get(Tprime_old,'gp');
        gp_T = func_get(Tprime,'gp');
        
        gp_T_old = gp_T_old + robert_filter*(gp_T - 2*gp_T_old + gp_T_old2);

        Tprime_tmp = Tprime_old;
        Tprime_tmp = func_set(Tprime_tmp,'gp',gp_T_old);
        Tprime_tmp = shtrana(Tprime_tmp);
        Tprime_old = Tprime_tmp;

end

