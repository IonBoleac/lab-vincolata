:- lib(fd).


csp(L1, L2) :-
    
    L1 = [X1, X2, X3, X4, X5, X6, X7, X8, X9, X10],
    L2 = [X11, X12, X13, X14, X15, X16, X17, X18, X19, X20],
    L1 :: [0, 1],
    L2 :: [0, 1], % 0 = false, 1 = true

    % X1 = X6 e X7 sono uguali
    X6 #= X7 #<=> X1,

    % X2: X1 è falso
    X1 #= 0 #<=> X2,

    % X3: X4 e X20 sono differenti
    X4 #\= X20 #<=> X3,
    
    % X4: X3 e X20 sono differenti
    X3 #\= X20 #<=> X4,

    % X5: La risposta a questa affermazione è diversa dalla risposta al n. 19.
    X5 #\= X19 #<=> X5,

    % X6: X2 è vero
    X2 #= 1 #<=> X6,

    % X7: X15 è vero
    X15 #= 1 #<=> X7,

    % X8: X11 e X19 sono uguali
    X11 #= X19 #<=> X8,

    % X9: X10 è vero
    X10 #= 1 #<=> X9,

    % X10: X13 è falso
    X13 #= 0 #<=> X10,

    % X11: Mrs. Jones è allergico alle fragole

    % X12: X16 è vera
    X16 #= 1 #<=> X12,

    % X13: X12 è falso
    X12 #= 0 #<=> X13,

    % X14: X14 e X11 sono uguali
    X14 #= X11 #<=> X14,

    % X15: Almeno la metà delle affermazioni in questo problema sono false.
    X1 + X2 + X3 + X4 + X5 + X6 + X7 + X8 + X9 + X10 + X11 + X12 + X13 + X14 + X15 + X16 + X17 + X18 + X19 + X20 #=< 10 #<=> X15,

    % X16: Almeno la metà delle affermazioni in questo problema sono vere.
    X1 + X2 + X3 + X4 + X5 + X6 + X7 + X8 + X9 + X10 + X11 + X12 + X13 + X14 + X15 + X16 + X17 + X18 + X19 + X20 #>= 10 #<=> X16,

    % X17: X9 e X4 sono uguali
    X9 #= X4 #<=> X17,

    % X18: X7 è vero
    X7 #= 1 #<=> X18,

    % X19: Il nome di Mrs. Jones è Sirley

    % X20: X3 e X4 sono differenti
    X3 #\= X4 #<=> X20,



    append(L1, L2, L),
    labeling(L).