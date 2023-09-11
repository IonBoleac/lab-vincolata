% esame 26 luglio 2018

:-lib(fd).
:-lib(fd_global).
:-lib(listut).
:-[risposte].

csp(L) :-
    %variabili e domini
    length(Lass,6),
    length(Larmi,6),
    Lass::0..4,
    Larmi::0..4,

    append(Lass,Larmi,L),

    %numero di carte per giocatore (2 o 3)
    occurrences(1,L,Ncarte1),
    occurrences(2,L,Ncarte2),
    occurrences(3,L,Ncarte3),
    occurrences(4,L,Ncarte4),
    occurrences(0,Lass,NcarteBustaAss),
    occurrences(0,Larmi,NcarteBustaArmi),
    Ncarte1::2..3,
    Ncarte2::2..3,
    Ncarte3::2..3,
    Ncarte4::2..3,
    NcarteBustaAss #= 1,
    NcarteBustaArmi #= 1,

    %recupero lista di risposte
    findall(risposta(Richiedente,Rispondente,Assassino,Arma),risposta(Richiedente,Rispondente,Assassino,Arma),Lrisposte),

    vincolo_risposte(Lrisposte,Lass,Larmi),
   
    labeling(L).


vincolo_risposte([],_,_).
vincolo_risposte([risposta(Rich,Risp,Ass,Arm)|T],Lass,Larmi) :-
    nth1(Ass, Lass, Carta1), nth1(Arm ,Larmi, Carta2),
    (Risp #= 0 -> Carta1 #= 0 #\/ Carta1 #= Rich, Carta2 #= 0 #\/ Carta2 #= Rich ; Carta1 #= Risp #\/ Carta2 #= Risp),
    vincolo_risposte(T,Lass,Larmi).
