:-lib(fd).
:-lib(listut). %per usare nth

csp(Primi,Secondi,PrimiOrd,SecondiOrd) :-

    % Aldini = 1
    % Bizzi = 2
    % Costa = 3
    % Dotti = 4
    % Fantini = 5

    length(Primi,5),
    length(Secondi,5),
    length(PrimiOrd,5),
    length(SecondiOrd,5),

    Primi::1..5,
    Secondi::1..5,
    PrimiOrd::1..5,
    SecondiOrd::1..5,

    %impongo che i piatti siano viersi
    alldifferent(Primi),
    alldifferent(PrimiOrd),
    alldifferent(Secondi),
    alldifferent(SecondiOrd),

    %vincoli
    %1:  Bizzi riceve il primo piatto che era stato chiesto da Dotti.
    nth1(2,Primi,PrimoBizzi),
    nth1(4,PrimiOrd,PrimoDottiOrd),
    PrimoBizzi #= PrimoDottiOrd,

    %2 Costa ha ricevuto (esattamente) uno dei piatti ordinati da Dotti.
    nth1(4,PrimiOrd,PrimoDottiOrd), %ridontante
    nth1(4,SecondiOrd,SecondoDottiOrd),
    nth1(3,Primi,PrimoCosta),
    nth1(3,Secondi,SecondoCosta),
    PrimoCosta #= PrimoDottiOrd #<=> B1,
    SecondoCosta #= SecondoDottiOrd #<=> B2,
    B1 + B2 #= 1,

    %3 Dotti non ha ricevuto piatti ordinati da Costa.
    nth1(4,Primi,PrimoDotti),
    nth1(4,Secondi,SecondoDotti),
    nth1(3,PrimiOrd,PrimoCostaOrd),
    nth1(3,SecondiOrd,SecondoCostaOrd),
    PrimoDotti #\= PrimoCostaOrd,
    SecondoDotti #\= SecondoCostaOrd,

   

    %5 Aldini ha ricevuto almeno un piatto ordinato da Bizzi.
    nth1(1,Primi,PrimoAldini),
    nth1(1,Secondi,SecondoAldini),
    nth1(2,PrimiOrd,PrimoBizziOrd),
    nth1(2,SecondiOrd,SecondoBizziOrd),
    PrimoAldini #= PrimoBizziOrd #<=> B3,
    SecondoAldini #= SecondoBizziOrd #<=> B4,
    B3 + B4 #> 0,

    %4 Fantini ha ricevuto due piatti ordinati da due persone diverse.
    nth1(5,Primi,PrimoFantini),
    nth1(5,Secondi,SecondoFantini),
    ricerca(PrimoFantini, PrimiOrd, Idx1,1), 
    ricerca(SecondoFantini, SecondiOrd, Idx2,1),
    Idx1 #\= Idx2,

    %Calcolo la funzione di costo
    costo(Primi,PrimiOrd,Cprimi),
    costo(Secondi,SecondiOrd,Csecondi),
    C #= Cprimi + Csecondi,

    %labeling e minimize
    % minimize(labeling([Primi,Secondi,PrimiOrd, SecondiOrd]),C).
    %flatten([Primi,Secondi,PrimiOrd, SecondiOrd],Out),

    /*
    append(Primi,Secondi,Out1),
    append(Out1,PrimiOrd,Out2),
    append(Out2,SecondiOrd,Out3),
    */

    flatten([Primi,Secondi,SecondiOrd,PrimiOrd],Out),
    labeling(Out).

% ricerca(X,L,N,1).


ricerca(X,[Y|T],N,N1):-
    X #=Y #<=> N#=N1,
    N2 is N1+1,
    ricerca(X,T,N,N2).



costo([],[],0).
costo([H1|T1],[H2|T2],Somma) :-costo(T1,T2,Somma1), ( H1 #= H2 -> Somma is Somma1  ;  Somma is Somma1 + 1).
