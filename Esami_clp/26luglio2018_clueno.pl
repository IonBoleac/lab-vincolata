:- lib(fd).
:- lib(fd_global).
:- lib(listut).
:- [risposte].

csp(ListaArmi, ListaPersonaggi) :- 
    findall(risposta(Richiedente,Rispondente,Assassino,Arma), risposta(Richiedente,Rispondente,Assassino,Arma), ListaRisposte),

    length(ListaPersonaggi, 6),
    length(ListaArmi, 6),
    % 0: la carta è nella busta
    % X: la carta è in mano al personaggio X (X \= 0)
    ListaPersonaggi :: 0..4,
    ListaArmi :: 0..4,

    % due carte devono essere in busta
    occurrences(0, ListaPersonaggi, 1),
    occurrences(0, ListaArmi, 1),

    % le persone possono avere 2 o 3 carte in mano
    append(ListaArmi, ListaPersonaggi, L),
    Val1 :: [2, 3], occurrences(1, L, Val1),
    Val2 :: [2, 3], occurrences(2, L, Val2),
    Val3 :: [2, 3], occurrences(3, L, Val3),
    Val4 :: [2, 3], occurrences(4, L, Val4),

    % vincolo risposte
    vincoloRisposte(ListaRisposte, ListaPersonaggi, ListaArmi),

    labeling(ListaArmi),
    labeling(ListaPersonaggi).

vincoloRisposte([], _, _).
vincoloRisposte([risposta(_,Rispondente,Assassino,Arma)|TRisposte], ListaPersonaggi, ListaArmi) :-
    Rispondente #\= 0,
    nth1(Assassino, ListaPersonaggi, Valore1), Valore1 #= Rispondente #<=> Z1,
    nth1(Arma, ListaArmi, Valore2), Valore2 #= Rispondente #<=> Z2,
    Z1 + Z2 #>= 1,
    vincoloRisposte(TRisposte, ListaPersonaggi, ListaArmi).
vincoloRisposte([risposta(Richiedente,0,Assassino,Arma)|TRisposte], ListaPersonaggi, ListaArmi) :-
    nth1(Assassino, ListaPersonaggi, Valore1), 
    nth1(Arma, ListaArmi, Valore2),
    (Valore1 #= 0 #/\ Valore2 #= 0) #<=> Z1,
    (Valore1 #= Richiedente #/\ Valore2 #= Richiedente) #<=> Z2,
    Z1 + Z2 #= 1,
    vincoloRisposte(TRisposte, ListaPersonaggi, ListaArmi).