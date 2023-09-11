p(1).
p(0).
p(3).

grande :- 2 < #max{X:p(X)}.

somma(S) :- #sum{X:p(X)} = S.