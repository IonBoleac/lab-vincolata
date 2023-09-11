scacchiera(1..8).

{queen(R,C)} :- scacchiera(R), scacchiera(C).

%% vincoli di integrità
% almeno una regina per riga e colonna
%:- not queen(R, C), scacchiera(R), scacchiera(C).
:- not queen(C,_), scacchiera(C).

%no 2 regine nella stessa colonna e riga
:- queen(R,C1), queen(R,C2), scacchiera(R), scacchiera(C1), scacchiera(C2), C1 != C2.
:- queen(R1,C), queen(R2,C), scacchiera(R1), scacchiera(R2), scacchiera(C), R1 != R2.

%diagonali
:- queen(R1,C1), queen(R2,C2), R1 != R2, R1 + C1 = R2 + C2.
:- queen(R1,C1), queen(R2,C2), R1 != R2, R1 - C1 = R2 - C2.

%#show queen/2.