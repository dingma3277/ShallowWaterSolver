function [Tprime, Tprime_old2,  Tprime_old,...
          DIVprime, DIVprime_old2, DIVprime_old, ...
          CURLprime, CURLprime_old2, CURLprime_old] = ...
    sub_stepforward_dt(Tprime, Tprime_old, TprimeRHS, ...
                       DIVprime,  DIVprime_old,DIVprimeRHS, ...
                       CURLprime,  CURLprime_old,CURLprimeRHS)
% to step forward...

Globals_var;

if semi_implicit_flag==0

    [ Tprime,Tprime_old2,Tprime_old ] = ...
        func_step_forward_dt( Tprime,Tprime_old,TprimeRHS );

    [ DIVprime,DIVprime_old2,DIVprime_old ] = ...
        func_step_forward_dt( DIVprime,DIVprime_old,DIVprimeRHS );

    [ CURLprime,CURLprime_old2,CURLprime_old ] = ...
        func_step_forward_dt( CURLprime,CURLprime_old,CURLprimeRHS );
else

    [ Tprime,Tprime_old2,Tprime_old,DIVprime,DIVprime_old2,DIVprime_old] = ...
        func_semi_implicit_dt( Tprime,Tprime_old,TprimeRHS,...
        DIVprime,DIVprime_old,DIVprimeRHS );

    [ CURLprime,CURLprime_old2,CURLprime_old ] = ...
        func_step_forward_dt( CURLprime,CURLprime_old,CURLprimeRHS );
    
end
