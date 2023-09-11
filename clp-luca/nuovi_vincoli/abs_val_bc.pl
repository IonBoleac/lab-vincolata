%vincolo di valore assoluto
:-lib(fd).

%VERSIONE BOUND CONSISTENCY (non FINITO)


abs_val(X,A) :- 
    %recupero dominio di X
    dvar_domain(X,DomX),
    dvar_domain(A,DomA),

    %elimino i valori dal dominio di A 
    dvar_remove_smaller(A,0),

    %recupero gli estremi del dominio
    dom_range(DomX,MinX,MaxX),
    dom_range(DomA,MinA,MaxA),

    %se gli estremi di X sono negativi cambio segno
    (MinX #< 0 -> MinXAss #= -MinX ; MinXAss #= MinX),
    (MaxX #< 0 -> MaxXAss #= -MaxX ; MaxXAss #= MaxX),

    %rimuovo al dominio di A gli elementi più grandi del massimo di X e quelli più piccoli del minimp
    dvar_remove_greater(A,MaxXAss),
    dvar_remove_smaller(A,MinXAss),


    %per gli estremi di A mi servono anche i negativi
    MinANeg = - MinA,
    MaxANeg = - MaxA,

  
    %sospensione
    sospendi(X,A).


sospendi(X,_) :- nonvar(X).
sospendi(_,A) :- nonvar(A).
sospendi(X,A) :- suspend(abs_val(X,A),5, [X->min,X->max,A->min,A->max]).




%con questo goal non funziona. Devo eliminare un intervallo e non un valore singolo
%  X::[10,30,50],A::20..50, abs_val(X,A).