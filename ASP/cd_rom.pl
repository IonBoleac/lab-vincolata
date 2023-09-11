%fatti di prova
file(0,500).
file(1,50).
file(2,100).
file(3, 200).

capacita(600).

{cd(ID, Cap)} :- file(ID, Cap).
tot(S) :- #sum{Cap,ID:cd(ID, Cap)} = S.

:- #sum{Cap,ID:cd(ID, Cap)} > 600.
#maximize {Cap,ID:cd(ID, Cap)}.

#show cd/2.