%per i dettagli dei predicati vedi leq.pl
:-lib(fd).

% A #\= B. Lo vogliamo implementare di nuovo
diverso(A,B) :- 
    ground(A), !, dvar_remove_element(B,A).

diverso(A,B) :- 
    ground(B), !, dvar_remove_element(A,B).

diverso(A,B) :- 
    suspend(diverso(A,B),3,
    [
        A->suspend:inst,
        B->suspend:inst
    ]
    ).