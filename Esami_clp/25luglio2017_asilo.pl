:- lib(fd).
:- lib(fd_global).
:- lib(listut).
:- [impegni].

% 1 padre
% 2 madre
% 3 asilo
% 4 tata

csp(L) :-
    Padre #= 1,
    Madre #= 2,
    Asilo #= 3,
    Tata #= 4,
    length(L, 30),
    L :: 1..4,

    % imponi vinvolo padre
    findall(Giorno, impegno(Padre, Giorno), ListaNoPadre),
    FeriePadre :: 0..4,
    occurrences(Padre, L, FeriePadre),
    vincoloNoUnGenitore(ListaNoPadre, L, Padre),

    % imponi vincolo madre
    findall(Giorno, impegno(Madre, Giorno), ListaNoMadre),
    FerieMadre :: 0..6,
    occurrences(Madre, L, FerieMadre),
    vincoloNoUnGenitore(ListaNoMadre, L, Madre),

    % imponi vincolo asilo
    IsAsilo :: 0..1,
    GiorniAsilo :: 0..7,
    PrimoGiornoAsilo :: 0..30,
    UltimoGiornoAsilo ::0..30,
    UltimoGiornoAsilo - PrimoGiornoAsilo + 1 #=< GiorniAsilo,
    occurrences(Asilo, L, GiorniAsilo),
    vincoloAsilo(L, 1, PrimoGiornoAsilo, UltimoGiornoAsilo, IsAsilo),

    % conta i giorni con la tata
    occurrences(Tata, L, GiorniTata),

    % costo finale
    Costo #= GiorniTata*50 + IsAsilo*100,

    %labeling(L).
    min_max((labeling(L), my_print(L)), Costo).

vincoloAsilo([], _, _, _, _).
vincoloAsilo([H|T], Giorno, PrimoGiornoAsilo, UltimoGiornoAsilo, IsAsilo) :-
    H #= 3 #<=> IsAsilo #\/ PrimoGiornoAsilo #=< Giorno #\/ Giorno #=< UltimoGiornoAsilo,
    Giorno1 #= Giorno + 1,
    vincoloAsilo(T, Giorno1, PrimoGiornoAsilo, UltimoGiornoAsilo, IsAsilo).

vincoloNoUnGenitore([], _, _).
vincoloNoUnGenitore([H|T], L, Genitore) :-
    nth1(H, L, Valore),
    Valore #\= Genitore,
    vincoloNoUnGenitore(T, L, Genitore).

my_print([]).
my_print([H|T]) :-
    write(H), write(","),
    my_print(T).