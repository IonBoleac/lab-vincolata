%stampe([1,5,4,3,4,2],LS,STA,13,D).
% task(ID,EST,LCT,D)
% EST (Earliest Start Time),
% LCT (Latest Completion Time)
% D (Durata)


maxend(20).
tempo(0..MaxEnd):- maxend(MaxEnd).

task(1,1,16,1).
task(2,4,11,3).
task(3,11,18,2).
task(4,15,20,1).
task(5,1,12,2).
task(6,1,8,2).

1 {stampa(ID, StartStamp, EndStamp, EST, LCT, D):tempo(StartStamp), EndStamp = StartStamp + D} 1 :- task(ID, EST, LCT, D).

% imponi la finestra di stampa
:- stampa(ID, StartStamp, EndStamp, EST, LCT, D), StartStamp < EST.
:- stampa(ID, StartStamp, EndStamp, EST, LCT, D), StartStamp > LCT.

% disjunctive
:- stampa(ID1, StartStamp1, EndStamp1, EST1, LCT1, D1), stampa(ID2, StartStamp2, EndStamp2, EST2, LCT2, D2), ID1 != ID2, StartStamp1 < StartStamp2, StartStamp2 < EndStamp1.
:- stampa(ID1, StartStamp1, EndStamp1, EST1, LCT1, D1), stampa(ID2, StartStamp2, EndStamp2, EST2, LCT2, D2), ID1 != ID2, StartStamp2 < StartStamp1, StartStamp1 < EndStamp2.

calcDist(Dist) :- 
    stampa(ID1, StartStamp1, EndStamp1, EST1, LCT1, D1), stampa(ID2, StartStamp2, EndStamp2, EST2, LCT2, D2), ID1 != ID2,
    Dist = StartStamp1 - EndStamp2, Dist > 0.
calcDist(Dist) :- 
    stampa(ID1, StartStamp1, EndStamp1, EST1, LCT1, D1), stampa(ID2, StartStamp2, EndStamp2, EST2, LCT2, D2), ID1 != ID2,
    Dist = StartStamp2 - EndStamp1, Dist > 0.

trovaMin(Min) :- #min{Dist:calcDist(Dist)} = Min.

#maximize{MinDist:trovaMin(MinDist)}.
