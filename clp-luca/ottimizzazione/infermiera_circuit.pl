%testo https://www.unife.it/ing/lm.infoauto/constraint-programming/materiale-didattico-2/lucidi/esercizio-tsp-tw
:-lib(ic).
:-lib(propia).
:-lib(branch_and_bound). % in ic non c'è la minimize


:-[infermiera_db_circuit].
% per usa minimize con ic devo usare branch_and_bound

%paziente(ID,OrarioMinimo,OrarioMassimo)
%paziente(Id,Min,Max)
%distanza(Id1, Id2, Costo).


csp(L):-
    findall(paziente(Id,Min,Max), paziente(Id,Min,Max),Lin),

    %definizione variabili
    length(Lin,Npazienti),
    %Npazienti1 #= Npazienti + 1, %c'è anche l'ospedale
    length(L,Npazienti),   
    L::1..Npazienti,

    %alldifferent e circuit
    alldifferent(L),
    circuit(L),
    
    %vincoli di orario
    %elimina_primo_elemento(L,Lnoospedale),
    vincoli_orario(L,1,1,0,Npazienti,C),

    %calcolo del costo (devo anche mettere il tragitto dall'ospedale)
    %calcola_costo(L,0,C),

    %minimizzazione e labeling
    bb_min(labeling(L),C,_).

%vincoli_orario(L,NPazVisitate,Succ,CostoParziale,NPazienti)
%vincoli_orario(L,1,Prec,CostoParziale,NPazienti)
vincoli_orario(L,NPazienti,Prec,CostoParziale,NPazienti,C) :- element(Prec,L,Succ), distanza(Prec,Succ,Costo) infers most, C #= Costo + CostoParziale.

vincoli_orario(L,NPazVisitate,Prec,CostoParziale,NPazienti,C) :- 
    element(Prec,L,Succ), distanza(Prec,Succ,Costo) infers most, 
    paziente(Succ,Min,Max) infers most, CostoParzialeNuovo #= CostoParziale + Costo, 
    CostoParzialeNuovo #>= Min, CostoParzialeNuovo #=< Max,
    NPazVisitateNuovo #= NPazVisitate + 1, PrecNuovo = Succ, 
    vincoli_orario(L,NPazVisitateNuovo,PrecNuovo,CostoParzialeNuovo,NPazienti,C).