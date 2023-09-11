:- lib(fd).
:- lib(listut).
:- lib(propia).
:- [pazienti].

csp(Percorso, Distanza, DimPercorso) :-
    findall(paziente(ID,Min,Max), paziente(ID,Min,Max), ListaPazienti),
    length(ListaPazienti, NumPazienti),
    DimPercorso #= NumPazienti + 1, % comprendo anche l'ospedale
    length(Percorso, DimPercorso),
    alldifferent(Percorso),

    nth1(1, Percorso, 0),
    definisciIlPercorso(Percorso, DistanzaTot),
    
    labeling(Percorso).


definisciIlPercorso([A], Dist) :-
    distanza(A, 0, Dist) infers ac.
definisciIlPercorso([A, B|T], Dist) :-
    distanza(A, B, AB) infers ac,
    Dist #= AB + Dist1,
    paziente(B, TMin, TMax),
    definisciIlPercorso([B|T], Dist1).


vincoloMinMaxPerPaziente([], _).
vincoloMinMaxPerPaziente([paziente(ID,Min,Max)|TP], L) :-
    nth1(ID, L, Valore),
    Min #=< Valore, Valore #=< Max,
    vincoloMinMaxPerPaziente(TP, L).