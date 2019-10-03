function [ Tprime,Tprime_old,Tprime_old2 ] = func_update_var_gp( Tprime,Tprime_old,gp_T_tmp )

    Tprime_tmp = Tprime;
    Tprime_tmp = func_set(Tprime_tmp,'gp',gp_T_tmp);
    Tprime_tmp = shtrana(Tprime_tmp);
    Tprime_old2 = Tprime_old;
    Tprime_old = Tprime;
    Tprime = Tprime_tmp;

end

