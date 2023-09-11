:- lib(fd).



csp(L) :-
    L = [Gedeone, Dario, Umberto],
    L :: 1..100,

    % Fra 11 anni, Dario avrà l’età che avevo io quando lui era 6 volte più giovane di me.
    Dario + 11 #= Gedeone_passato,
    Gedeone_passato #= Dario_passato * 6,

    % Umberto, invece, ha 3 anni più di Dario e 3 anni meno della differenza 
    % d’età che c’è tra me e Dario

    Umberto #= Dario + 3,
    Umberto + 3 #= Gedeone - Dario,

    Gedeone - Dario #= Gedeone_passato - Dario_passato,


    labeling(L).
