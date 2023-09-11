%esercizio su classroom
:-lib(fd).
:-lib(edge_finder).
:-lib(fd_global).

%macchine   num durata
%cerchi     1   20
%aria       2   80
%nav        3   50  


%fatti
%rich(Num,Consegna,CerchiLega,AriaCondizionata,Satellitare).
rich(1,420,1,0,1). 
rich(2,150,0,0,1).
rich(3,440,1,1,1).
rich(4,270,1,0,1).
rich(5,660,1,0,0).
rich(6,330,0,1,0).
rich(7,500,0,0,1).
rich(8,730,0,1,0).

%durate


schedule(L) :-
    findall(rich(Num,Consegna,CerchiLega,AriaCondizionata,Satellitare),rich(Num,Consegna,CerchiLega,AriaCondizionata,Satellitare),Lin),

    %variabili decisionali (e)
    crea_start_cerchi(Lin,Lcerchi),
    crea_start_aria(Lin,Laria),
    crea_start_nav(Lin,Lnav),
    append(Lcerchi,Laria,LcerchiAria),
    append(LcerchiAria,Lnav,L),

    %disjunctive
    imponi_disjunctive_auto(L),
    imponi_disjunctive_macchine(L),

    %end time globale
    seleziona_end_start(L,Lend,Lstart),
    maxlist(Lend,Globalend),

    %search e ottimizzazione
    min_max(labelTasks(Lstart),Globalend).
    %con minimize troppo oneroso!



%Creo le variabili decisionali(gli start time di ogni attività)
%traduco le richieste in  job(Auto,Macchina,Start, Durata, ConsegnaMax, End)
%introduco anche i vincoli sui tempi di consegna

%Num rappresenta l'automobile
crea_start_cerchi([],[]).
crea_start_cerchi([rich(Num,Consegna,1,_,_)|Trich], [job(Num,1,Start,20,Consegna,End)|Tjob]) :- Start::0..1000000, End #= Start + 20, End #<= Consegna, crea_start_cerchi(Trich,Tjob).
crea_start_cerchi([rich(_,_,0,_,_)|Trich], Tjob) :- crea_start_cerchi(Trich,Tjob).

crea_start_aria([],[]).
crea_start_aria([rich(Num,Consegna,_,1,_)|Trich], [job(Num,2,Start,80,Consegna,End)|Tjob]) :- Start::0..1000000, End #= Start + 80, End #<= Consegna, crea_start_aria(Trich,Tjob).
crea_start_aria([rich(_,_,_,0,_)|Trich], Tjob) :- crea_start_aria(Trich,Tjob).

crea_start_nav([],[]).
crea_start_nav([rich(Num,Consegna,_,_,1)|Trich], [job(Num,3,Start,50,Consegna,End)|Tjob]) :- Start::0..1000000, End #= Start + 50,End #<= Consegna, crea_start_nav(Trich,Tjob).
crea_start_nav([rich(_,_,_,_,0)|Trich], Tjob) :- crea_start_nav(Trich,Tjob).

%DISJUNCTIVE auto (no la stessa auto in macchine diverse)
imponi_disjunctive_auto(L) :- findall(Auto, rich(Auto, _, _, _, _), Lauto), imponi_disjunctive_loop_auto(Lauto,L).

imponi_disjunctive_loop_auto([],_).
imponi_disjunctive_loop_auto([A|Ta],L) :- selezione_job_auto(A,L,Lstart,Ldur), disjunctive(Lstart,Ldur), imponi_disjunctive_loop_auto(Ta,L).

%selezione_job_auto(M,L,Lstart,Ldur) (selezioni in job che operano sulla stessa automobile)
selezione_job_auto(_,[],[],[]).
selezione_job_auto(A,[job(A,_, Start,Durata, _, _)|T],[Start|Tstart],[Durata|Tdurata]) :- selezione_job_auto(A,T,Tstart,Tdurata).
selezione_job_auto(A,[job(Auto,_, _,_, _, _)|T],Lstart,Ldurata) :- A #\= Auto,  selezione_job_auto(A,T,Lstart,Ldurata).

%DISJUCTIVE macchine (no più di un job nella stessa macchina)
imponi_disjunctive_macchine(L) :- imponi_disjunctive_loop_macchine([1,2,3],L).


imponi_disjunctive_loop_macchine([],_).
imponi_disjunctive_loop_macchine([M|Tm],L) :- selezione_job_macchine(M,L,Lstart,Ldur), disjunctive(Lstart,Ldur), imponi_disjunctive_loop_macchine(Tm,L).

selezione_job_macchine(_,[],[],[]).
selezione_job_macchine(M,[job(_, M, Start,Durata, _, _)|T],[Start|Tstart],[Durata|Tdurata]) :- selezione_job_macchine(M,T,Tstart,Tdurata).
selezione_job_macchine(M,[job(_,Macchina, _,_, _, _)|T],Lstart,Ldurata) :- M #\= Macchina,  selezione_job_macchine(M,T,Lstart,Ldurata).

%seleziona_end_start(L,Lend,Lstart),
%L composta da job(Auto,Macchina,Start, Durata, ConsegnaMax, End)
seleziona_end_start([],[],[]).
seleziona_end_start([job(_,_,Start, _, _, End)|T],[End|Tend],[Start|Tstart]) :- seleziona_end_start(T,Tend,Tstart).

%il normale labelling non va bene (troppi punti di scelta)
%faccio un earliest scheduling, vedi slide 53 pacco 8 scheduling
labelTasks([]).
labelTasks(TaskList):-
 deletemin(First,TaskList,Others),
 mindomain(First,MinStart),
 label_earliest(TaskList,First,MinStart,Others).
 
label_earliest(TaskList,First,Min,Others):- % schedule the task
 First #= Min,
 labelTasks(Others).

label_earliest(TaskList,First,Min,Others):- % delay the task
 First #\= Min,
 labelTasks(TaskList).
