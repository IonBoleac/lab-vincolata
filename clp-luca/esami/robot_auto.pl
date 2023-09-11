:-lib(fd).
:-lib(listut).
%esame 15 giugno 2017



%Esempio di Goal: csp( [rosso, giallo, rosso, verde, giallo],L,1).
% Lin = [rosso,giallo,verde,nero] ordine di ingresso delle auto
% L = per ogni auto la posizione in cui vengono lavorate
%     Indice = ordine in cui lavoro le auto, valore = macchina rispetto alla lista Lin
csp(Lin,L,MaxD) :- 
    %Variabili e domini
    length(Lin,NumeroAuto),
    length(L,NumeroAuto),
    L::1..NumeroAuto,

    %no due auto in istanti diveri
    alldifferent(L),

    %massima distanza di swap
    vincolo_posizione(L,1,MaxD),

    %calcolo costo
    calcola_costo(L,Lin,C),

    %labeling e minimize
    minimize(labeling(L),C).

% Il costo dipende dal numero di numero di cambi colore
% Scorro la lista L e guardo le rispettiva auto in Lin
% Sommo 1 ogni volt che c'è un cambio di colore
%calcola_costo(L, Costo)
calcola_costo([_],_,0).
calcola_costo([H1,H2|T],Lin,C) :-
      element(H1,Lin,Macchina1), element(H2,Lin,Macchina2), 
      (Macchina1 #\= Macchina2) #<=> B, 
      calcola_costo([H2|T],Lin,C1),
      C #= C1 + B.

%la distanza tra l'indice in L e il valore di Lin deve essere al massimo MaxD
vincolo_posizione([],_,_).
vincolo_posizione([H|T],Idx, MaxD) :- 
    H #=< Idx + MaxD, H #>= Idx - MaxD, 
    Idx1 #= Idx + 1,
    vincolo_posizione(T,Idx1,MaxD).