%esame 14 giugno 2018
:- lib(fd).
:- lib(edge_finder3).
:- [task].

% task(ID,EST,LCT,D)
%EST = earliest start time
%LCT = latest completion time
%D = Durata

csp(Lstart, Min) :-
    %recupero input
    findall(task(ID,EST,LCT,D),task(ID,EST,LCT,D),Ltask),

    %vincolo EST e LCT
    vincolo_estlct(Ltask, LConstarttime, Lstart, Ldur),
    disjunctive(Lstart,Ldur),

    %calcolo la distanza tra tutte le coppie di task
    scorriLista(LConstarttime, Ldistanze),
    flatten(Ldistanze,LdistanzeFlat),

    %cerco il minimo tra gli elementi della lista
    
    cercaMin(LdistanzeFlat,Min),
    Min #>= 0,
    NegMin #= -Min,

    
    fd:minimize(labeling([Min|Lstart]), NegMin).

    

scorriLista([],[]).
scorriLista([task(_,_,_,_,Start,End)|T], [Ldistanze | Tout]) :- 
    calcolaDistanze([Start,End],T, Ldistanze),
    scorriLista(T,Tout).

%calcola la distanza tra il task H e tutti gli altri nella lista L
calcolaDistanze(_,[],[]).
calcolaDistanze([Start1,End1],[task(_,_,_,_,Start2,End2)|T], [Dist1,Dist2|Tout]) :-
    Dist1 #= Start1 - End2,
    Dist2 #= Start2 - End1,
    calcolaDistanze([Start1,End1],T,Tout).

%Aggiungo start/end time e impongo i vincoli EST e LCT
vincolo_estlct([],[],[],[]).
vincolo_estlct([task(ID,EST,LCT,D)|T1], [task(ID,EST,LCT,D,Start,End)|T2], [Start|Ts], [D|Td]) :-   
    %aggiungo start e end time
    Start::0..10000000,
    End #= Start + D,
    %vincoli
    Start #>= EST,
    End #=< LCT,
    %ricorsione
    vincolo_estlct(T1,T2,Ts,Td).

cercaMin([],_).
cercaMin([H|T], Min) :- 
    H #>= 0 #=> Min #=< H,
    cercaMin(T,Min).
