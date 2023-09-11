:- lib(fd).
:- lib(matrix_util).

% csp(3, Righe, Colonne, Quadrato).

csp(N, Righe, Colonne, Quadrato) :-
    M #= N * N,
    Righe :: 1..M,
    matrix(N, N, Righe, Colonne),

    flatten(Righe, Quadrato).