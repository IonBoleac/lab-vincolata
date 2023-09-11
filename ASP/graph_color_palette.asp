near(1,2).
near(1,3).
near(2,3).
near(2,4).
near(2,5).
near(3,4).

nodo(1).
nodo(2).
nodo(3).
nodo(4).
nodo(5).

palette(red).
palette(green).
palette(yellow).

% color(X, red) :- nodo(X), not color(X, green), not color(X, yellow).
% color(X, green) :- nodo(X),not color(X, red), not color(X, yellow).
% color(X, yellow) :- nodo(X),not color(X, green), not color(X, red).

% le graffe servono per dire che clingo deve scegliere se mettere true o false il predicato color(X, C)
{color(X, C)} :- nodo(X), palette(C).
%1 {color(X,red); color(X,blue); color(X,green)} 1 :- nodo(X).
% tutti i nodi vanno colorati -> vincolo di integrità il quale ha sempre la testa vuota
:- nodo(X), not colorato(X).
colorato(X) :- nodo(X), color(X, C).

% ogni nodo deve avere al massimo un colore (un nodo non può avere due colori diversi)
:- nodo(A), nodo(B), color(A, CA), color(B, CB), A = B, palette(CA), palette(CB), CA != CB.

% i nodi vicini devono avere un colore differente
:- near(A, B), color(A, C), color(B, C).

#show color/2.