:- [pazienti2].
:- lib(ic).
:- lib(ic_global).
:- lib(listut).
:- lib(ic_edge_finder).
:- lib(propia).
:- lib(branch_and_bound).


pazienti(L):-
    findall(paziente(ID,Min,Max), paziente(ID,Min,Max), Lin1),
    /*findall(distanza(Paz1, Paz2, Tempo), distanza(Paz1, Paz2, Tempo), Lin2), */
    length(Lin1, Npazienti),
    length(L, Npazienti),
    L :: 1..Npazienti,
    ordina(Lin1, Tempo, Durata),
    disjunctive(Tempo, Durata),
    circuit(L),
    ic_global:alldifferent(L), 
    calcolo_somma(L, S),
    minimize((labeling(L), labeling(Tempo)), S).

ordina([], [], []).
ordina([paziente(ID, Min, Max)|Lin], [T|Tempo], [0|Durata]):-
    T #>= Min, 
    T #=< Max,
    ordina(Lin, Tempo, Durata).

calcolo_somma([Id2|L], T):-
    infers(distanza(0, Id2, Tempo), most),
    somma([Id2|L], T1),
    T #= Tempo + T1.

somma([Id1], Tempo):-
    infers(distanza(Id1, 0, Tempo), most).
somma([Id1, Id2|L], S):- 
    infers(distanza(Id1, Id2, Tempo), most),
    somma([Id2|L], S1),
    S #= S1 + Tempo.