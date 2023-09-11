p(1).
p(10).
p(20).

mia_findall :- 
    %creo una lista vuota
    assert(lista([])),
    %recupero una soluzione X
    p(X), 
    %recupero la lista creata prima
    lista(L), retract(lista(L)),
    %aggiungo X alla lista
    assert(lista([X|L])),false.
   
%slide 9 pacco 7 una funzione fatta bene. qui solo l'idea generale

