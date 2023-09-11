
car(1,rosso).
car(2,giallo).
car(3,rosso).
car(4,verde).
car(5,giallo).

maxd(1).

position(P) :- car(P,_).

%domini
%devo un solo fatto per auto
{pos(NewPos,OldPos,Col):position(NewPos)}=1 :- car(OldPos, Col).

%vincoli
%max D
:- pos(NewPos,OldPos,Col), maxd(MaxD), | NewPos - OldPos | > MaxD.

%anche Newpos essere unico (no 2 auto insieme )
:- pos(NewPos,OldPos1,Col1), pos(NewPos,OldPos2,Col2), OldPos1 != OldPos2.
:- pos(NewPos,OldPos1,Col1), pos(NewPos,OldPos2,Col2), Col1 != Col2.

%ottimizzazione
switch(P) :- pos(P,_,Col1), pos(P+1,_,Col2), Col1 != Col2. 

#minimize{1,P:switch(P)}.