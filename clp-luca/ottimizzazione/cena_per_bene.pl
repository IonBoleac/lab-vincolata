:-lib(fd).
:-lib(listut). %per usare nth

    %Persona = primoOrdinato secondoOrdinato
    % Aldini = 1 6
    % Bizzi = 2 7
    % Costa = 3 8
    % Dotti = 4 9
    % Fantini = 5 10

%L= lista dei piatti che ricevono
csp(L) :-
    %5 primi e 5 secondi
    length(L,10),
    %ogni elemento è un numero da 1 a 10
    L :: 1..10,

    %Tutti ricevono un piatto diverso
    alldifferent(L),

    %vincoli
    %1:  Bizzi riceve il primo piatto che era stato chiesto da Costa.
    nth1(2,L,PrimoBizzi),
    PrimoBizzi #= 3,

    %2 Costa ha ricevuto (esattamente) uno dei piatti ordinati da Dotti.
    nth1(3,L,PrimoCosta),
    nth1(8,L,SecondoCosta),
    PrimoCosta #= 4 #<=> B1,
    SecondoCosta #= 9 #<=> B2,
    B1 + B2 #= 1,

    %3 Dotti non ha ricevuto piatti ordinati da Costa.
    nth1(4,L,PrimoDotti),
    nth1(9,L,SecondoDotti),
    PrimoDotti #\= 3,
    SecondoDotti #\= 8,

    %5 Aldini ha ricevuto almeno un piatto ordinato da Bizzi.
    nth1(1,L,PrimoAldini),
    nth1(6,L,SecondoAldini),
    PrimoAldini #= 2 #<=> B3,
    SecondoAldini #= 7 #<=> B4,
    B3 + B4 #>= 1,

    %4 Fantini ha ricevuto due piatti ordinati da due persone diverse.
    nth1(5,L,PrimoFantini),
    nth1(10,L,SecondoFantini),
    PrimoFantini + 5 #\= SecondoFantini,


    %Calcolo del costo
    costo(L,1,C),

    minimize(labeling(L),C).


costo([],_,0).
costo([H|T],Idx,Somma) :- H #\= Idx #<=> E, Idx1 #= Idx + 1,  costo(T,Idx1,Somma1), Somma #= Somma1 + E.
