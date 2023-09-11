:- lib(fd).
:- lib(fd_global).

% 1 = latte
% 2 = vino
% 3 = acqua
% 4 = vuoto

csp(L) :- 
    Lin = [1, 2, 4, 5, 6, 12, 15, 22, 24, 38],
    length(Lin, Dim),
    length(L, Dim),
    L :: 1..4,

    %% VINCOLI 
    % uno è pieno di latte
    fd_global:occurrences(1, L, 1),

    % uno è completamente vuoto
    fd_global:occurrences(4, L, 1),

    % il vino è il doppio dell'acqua
    Vino #= 2 * Acqua,
    calcQuantita(Lin, L, 2, Vino),
    calcQuantita(Lin, L, 3, Acqua),


    % la quantita di acqua è il doppio della quantita di latte
    Acqua #= 2 * Latte,
    calcQuantita(Lin, L, 1, Latte),


    labeling(L).

% calcQuantita(Lin, L, Tipo, TotQuantita)
calcQuantita([], [], _, 0).
calcQuantita([Hin|Tin], [H|T], Tipo, Tot) :-
    H #= Tipo #<=> B,
    Tot #= Tot1 + Hin*B,
    calcQuantita(Tin, T, Tipo, Tot1).
