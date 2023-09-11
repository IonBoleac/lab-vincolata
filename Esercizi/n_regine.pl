:- lib(fd).
:- lib(fd_global).

csp(L, N, DiagMaggiore, DiagMinore) :-
    length(L, N),
    L :: 1..N,

    % per mettere le regine su righe differenti
    % mentre sono già su colonne differenti visto 
    % che l'indice della lista L corrisponde ad una colonna
    fd_global:alldifferent(L),

    % evitare regine sulla stessa diagonale
    % diagonale maggiore
    length(DiagMaggiore, N),
    Dim #= N + N - 1,
    DiagMaggiore :: 1..Dim,
    maggiore(L, DiagMaggiore, 0),
    fd_global:alldifferent(DiagMaggiore),

    % diagonale minore
    length(DiagMinore, N),
    DiagMinore :: 1..Dim,
    minore(L, DiagMinore, N),
    fd_global:alldifferent(DiagMinore),



    labeling(L).

minore([], [], _).
minore([H|T], [Hout|Tout], Stop) :-
    Hout #= H + Stop, 
    Stop1 #= Stop - 1, 
    minore(T, Tout, Stop1).


maggiore([], [], _).
maggiore([H|T], [Diag|Tout], Idx) :-
    Diag #= Idx + H,
    Idx1 #= Idx + 1,
    maggiore(T, Tout, Idx1).

% csp(L, 8, DiagM, Diagm).
