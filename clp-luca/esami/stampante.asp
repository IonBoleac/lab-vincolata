maxend(20).
tempo(0..MaxEnd):- maxend(MaxEnd).


%task(ID,EST,LCT,D)

task(1,1,16,1).
task(2,4,11,3).
task(3,11,18,2).
task(4,15,20,1).
task(5,1,12,2).
task(6,1,8,2).

%dominio
1{taskSE(ID,EST,LCT,D,Start,End):tempo(Start), End = Start + D }1:- task(ID,EST,LCT,D).

%EST e LCT
:- taskSE(ID,EST,LCT,D,Start,End), Start < EST.
:- taskSE(ID,EST,LCT,D,Start,End), End > LCT.

%calcolo nel distanze
distanza(Dist) :- taskSE(ID1,EST1,LCT1,D1,Start1,End1), taskSE(ID2,EST2,LCT2,D2,Start2,End2) , ID1 != ID2, Dist = Start1 - End2, Dist >= 0.
distanza(Dist) :- taskSE(ID1,EST1,LCT1,D1,Start1,End1), taskSE(ID2,EST2,LCT2,D2,Start2,End2) , ID1 != ID2, Dist = Start2 - End1 , Dist >= 0.

%disjunctive
:- taskSE(ID1,EST1,LCT1,D1,Start1,End1), taskSE(ID2,EST2,LCT2,D2,Start2,End2), ID1 != ID2, Start1 < Start2, Start2 < End1.
:- taskSE(ID1,EST1,LCT1,D1,Start1,End1), taskSE(ID2,EST2,LCT2,D2,Start2,End2), ID1 != ID2, Start2 > Start1, Start1 < End2. 
:- taskSE(ID1,EST1,LCT1,D1,Start,End1), taskSE(ID2,EST2,LCT2,D2,Start,End2), ID1 != ID2.

%ottimizzazione
min(MinDist) :- #min{Dist:distanza(Dist)} = MinDist.
#maximize{D,D:min(D)}.