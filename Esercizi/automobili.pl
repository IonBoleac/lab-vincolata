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


rich(1,420,1,0,1).
rich(2,150,0,0,1).
rich(3,440,1,1,1).
rich(4,270,1,0,1).
rich(5,660,1,0,0).
rich(6,330,0,1,0).
%rich(7,500,0,0,1).
%rich(8,730,0,1,0).

:- lib(fd).
:- lib(edge_finder).

% cumulative(+StartTimes, +Durations, +Resources, ++ResourceLimit)

% crea job per optional -> Cerchi = 1, Aria = 2, Sat = 3
% cerchi in lega: 20 minuti
% aria condizionata: 80 minuti
% navigatore satellitare: 50 minuti

% job(Num, Consegna, Optional, Durata, StartTime)

csp(LJobTot, LAuto) :-
    findall(rich(Num,Consegna,CerchiLega,AriaCondizionata,Satellitare), rich(Num,Consegna,CerchiLega,AriaCondizionata,Satellitare), Ldata),
    findall(Num, rich(Num,_,_,_,_), LAuto),

    % crea un job per tipo di optional
    creaJobAriaCondizionata(Ldata, LJobAria),
    creaJobCerchiLega(Ldata, LJobCerchi),
    creaJobNavSat(Ldata, LJobNavSat),

    append(LJobAria, LJobCerchi, LJobTemp),
    append(LJobTemp, LJobNavSat, LJobTot),


    % disjunctive per optional
    disjunctivePerOptional(LJobCerchi, LStartTimeCerchi),
    disjunctivePerOptional(LJobAria, LStartTimeAria),
    disjunctivePerOptional(LJobNavSat, LStartTimeNavSat),

    % disjunctive per macchina
    disjunctivePerMacchina(LAuto, LJobTot),


    labeling(LStartTimeCerchi),
    labeling(LStartTimeAria),
    labeling(LStartTimeNavSat).

estraiStarTimePerAuto(_, [], [], []).
estraiStarTimePerAuto(Num, [job(Num, _, _, Durata, StartTime)|Tjob], [StartTime|TStartTime], [Durata|TDurata]):-
    estraiStarTimePerAuto(Num, Tjob, TStartTime, TDurata).
estraiStarTimePerAuto(Num1, [job(Num, _, _, _, _)|Tjob], LStartTime, LDurate) :-
    Num1 #\= Num,
    estraiStarTimePerAuto(Num1, Tjob, LStartTime, LDurate).

disjunctivePerMacchina([], _).
disjunctivePerMacchina([Num|Tauto], LJob):-
    estraiStarTimePerAuto(Num, LJob, StartTimes, Durations),
    edge_finder:disjunctive(StartTimes, Durations),
    disjunctivePerMacchina(Tauto, LJob).

estraiStartTime([], [], []).
estraiStartTime([job(_, _, _, Durata, StartTime)|T], [StartTime|TStartTime], [Durata|TDurata]):-
    estraiStartTime(T, TStartTime, TDurata).

disjunctivePerOptional(Ljob, LStartTime) :-
    estraiStartTime(Ljob, LStartTime, LDurate),
    edge_finder:disjunctive(LStartTime, LDurate).

creaJobCerchiLega([], []).
creaJobCerchiLega([rich(Num, Consegna, 1, _, _)|Tdata], [job(Num, Consegna, 1, Durata, StartTime)|Tjob]) :-
    Durata #= 20,
    StartTime :: 0..(Consegna - Durata),
    creaJobCerchiLega(Tdata, Tjob).
creaJobCerchiLega([rich(_, _, 0, _, _)|Tdata], Ljob):-
    creaJobCerchiLega(Tdata, Ljob).


creaJobAriaCondizionata([], []).
creaJobAriaCondizionata([rich(Num, Consegna, _, 1, _)|Tdata], [job(Num, Consegna, 2, Durata, StartTime)|Tjob]) :-
    Durata #= 20,
    StartTime :: 0..(Consegna - Durata),
    creaJobAriaCondizionata(Tdata, Tjob).
creaJobAriaCondizionata([rich(_, _, _, 0, _)|Tdata], Ljob):-
    creaJobAriaCondizionata(Tdata, Ljob).


creaJobNavSat([], []).
creaJobNavSat([rich(Num, Consegna, _, _, 1)|Tdata], [job(Num, Consegna, 3, Durata, StartTime)|Tjob]) :-
    Durata #= 20,
    StartTime :: 0..(Consegna - Durata),
    creaJobNavSat(Tdata, Tjob).
creaJobNavSat([rich(_, _, _, _, 0)|Tdata], Ljob):-
    creaJobNavSat(Tdata, Ljob).