%es maximum clique slide 24 pacco 13_ASP

%fatti di prova (grafo sulle slide)


arc(1,2).
arc(1,3).
arc(1,4).

arc(2,1).
arc(2,3).
arc(2,4).

arc(3,1).
arc(3,2).
arc(3,4).

arc(4,1).
arc(4,2).
arc(4,3).
arc(4,5).

arc(5,2).
arc(5,4).

%vincoli (prendo i nodi che sono collegati almeno fra loro)
{nodo(X)} :- arc(X,_).

%impongo che i nodi che prendo siano completamente collegati
:- nodo(X), nodo(Y),  not arc(Y,X), X != Y.
:- nodo(X), nodo(Y),  not arc(X,Y), X != Y.

%massimizzo il numero di nodi
#maximize{1,X:nodo(X)}.