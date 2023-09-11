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

giorno(1..30).
chi(1..4).
% 1 padre
% 2 madre
% 3 asilo
% 4 tata

% per ogni giorno creare esattamente un atomo del tipo collocamento(), dove Chi viene preso 
% dal dominio di chi()
1 {collocamento(Giorno, Chi):chi(Chi)} 1:- giorno(Giorno).

% imporre gli impegni
:- collocamento(Giorno, Chi), impegno(Chi, Giorno). 

% vincolo dei genitori sul numero dei giorni
:- #count{ID:collocamento(ID, 1)} > 4. % vincolo padre non più di 4 giorni
:- #count{ID:collocamento(ID, 2)} > 6. % vincolo madre non più di 6 giorni

% vincolo asilo
:- collocamento(Giorno1, 3), collocamento(Giorno2, 3), | Giorno1 - Giorno2 | > 7.

% conta il numero di giorni con la tata
sumTata(SumTata) :- #count{Giorno:collocamento(Giorno, 4)} = SumTata.

% controlla se è andato all'asilo
isAsilo(IsAsilo) :- #sum{1:collocamento(Giorno, 3)} = IsAsilo.

% contare il costo
costo(Costo) :- sumTata(SumTata), isAsilo(IsAsilo), SumTata*50 + IsAsilo*100 = Costo.

#minimize{Costo:costo(Costo)}.

#show collocamento/2.
%#show giorno/1.
#show isAsilo/1.