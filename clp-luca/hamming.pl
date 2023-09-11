:-lib(fd).
:-lib(fd_global).

%csp(4,3,Righe)
csp(N,M,Righe) :-
    %creo la matrice
    length(Righe,N),
    %creo le righe (una alla volta)
    crea_liste(Righe,M),

    cicla_righe(Righe,ListaVicinanza),
    flatten(ListaVicinanza,ListaVicinanzaFlat),
    maxlist(ListaVicinanzaFlat,C),

    flatten(Righe,Righeflat),
    minimize(labeling(Righeflat),C).

    
%per ogni riga definisco una lista di N elementi
crea_liste([],_).
crea_liste([H|T],N) :- length(H, N), H :: 0..1, crea_liste(T,N). 

%calcolo il numero di bit uguali in 2 liste
calcola_uguaglianza([],[],0).
calcola_uguaglianza([H1|T1],[H2|T2],Tot) :- H1 #= H2 #<=> B, calcola_uguaglianza(T1,T2,Tot1), Tot #= Tot1 + B.

%calcola uguaglianze
cicla_righe([],[]).
cicla_righe([Hr|Tr],[L|Tout]) :- confronta(Hr,Tr,L), cicla_righe(Tr,Tout).


confronta(_,[],[]).
confronta(Hr,[H|T],[Vicinanza|Tout]) :- calcola_uguaglianza(Hr,H,Vicinanza), confronta(Hr,T,Tout).