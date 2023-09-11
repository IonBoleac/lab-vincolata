/*
Un'azienda che produce automobili ha tre linee di montaggio per
inserire i tre possibili optional: cerchi in lega, aria condizionata e
navigatore satellitare. Si ha una sequenza di richieste, memorizzate nel
file automobili.pl; ciascuna richiesta è strutturata come segue:

rich(Num,Consegna,CerchiLega,AriaCondizionata,Satellitare).

dove
Num è un identificatore univoco della richiesta

Consegna è l'orario massimo di consegna (in minuti)

CerchiLega, AriaCondizionata e Satellitare sono i possibili
optional: essi valgono 1 se l'optional è stato richiesto, 0 altrimenti.

Si hanno i seguenti vincoli:

ciascuna automobile può essere mandata in una delle 3 linee di
montaggio degli optional (non può essere contemporaneamente in due
linee)

ciascuna linea di montaggio può lavorare su un'automobile alla volta

l'installazione degli optional ha i seguenti tempi        
cerchi in lega: 20 minuti

aria condizionata: 80 minuti

navigatore satellitare: 50 minuti

*/
:-lib(fd).
:-lib(edge_finder).
rich(1,420,1,0,1).
rich(2,150,0,0,1).
rich(3,440,1,1,1).
rich(4,270,1,0,1).
rich(5,660,1,0,0).
rich(6,330,0,1,0).
%rich(7,500,0,0,1).
%rich(8,730,0,1,0).

createJobCerchiLega([], []):-!.
createJobCerchiLega([rich(Num, Consegna, 1, _, _)|T1], [job(Num, 1, Consegna, StartTime, EndTime, Durate)|T2]):-
    Durate #= 20,
    StartTime :: 0..(Consegna - Durate),
    EndTime #= StartTime + Durate,
    % EndTime #<= Consegna,
    createJobCerchiLega(T1, T2).
createJobCerchiLega([rich(_, _, 0, _, _)|T1], L):-
    createJobCerchiLega(T1, L).

createJobAriaCondizionata([], []):-!.
createJobAriaCondizionata([rich(Num, Consegna, _, 1, _)|T1], [job(Num, 2, Consegna, StartTime, EndTime, Durate)|T2]):-
    Durate #= 80,
    StartTime :: 0..(Consegna - Durate),
    EndTime #= StartTime + Durate,
    % EndTime #<= Consegna,
    createJobAriaCondizionata(T1, T2).
createJobAriaCondizionata([rich(_, _, _, 0, _)|T1], L):-
    createJobAriaCondizionata(T1, L).

createJobSatellitare([], []):-!.
createJobSatellitare([rich(Num, Consegna, _, _, 1)|T1], [job(Num, 3, Consegna, StartTime, EndTime, Durate)|T2]):-
    Durate #= 50,
    StartTime :: 0..(Consegna - Durate),
    EndTime #= StartTime + Durate,
    % EndTime #<= Consegna,
    createJobSatellitare(T1, T2).
createJobSatellitare([rich(_, _, _, _, 0)|T1], L):-
    createJobSatellitare(T1, L).

disjunctivePerOptional(List, LStartTime) :- 
    estraiStartTime(List, LStartTime, LDurate),
    edge_finder:disjunctive(LStartTime, LDurate).
    
    

estraiStartTime([], [], []) :- !.
estraiStartTime([job(_, _, _, StartTime, _, Durate)|T], [StartTime|T1], [Durate|T2]) :-
    estraiStartTime(T, T1, T2).

% disjunctivePerMacchina(Lista) PER OGNI MACCHINA
disjunctivePerMacchina(_, []) :- !.
disjunctivePerMacchina(ListJobs, [Num|T1]) :-
    estraiStarTimePerAuto(ListJobs, Num, ListStarTime, ListDurate),
    edge_finder:disjunctive(ListStarTime, ListDurate),
    disjunctivePerMacchina(ListJobs, T1).


estraiStarTimePerAuto([], _, [], []):-!.
estraiStarTimePerAuto([job(Num, _, _, StartTime, _, Durata)|T1], Num, [StartTime|T2], [Durata|T3]) :-
    estraiStarTimePerAuto(T1, Num, T2, T3).
estraiStarTimePerAuto([_|T1], Num, L, L1) :- estraiStarTimePerAuto(T1, Num, L, L1).
    


csp(JobsList, LStartTimeCerchi, LStartTimeAria, LStartTimeSatellitare) :-
    findall(rich(Num,Consegna,CerchiLega,AriaCondizionata,Satellitare), rich(Num,Consegna,CerchiLega,AriaCondizionata,Satellitare), Data),
    findall(Num, rich(Num, _, _, _, _), LAuto),

    % creato i job di tutte le macchine del tipo -> job(Num, TipoJob, Consegna, StartTime, EndTime, Durata)
    % JobsList è la lista di tutti i job che devono essere fatti
    createJobCerchiLega(Data, LCerchi),
    createJobAriaCondizionata(Data, LAria),
    createJobSatellitare(Data, LSatellitare),
    append(LCerchi, LAria, TempList),
    append(TempList, LSatellitare, JobsList),

    % disjunctive per tipo di optional
    disjunctivePerOptional(LCerchi, LStartTimeCerchi),
    disjunctivePerOptional(LAria, LStartTimeAria),
    disjunctivePerOptional(LSatellitare, LStartTimeSatellitare),

    % disjunctive per macchina (non può installare più optional alla volta)
    disjunctivePerMacchina(JobsList, LAuto),

    % imporre il vincolo che la macchina sia pronta entro 

    labeling(LStartTimeCerchi),
    labeling(LStartTimeAria),
    labeling(LStartTimeSatellitare).



