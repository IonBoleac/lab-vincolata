%esame 12 giugno 2019
:-lib(fd_global).
:-lib(fd).
:-lib(listut).

:-[production].

%Lista L: ordini che vengono evasi (es L[1] ordine che inizia in 0 e finisce in 1)

csp(L) :-
    %recupero input
    findall(precedenza(A,B),precedenza(A,B), Lprecedenze),
    findall(ordine(Id,Deadline),ordine(Id,Deadline), Lordini),
    length(Lordini,Nordini),
    endtime(MaxEnd),
    
    %dominio
    length(L,Nordini),
    fd_global:alldifferent(L),
    L::1..Nordini,
    

    %tutti devono terminare entro MaxEnd
    vincolo_maxend(L,MaxEnd),

    %le precedenze devono essere soddisfatte
    vincolo_precedenza(Lprecedenze,L),

    %calcolo il numero di ordini soddisfatti in tempo
    guadagno(Lordini, L, Guadagno),

    %ottimizzazione
    GuadagnoNeg #= -Guadagno,
    minimize(labeling(L),GuadagnoNeg).

vincolo_maxend([],_).
vincolo_maxend([H|T], MaxEnd) :- H #=< MaxEnd, vincolo_maxend(T,MaxEnd).

vincolo_precedenza([],_).
vincolo_precedenza([precedenza(A,B)|T], L) :- 
    nth1(A,L,EndA), nth1(B,L,EndB),
    EndA #< EndB,
    vincolo_precedenza(T,L).

guadagno([],_,0).
guadagno([ordine(Id,Deadline)|T],L, Guadagno) :- 
    nth1(Id, L, Ordine),
    Ordine #< Deadline #<=> B,
    guadagno(T,L,Guadagno1),
    Guadagno #= Guadagno1 + B.