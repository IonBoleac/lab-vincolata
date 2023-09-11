:- lib(fd).


csp(LFratelli, LPesi, N) :-
    % liste per le sfere
    length(LSfere, N),
    length(LPesi, N),

    % lista L -> 0 un fratello, 1 l'altro fratello
    length(LFratelli, N),
    LFratelli :: 0..1,

    % lista sfere
    crea_sfere(LSfere, 1),
    cubi_sfera(LSfere, LPesi),

    somma_lista(LPesi, SommaPesi),

    Div * 2 #= SommaPesi,

    calc_fratello(LFratelli, LPesi, Div),

    labeling(LFratelli).

calc_fratello([], [], 0).
calc_fratello([Fratello|TFratello], [Peso|TPeso], SommaPesi) :-
    %Fratello #= 1 #<=> B,
    SommaPesi #= Peso*Fratello + Somma1,
    calc_fratello(TFratello, TPeso, Somma1).

somma_lista([], 0).
somma_lista([H|T], Somma) :-
    Somma #= H + Somma1,
    somma_lista(T, Somma1).


crea_sfere([], _).
crea_sfere([Sfera|T], Sfera) :-
    Sfera1 #= Sfera + 1,
    crea_sfere(T, Sfera1).

cubi_sfera([], []).
cubi_sfera([H1|T1], [H2|T2]) :-
    H2 #= H1*H1*H1,
    cubi_sfera(T1, T2).

% csp(LFratelli, LPesi, 12).