ordine(1,10).
ordine(2,15).
ordine(3,12).
ordine(4,8).
ordine(5,13).
ordine(6,5).
ordine(7,10).
ordine(8,3).
ordine(9,6).
ordine(10,4).
ordine(11,7).
ordine(12,14).
ordine(13,8).
ordine(14,15).

precedenza(1,5).
precedenza(5,3).
precedenza(7,4).
precedenza(5,10).
precedenza(13,14).

endtime(20).

timeStamp(0..EndTime) :- endtime(EndTime).

% creare una evasione per ogni ordine con il suo timestamp
1{evasione(ID, Timestamp):timeStamp(Timestamp)}1 :- ordine(ID, _).

:- evasione(ID, TimeStamp1), evasione(ID, TimeStamp2), TimeStamp1 != TimeStamp2.

% imponi le precedenze
:- evasione(ID1, Timestamp1), evasione(ID2, Timestamp2), precedenza(ID1, ID2), Timestamp1 > Timestamp2.
:- evasione(ID1, Timestamp1), evasione(ID2, Timestamp2), precedenza(ID2, ID1), Timestamp1 < Timestamp2.

% calcola il guadagno
controlloGuadagno(Guadagno) :- #count{ID:evasione(ID, TimeStamp)} = Guadagno, timeStamp(TimeStamp), ordine(ID, DeadLine), TimeStamp <= DeadLine.

#maximize{1,Guadagno:controlloGuadagno(Guadagno)}.