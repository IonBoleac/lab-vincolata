/*
Cinque colleghi vanno al ristorante per festeggiare la promozione di uno di loro. Ordinano tutti piatti diversi, ciascun collega sceglie un primo e un secondo.
Il cameriere pero` fa confusione, e cosi` Bizzi riceve il primo piatto che era stato chiesto da Costa.
Costa ha ricevuto (esattamente) uno dei piatti ordinati da Dotti, mentre Dotti non ha ricevuto piatti ordinati da Costa.
Fantini ha ricevuto due piatti ordinati due persone diverse.
Aldini ha ricevuto almeno un piatto ordinato da Bizzi.
Si trovi la soluzione in cui il cameriere ha fatto meno errori, fra quelle che rispettano le regole date sopra.
*/

%  

:- lib(fd).
:- lib(fd_global).

csp(PRicevuti, SRicevuti) :-
    % Aldini = 1, Bizzi = 2, Costa = 3, Dotti = 4, Fantini = 5 
    PRicevuti = [A1, A2, A3, A4, A5],
    SRicevuti = [B1, B2, B3, B4, B5], 
    length(PRicevuti, 5),
    length(SRicevuti, 5),
    PRicevuti :: 1..5,
    SRicevuti :: 1..5,
    fd_global:alldifferent(PRicevuti),
    fd_global:alldifferent(SRicevuti),
    

    % Bizzi(A2) riceve il primo piatto che era stato chiesto da Costa(3).
    A2 #= 3,

    % Costa(A3, B3) ha ricevuto (esattamente) uno dei piatti ordinati da Dotti(4)
    A3 #= 4 #<=> Z1, B3 #= 4 #<=> Z2,
    Z1 + Z2 #= 1,

    % Dotti(A4, B4) non ha ricevuto piatti ordinati da Costa(3)
    A4 #\= 3 #<=> C1,
    B4 #\= 3 #<=> C2,
    C1 + C2 #= 2,

    % Fantini(A5, B5) ha ricevuto due piatti ordinati da due persone diverse
    A5 #\= B5,
    A5 #\= 5, B5 #\= 5,

    % Aldini(A1, B1) ha ricevuto almeno un piatto ordinato da Bizzi(2)
    A1 #= 2 #<=> N1,
    B1 #= 2 #<=> N2,
    N1 + N2 #>= 1,

    % conta il numero di errori commessi dal cameriere
    cont_errori(PRicevuti, 1, Cont1),
    cont_errori(SRicevuti, 1, Cont2),
    Cont #= Cont1 + Cont2,

    min_max(labeling([A1, A2, A3, A4, A5, B1, B2, B3, B4, B5]), Cont).

cont_errori([], _, 0).
cont_errori([H|T], Idx, Err) :-
    H #\= Idx #<=> B,
    Err #= B + Err1,
    Idx1 #= Idx + 1,
    cont_errori(T, Idx1, Err1).
