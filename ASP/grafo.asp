edge(1,3).
edge(3,2).
edge(4,3).
edge(4,2).
edge(6,2).
edge(5,6).
edge(6,5).

reachable(1).
reachable(X) :-
    reachable(Y), 
    edge(Y,X).

#show reachable/1.