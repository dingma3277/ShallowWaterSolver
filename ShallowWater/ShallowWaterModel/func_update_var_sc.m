function [ Tprime,Tprime_old,Tprime_old2 ] = func_update_var_sc( Tprime,Tprime_old,sc_new_T )
    
    Tprime_tmp = Tprime;
    Tprime_tmp = func_set(Tprime_tmp,'sc',sc_new_T);
    Tprime_tmp = shtrans(Tprime_tmp);
    Tprime_old2 = Tprime_old;
    Tprime_old = Tprime;
    Tprime = Tprime_tmp;

end

