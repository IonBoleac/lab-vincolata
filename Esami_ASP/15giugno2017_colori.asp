car(1,red).
car(2,blue).
car(3,yellow).
car(4,red).
car(5,yellow).
car(6,blue).
car(7,red).

maxd(2).
tempo(1..7).


1{collocamentoMacchina(Macchina, Colore, Quando):tempo(Quando)}1 :- car(Macchina, Colore).

:- collocamentoMacchina(Macchina, _, Quando1), collocamentoMacchina(Macchina, _, Quando2), Quando1 != Quando2.

% vincolo maxD
:- collocamentoMacchina(Macchina, _, Quando), maxd(MaxD), Quando > Macchina + MaxD.
:- collocamentoMacchina(Macchina, _, Quando), maxd(MaxD), Quando < Macchina - MaxD.

cambio(Quando) :- collocamentoMacchina(_, Colore1, Quando), collocamentoMacchina(_, Colore2, Quando+1), Colore1 = Colore2.

costo(Costo) :- #count{Quando:cambio(Quando)} = Costo.
#minimize{Costo:costo(Costo)}.