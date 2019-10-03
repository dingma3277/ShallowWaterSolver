function [ sc_tmp4 ] = func_sc_multiply( sc_tmp3,L_mat )

    Globals_var
    sc_tmp4 = zeros(size(sc_tmp3));
    for ii = 1:mm1*mm1
        sc_tmp4(ii,:)= sc_tmp3(ii,:)*squeeze(L_mat(ii,:,:));
    end

end

