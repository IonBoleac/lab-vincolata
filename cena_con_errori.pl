:- lib(fd).


/*
    Cinque colleghi vanno al ristorante per festeggiare la promozione di uno di loro. Ordinano tutti piatti diversi, ciascun collega sceglie un primo e un secondo.
    Il cameriere pero` fa confusione, e cosi` Bizzi riceve il primo piatto che era stato chiesto da Dotti.
    Costa ha ricevuto (esattamente) uno dei piatti ordinati da Dotti, mentre Dotti non ha ricevuto piatti ordinati da Costa.
    Fantini ha ricevuto due piatti ordinati due persone diverse.
    Aldini ha ricevuto almeno un piatto ordinato da Bizzi.
    Si trovi la soluzione in cui il cameriere ha fatto meno errori, fra quelle che rispettano le regole date sopra.
*/

% i clienti sono Aldini, Bizi, Costa, Dotti, Fantini
% ogni cliente ordina un primo e un secondo (due liste di 5 elementi dove ogni elemento verrà segnato con il numero del cliente)

% Si trovi la soluzione in cui il cameriere ha fatto meno errori, fra quelle che rispettano le regole date sopra.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% predicato per trovare il numero di errori commessi dal cameriere data una lista L di ordini.
% se l'elemento della lista corrisponde all'indice della lista allora non è un errore, altrimenti erorre
% esempio: L = [1, 2, 3, 4, 5] -> 0 errori
%          L = [1, 2, 3, 4, 1] -> 1 errore
%          L = [1, 2, 3, 4, 2] -> 2 errori
% se la lista è vuota allora non ci sono errori => errori([2, 1, 4, 3, 5], N, 1) -> N = 4
errori([], 0, _) :-!.
errori([H|T], N, I) :-
    % se l'elemento della lista è uguale all'indice allora non è un errore
    ( H #\= I -> B = 1 ; B = 0 ),
    N #= N1 + B,
    I1 #= I + 1,
    errori(T, N1, I1).


% confronta(Li, Lo, N) -> Li è la lista di input, Lo è la lista di output, N è il numero di errori
confronta([], [], 0) :-!.
confronta([H1|T1], [H2|T2], N) :-
    H1 #\= H2 #<=> B,
    N #= N1 + B,
    confronta(T1, T2, N1).
% confronta([1, 2, 3, 4, 5], [1, 2, 3, 4, 5], N) -> N = 0
% confronta([1, 2, 3, 4, 5], [1, 2, 3, 4, 1], N) -> N = 1
% confronta([1, 2, 3, 4, 5], [1, 2, 3, 2, 2], N) -> N = 2




csp(A, B, ErrA, ErrB, Err) :-
    % lista A è dei primi invece B dei secondi dove l'indice corrisponde al cliente che li ha ordinati
    % 1 = Aldini, 2 = Bizzi, 3 = Costa, 4 = Dotti, 5 = Fantini
    A = [A1, A2, A3, A4, A5], % primi
    B = [B1, B2, B3, B4, B5], % secondi
    A :: 1..5,
    B :: 1..5,
    ErrA :: 0..5,
    ErrB :: 0..5,

    Aord = [1, 2, 3, 4, 5], % primi ordinati
    Bord = [1, 2, 3, 4, 5], % secondi ordinati

    % Bizzi(A2) riceve il primo piatto che era stato chiesto da Costa(3)
    A2 #= 3,

    % Costa(A3, B3) ha ricevuto (esattametne) uno dei piatti ordinati da Dotti(4)
    A3 #= 4 #<=> P2,
    B3 #= 4 #<=> P1,
    P1 + P2 #= 1,

    % Dotti(A4, B4) non ha ricevuto piatti ordinati da Costa(3)
    A4 #\= 3,
    B4 #\= 3,

    % Fantini(A5, B5) ha ricevuto due piatti ordinati da due persone diverse. Quindi diversi da lui stesso e diversi tra loro
    A5 #\= 5 #<=> O1,
    B5 #\= 5 #<=> O2,
    O1 + O2 #>= 1,
    A5 #\= B5,

    % Aldini(A1, B1) ha ricevuto almeno un piatto ordinato da Bizzi(2)
    ( A1 #= 2 #\/ B1 #= 2 ) #\/ ( A1 #= 2 #/\ B1 #= 2 ),

    % tutti i clienti ordinano piatti diversi
    alldifferent(A),
    alldifferent(B),


    % conta gli errori commessi dal cameriere
    % errori(A, ErrA, 1),
    % errori(B, ErrB, 1),
    confronta(A, Aord, ErrA),
    confronta(B, Bord, ErrB),

    Err #= ErrA + ErrB,
    % minimizza gli errori del cameriere
    minimize((labeling(A), labeling(B)), Err).
    

    /*
    labeling(A),
    labeling(B).
    */

    % [cena_con_errori].
