time(1..MaxEnd):- endtime(MaxEnd). 

% O finisce all'istante T
1{schedulato(O,T):time(T)}1:- ordine(O,Scadenza).

%no due servizi contemporaneamente
:- schedulato(O1,T), schedulato(O2,T), O1 != O2.

%precedenze
:-  schedulato(O1,T1), schedulato(O2,T2), precedenza(O1,O2), T1 > T2.
:-  schedulato(O1,T1), schedulato(O2,T2), precedenza(O2,O1), T2 > T1.

%conto le scandenze soddisfatte
inTempo(O) :- schedulato(O,T), ordine(O,Scadenza), T < Scadenza.

#maximize{1,O:inTempo(O)}.