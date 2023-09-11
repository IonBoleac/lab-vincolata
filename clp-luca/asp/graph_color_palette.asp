%esercizio map coloring slide 49 pacco 13_ASP
nodo(1).
nodo(2).
nodo(3).
nodo(4).
nodo(5).

near(1,2).
near(1,3).
near(2,3).
near(2,4).
near(2,5).
near(3,4).

palette(red).
palette(green).
palette(yellow).

%{} facciamo scegliere al solver cosa è vero e cosa è falso
{color(X,C)} :- nodo(X), palette(C).

%vincoli di integrità (testa vuota = sottointeso falso)
%dico quando il modello non va bene

%un nodo deve avere almeno un colore
:- not color(Nodo,_), nodo(Nodo).
%un nodo deve avere al massimo un colore
:- color(Nodo,Colore1),  color(Nodo,Colore2), Colore1 != Colore2, nodo(Nodo). 


%due nodi vicini hanno colori diversi
:- color(Nodo1,Colore), color(Nodo2,Colore), near(Nodo1,Nodo2).