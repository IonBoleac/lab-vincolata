%testo https://www.unife.it/ing/lm.infoauto/constraint-programming/materiale-didattico-2/lucidi/esercizio-tsp-tw

%Versione "facile" senza circuit e ic. 
%Una variabile della lista è una città. La visita è ordinata
:-lib(fd).
:-lib(propia).

%caricamento file
:-[infermiera_db].
%paziente(ID,OrarioMinimo,OrarioMassimo),paziente(Id,Min,Max)
%distanza(Id1, Id2, Costo).

csp(L,C):-
    %raccolta dati di input
    findall(paziente(Id,Min,Max), paziente(Id,Min,Max),Lin),
    length(Lin,Npazienti),

    %domini e variabili
    Npazienti1 #= Npazienti + 1, %c'è anche l'ospedale
    length(L,Npazienti1),
    L::0..Npazienti,
    ospedale(L),

    %vincoli di vicinanza e alldifferent
    alldifferent(L),
    vincoli_vicinanza_costo(L,0,C),

    %labeling e ottimizzazione
    min_max(labeling(L),C).


%ospedale(L) (setto a 0 l'elemento a indice 0)
ospedale([H|_]) :- H #= 0.

%vincoli_vicinanza_costo(L,0,CostoTot)
vincoli_vicinanza_costo([Ultimo],CostoAttuale,CostoTot) :-  
    distanza(Ultimo,0,Costo) infers most, 
    CostoTot #= CostoAttuale + Costo.
    
vincoli_vicinanza_costo([A,B|H],CostoAttuale,CostoTot) :-
    distanza(A,B,Costo) infers most, 
    CostoAttualeAgg #= CostoAttuale + Costo,
    paziente(B,Min,Max) infers most, CostoAttualeAgg #>= Min, 
    CostoAttualeAgg #=< Max,
    vincoli_vicinanza_costo([B|H],CostoAttualeAgg,CostoTot).