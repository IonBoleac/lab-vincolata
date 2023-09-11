edge(1,2).
edge(2,1).
edge(1,3).
edge(4,2).
edge(4,3).

reachable(1).
reachable(Y) :- reachable(X), edge(X,Y). %questo body ha 2 atomi positivi quindi è safe

% in prolog ci sarebbe un loop infinito
% in ASP invece termina sempre. perchè tutto il programma è safe