%es cdrom slide 21 pacco 13_asp

%fatti di prova
file(0,500).
file(1,50).
file(2,100).
file(3, 200).

% faccio scegliere quali costi prendere e quali no
{peso(C,Id)} :- file(Id,C).

% impongo che la somma debba essere minore di 600
:- 600 < #sum{C:peso(C,Id)} .

% massimizzo la somma dei pesi 
#maximize {C,Id : peso(C,Id)}.
