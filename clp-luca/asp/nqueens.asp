%CONFIGURAZIONE
dimensione(4).

%Fatto che ci permette di creare la scacchiera correttamente
scacchiera(1).
%scacchiera(K) è vero per ogni k da 1 a N
scacchiera(K+1) :- scacchiera(K), dimensione(N), K + 1 <= N.

% tutte le possibili posizioni delle regine
{queen(R,C)} :- scacchiera(R), scacchiera(C).

%vincoli di integrità(cosa non va bene)

%deve esserci almeno una regina per ogni riga
:- not queen(C,_), scacchiera(C).

%no 2 regine nella stessa cella
%:- queen(R,C), queen(C,R), scacchiera(R), scacchiera(C). 

%no 2 regine nella stessa colonna e riga
:- queen(R,C1), queen(R,C2), C1 != C2.
:- queen(R1,C), queen(R2,C), R1 != R2.

%diagonali
:- queen(R1,C1), queen(R2,C2), R1 != R2, R1 + C1 = R2 + C2.
:- queen(R1,C1), queen(R2,C2), R1 != R2, R1 - C1 = R2 - C2.