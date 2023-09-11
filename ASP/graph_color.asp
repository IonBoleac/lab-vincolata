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

color(X, red) :- nodo(X), not color(X, green), not color(X, yellow).
color(X, green) :- nodo(X),not color(X, red), not color(X, yellow).
color(X, yellow) :- nodo(X),not color(X, green), not color(X, red).

:- color(A, C), color(B, C), near(A, B).

#show color/2.
