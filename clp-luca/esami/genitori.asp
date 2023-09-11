giorno(1..30).
bambino(1..4).

%Valori del dominio:
% 1 mamma
% 2 papà
% 3 asilo
% 4 babysitter

%dominio: per ogni giorno genero un fatto che dice dove sta il bambino
1{collocamento(Giorno,Bambino):bambino(Bambino)}1 :-  giorno(Giorno).

%contiamo i giorni padre / madre / tata
padre(Giorno) :- collocamento(Giorno, 2).
madre(Giorno) :- collocamento(Giorno, 1).
tata(Giorno) :- collocamento(Giorno, 4).
asilo(Giorno) :- collocamento(Giorno, 3).

%vincoli sul numero dei giorni
:- #count{P:padre(P)} > 4 .
:- #count{P:madre(P)} > 6 .
%:- #count{P:asilo(P)} > 7 .

%7 giorno di asilo al massimo (consecutivi)
:- collocamento(G1,3), collocamento(G2,3),  | G1 - G2 |  >= 7.

%impegno genitori
:- impegno(Genitore, Giorno), collocamento(Giorno, Genitore).

%calcolo del costo
costoTata(S) :- #count{Giorno:tata(Giorno)} = S.

pagare_asilo :- collocamento(Giorno,3), giorno(Giorno).

costo(C) :- pagare_asilo, costoTata(T), C = T*50 + 100 .
costo(C) :- not pagare_asilo, costoTata(T), C = T*50.
#minimize{C:costo(C)}.








%FATTI
impegno(1,2).
impegno(1,3).
impegno(1,7).
impegno(1,8).
impegno(1,10).
impegno(1,11).
impegno(1,12).
impegno(1,15).
impegno(1,20).
impegno(1,21).
impegno(1,23).
impegno(1,25).
impegno(1,28).
impegno(1,30).
impegno(2,1).
impegno(2,3).
impegno(2,4).
impegno(2,6).
impegno(2,7).
impegno(2,10).
impegno(2,11).
impegno(2,13).
impegno(2,14).
impegno(2,16).
impegno(2,17).
impegno(2,18).
impegno(2,19).
impegno(2,20).
impegno(2,23).
impegno(2,27).
impegno(2,28).
impegno(2,29).
impegno(2,30).