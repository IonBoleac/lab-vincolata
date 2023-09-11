/*
Una linea di produzione deve produrre dei trattori.

Nel file production.pl viene dato un insieme di ordini; ogni ordine è rappresentato da un fatto

ordine(ID,Deadline)
dove

ID rappresenta l'identificativo dell'ordine (un numero intero)
Deadline è la scadenza entro cui l'ordine andrebbe evaso, in una certa unità di tempo (es. in giorni). 
Se l'ordine viene evaso entro la scadenza, dà luogo ad un guadagno, altrimenti non dà luogo ad alcun guadagno.
Produrre un ordine impiega una unità di tempo e consuma tutte le risorse disponibili. 
Si può cominciare a produrre a partire dall'istante 0.

Ci sono vincoli di precedenza fra gli ordini; le precedenze sono riportate in fatti

precedenza(ID1,ID2)
un tale fatto significa che l'ordine con identificativo ID1 deve essere terminato prima che si inizi a produrre l'ordine ID2.

Tutti gli ordini devono essere terminati entro l'istante di tempo riportato nel fatto

endtime/1.
Qualora un ordine venga evaso entro la sua scadenza, si ottiene un guadagno unitario; 
gli ordini che non vengono terminati entro la scadenza non danno luogo ad alcun guadagno.

Si desidera massimizzare il guadagno totale.
*/


:- lib(fd).
:- lib(cumulative).
:- lib(propia).

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


csp(L, GuadagnoTot, Time) :-
    % variabili
    endtime(Endtime), % indica il tempo massimo della fine della produzione
    length(L, 14),
    L :: [1..14],
    NotGuadagnoTot :: 0..14,

    % vincoli
    alldifferent(L),
    calc_guadagno(L, GuadagnoTot, Time),
    Time #=< Endtime,

    NotGuadagnoTot #= 14 - GuadagnoTot,

    % labeling
    min_max(labeling(L), NotGuadagnoTot).
    
    

calc_guadagno([A], 1, 1) :- 
    ordine(A, _) infers ac, !.

calc_guadagno([ID, H|T], GuadagnoTot, Time) :-
    ordine(ID, Deadline) infers ac,
    
    
    precedenza(ID, B) infers ac, % qua la questione delle precedenze è da sistemare. Errore forse qui
    ( ( ID #= A #/\ H #= B ) #=> (ID #= A, H #= B); true ),
    
    Deadline #<= Time #<=> B #= 1,
    GuadagnoTot #= B + GuadagnoTot1,
    Time #= Time1 + 1,

    calc_guadagno([H|T], GuadagnoTot1, Time1).




