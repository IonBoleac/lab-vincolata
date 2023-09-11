:- lib(fd).

abs_val(X, A) :-
    % recupero i domini di X e A
    dvar_domain(X, DomX), dvar_domain(A, DomA),

    % calcolo il dominio di A. Tolgo tutti i valori negativi da DomA
    dvar_remove_smaller(DomA, 0),

    % tolgo il minimo di DomX dal dominio di A se tale valore (assoluto) non è presente nel domA
    % dom_range(DomX, MinX, _), % recupero il minimo di DomX
    % valoreAssoluto(MinX, MinXAbs), % calcolo il valore assoluto di MinX
    % ( dom_check_in(DomA, MinXAbs) -> True ; dvar_remove_greater(DomA, MinXAbs) ),

    % tolgo dal domX tutti i valori più grandi di domA
    dom_range(DomA, _, MaxA), % recupero il massimo di DomA
    ( dom_check_in(DomX, MaxA) -> True ; dvar_remove_greater(DomX, MaxA) ),

    sospendi(X, A).

sospendi(X, A) :- nonvar(X), !.
sospendi(X, A) :- nonvar(A), !.
sospendi(X, A) :- suspend(abs_val(X, A), 5, [A -> max]).


valoreAssoluto(X, A) :-
    ( X #< 0 -> A #= -X ; A #= X ). % se X è negativo, A è il suo valore assoluto

valoreAssolutoList([], []) :- !.
valoreAssolutoList([X|Xs], [A|As]) :-
    ( X #< 0 -> A #= -X ; A #= X ), % se X è negativo, A è il suo valore assoluto
    valoreAssoluto(Xs, As).
