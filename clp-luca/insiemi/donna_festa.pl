%ultima slide pacco 11_insiemi
:- lib(fd_sets).
:- lib(fd).


csp(L,N) :-

    %calcolo numero giorni
    Giorni #= N - 1,
    Giorni2 #= Giorni * N,
    Giorni3 * 6  #= Giorni2,

    %definisco le variabili set
    intsets(L,Giorni3,1,N),
    
    %cardinalità 3
    imponi_card(L),

    %gli amici non posso trovarsi più di una volta.
    imponi_vincolo_amici(L),

    %labeling
    labeling_insiemi(L).


%dobbiamo provare tutte le coppie di giorni ed imporre che l'intersezione sia sempre una

% imponi_vincolo_amici(L) 
imponi_vincolo_amici([]).
imponi_vincolo_amici([H|T]) :- 
    vincolo_amici(H,T), 
    imponi_vincolo_amici(T).

vincolo_amici(_,[]).
vincolo_amici(X,[H|T]) :- 
    fd_sets:intersection(X,H,Int), #(Int,Card), fd:(Card::0..1), 
    vincolo_amici(X,T).

imponi_card([]).
imponi_card([H|T]) :- 
    #(H,3), 
    imponi_card(T).

labeling_insiemi([]).
labeling_insiemi([H|T]) :- 
    insetdomain(H,_,_,_), 
    labeling_insiemi(T). %al posto del labeling per insiemi
    