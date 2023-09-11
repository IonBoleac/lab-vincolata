:- lib(fd).
:- lib(fd_global).
:- lib(listut).
:- [impegni].

% 1 Padre
% 2 Madre
% 3 Asilo
% 4 Tata

csp(L) :-
    length(L, 30),
    L :: [1..4],

    % vincolo Padre 1
    findall(Giorno, impegno(1, Giorno), LGiorniNoPadre),
    imponiVincoloNoUnGenitore(LGiorniNoPadre, L, 1),
    GiorniConPadre :: 0..4,
    occurrences(1, L, GiorniConPadre),


    % vincolo Madre 2
    findall(Giorno, impegno(2, Giorno), LGiorniNoMadre),
    imponiVincoloNoUnGenitore(LGiorniNoMadre, L, 2),
    GiorniConMadre :: 0..6,
    occurrences(2, L, GiorniConMadre),

    % vincolo tata    
    occurrences(4, L, NumeroGiorniTata),
    

    % vincolo asilo
    IsAsilo :: 0..1,
    PrimoGiornoAsilo :: 1..30,
    UltimoGiornoAsilo :: 1..30,
    UltimoGiornoAsilo - PrimoGiornoAsilo + 1 #=< 7,
    asilo(L, 1, PrimoGiornoAsilo, UltimoGiornoAsilo, IsAsilo),

    % vimcolo minimize e labeling
    Costo #= 100*IsAsilo + NumeroGiorniTata*50,
    % labeling(L).
    min_max(labeling(L), Costo).


% imponi i vincoli sui giorni in cui un genitore non ci può essere per il pargoletto
imponiVincoloNoUnGenitore([], _, _).
imponiVincoloNoUnGenitore([H|T], L, N) :-
    nth1(H, L, Giorno),
    Giorno #\= N,
    imponiVincoloNoUnGenitore(T, L, N).


% gestione asilo
asilo([], _, _, _, _).
asilo([H|T], N, Primo, Ultimo, IsAsilo) :-
    N1 #= N + 1,
    H #= 3 #=> IsAsilo #/\ Primo #=< N #/\ Ultimo #>= N,
    asilo(T, N1, Primo, Ultimo, IsAsilo).
