:- lib(fd).

leq(A,B) :- 
    %recupero i domini di A e B
    dvar_domain(A,DomA), dvar_domain(B,DomB),

    %mi interessa sapere il minimo di A il massimo di B
    dom_range(DomA,MinA,_), dom_range(DomB,_,MaxB),

    %PROPAGAZIONE
    %da B eliminare tutti i valori minori di MinA
    dvar_remove_smaller(B,MinA),

    %da A eliminare tutti i valori maggiori di MaxB
    dvar_remove_greater(A,MaxB),

    

    %SOSPENSIONE
    %suspend(+Goal, +Prio, +CondList)
    % Goal = vincolo da sospendere
    % 1 = priorità massima. Si dedice in base alla velocità di esecuzione del vincolo
    % CondList = lista di condizioni che devono essere soddisfatte per risvegliare il vincolo
    %  A->min = se il minimo di A cambia, risveglia il vincolo
    
    %suspend(leq(A,B),5,[A->min,B->max]).
    %spostata nel predicato sospendi
    sospendi(A,B).

    %

%sospendo solo se A e B NON sono delle variabili. 
%in quel caso il vincolo è completamente risolto
sospendi(A,B) :- nonvar(A), !.
sospendi(A,B) :- nonvar(B), !.
sospendi(A,B) :- suspend(leq(A,B),5,[A->min,B->max]).