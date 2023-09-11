:- lib(fd).
:- lib(fd_global).
:- [impegni].

% Valori possibili
% con genitore X -> X (X=1..2)
% asilo estivo -> 3
% tata -> 4
estate(L):-
 length(L,30),
 L :: 1..4,
 impegni_genitori(L,1),
 occurrences(1,L,GiorniPadre),
 GiorniPadre :: 0..4,
 occurrences(2,L,GiorniMadre),
 GiorniMadre :: 0.. 6,
 occurrences(4,L,GiorniTata),
 Costo #= 10*VaAsilo+5*GiorniTata,
 asilo(L,1,PrimoGiornoAsilo,UltimoGiornoAsilo,VaAsilo),
 UltimoGiornoAsilo-PrimoGiornoAsilo #< 7,
 min_max((labeling(L)),Costo).

asilo([],_,_,_,_).
asilo([H|T],N,Primo,Ultimo,VaAsilo):-
 H #= 3 #=> VaAsilo,
 H #= 3 #=> Primo #=< N,
 H #= 3 #=> Ultimo #>= N,
 N1 is N+1,
 asilo(T,N1,Primo,Ultimo,VaAsilo).

impegni_genitori([],_).
impegni_genitori([H|T],Giorno):-
 findall(Genitore,impegno(Genitore,Giorno),GenitoriImpegnati),
 elimina_valori(H,GenitoriImpegnati),
 Giorno1 is Giorno+1,
 impegni_genitori(T,Giorno1).

elimina_valori(_,[]).
elimina_valori(X,[H|T]):-
 X #\= H,
 elimina_valori(X,T).

% Stampa una lista di valori. 
% Ovviamente non e` indispensabile, e` solo per avere un output piu` leggibile
