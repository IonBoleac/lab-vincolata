:-lib(fd).
rich(1,420,1,0,1).
rich(2,150,0,0,1).
rich(3,440,1,1,1).
rich(4,270,1,0,1).
rich(5,660,1,0,0).
rich(6,330,0,1,0).
rich(7,500,0,0,1).
rich(8,730,0,1,0).

setStartTimes([], []) :- !.
setStartTimes([rich(Num,Consegna,CerchiLega,AriaCondizionata,Satellitare)|T1], [rich(Num,Consegna,CerchiLega,AriaCondizionata,Satellitare, StartCerchiLega, StartAriaCondizionata, StartSatellitare)|T2]) :-
    ( CerchiLega #= 1 -> StartCerchiLega :: 0..(Consegna - 20) ; StartCerchiLega #= -1 ),
    ( AriaCondizionata #= 1 -> StartAriaCondizionata :: 0..(Consegna - 80) ; StartAriaCondizionata #= -1 ),
    ( Satellitare #= 1 -> StartSatellitare :: 0..(Consegna - 50) ; StartSatellitare #= -1 ),
    setStartTimes(T1, T2).

getStartTimeCerchiLega([], [], []) :- !.
getStartTimeCerchiLega([rich(Num,Consegna,1,AriaCondizionata,Satellitare, StartCerchiLega, StartAriaCondizionata, StartSatellitare)|T1], [StartCerchiLega|T2], [Num|T3]) :-
    getStartTimeCerchiLega(T1,T2,T3).
getStartTimeCerchiLega([_|T1], [_|T2], [_|T3]):-
    getStartTimeCerchiLega(T1,T2,T3).


    

csp(NumListCerchiLega) :-
    findall(rich(Num,Consegna,CerchiLega,AriaCondizionata,Satellitare), rich(Num,Consegna,CerchiLega,AriaCondizionata,Satellitare), Data),
    setStartTimes(Data, Task), % task nella forma rich(Num,Consegna,CerchiLega,AriaCondizionata,Satellitare, StartCerchiLega, StartAriaCondizionata, StartSatellitare)
    getStartTimeCerchiLega(Task, TimeListCerchiLega, NumListCerchiLega).