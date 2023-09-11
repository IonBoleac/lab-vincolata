package(1).
package(2).
package(3).
package(4).
package(5).
package(6).
package(7).
package(8).
package(9).
package(10).

installed(1).
installed(5).
installed(6).
installed(8).

requires(1,2).
requires(3,4).

conflict(4,2).
conflict(5,4).

install(3).

% dominio
{newInstalled(Num)} :- package(Num).

% installare il pachetto richiesto
newInstalled(Num) :- install(Num).

% impostare i requires
:- requires(Num1, Num), newInstalled(Num1), not newInstalled(Num).

% impostare i conflitti
:- conflict(A, B), newInstalled(A), newInstalled(B).

% calc differenze
diff(Num) :- installed(Num), not newInstalled(Num).
diff(Num) :- not installed(Num), newInstalled(Num).

conta(Conta) :- #count{Num:diff(Num)} = Conta.

#minimize{Conta:conta(Conta)}.

#show newInstalled/1.