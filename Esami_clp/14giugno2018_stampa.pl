:- lib(fd).
:- lib(fd_global).
:- lib(edge_finder).
:- [task_stampa].


% crea un fatto job per ogni task -> job(ID,EST,LCT,D,StartTime,EndTime)
% EST (Earliest Start Time),
% LCT (Latest Completion Time)
% D (Durata)

csp(LJob, Min, LStartTimes) :-
    findall(task(ID,EST,LCT,D), task(ID,EST,LCT,D), LTask),
    creaJobs(LTask, LJob),

    estrarreStartDurationTime(LJob, LStartTimes, Lduration),

    % le stampe devono essere separate
    edge_finder:disjunctive(LStartTimes, Lduration),

    calcDistanza(LJob, LDistanze),
    flatten(LDistanze, FlattenDistanze),

    fd_global:minlist(FlattenDistanze, Min),

    NegMin #= -Min,
    
    min_max(labeling(LStartTimes), NegMin).
    %labeling(LStartTimes).


listDistanzePerStampa(_, [], []).
listDistanzePerStampa(job(Num, _, _, _, HStartTime, HEndTime), [job(_, _, _, _, StartTime, EndTime)|TJob], [Dist|TDist]) :-
    Dist #= HStartTime - EndTime #<=> HStartTime#>= EndTime,
    Dist #= StartTime - HEndTime #<=> StartTime #>= HEndTime,
    listDistanzePerStampa(job(Num, _, _, _, HStartTime, HEndTime), TJob, TDist).

calcDistanza([_], []).
calcDistanza([H|T], [Dist|TDist]) :-
    listDistanzePerStampa(H, T, Dist),
    calcDistanza(T, TDist).


estrarreStartDurationTime([], [], []).
estrarreStartDurationTime([job(_,_,_,Duration,StartTime,_)|TJob], [StartTime|TS], [Duration|TD]) :-
    estrarreStartDurationTime(TJob, TS, TD).

creaJobs([], []).
creaJobs([task(ID,EST,LCT,D)|Ttask], [job(ID,EST,LCT,D,StartTime,EndTime)|TJob]) :-
    StartTime :: EST..LCT,
    EndTime #= StartTime + D,
    creaJobs(Ttask, TJob).