%indovinello mago massimo
% - il mago da delle monete se gli vengono date indietro da il triplo delle monete che ha dato
% - quante monete si ottengono con 13 date al mago?
% - più monete date più il mago fornisce indietro (successione crescente) 

%uso ic per usare la Element 
:-lib(ic).


%Goal di esempio: csp(L,100,O).
% N numero fino al quale calcolare la successione
% O il numero di monete che il mago mi da se gliene fornisco N
csp(L,N,O) :-
    %lista e domini
    Lunghezza #= N * 3, %probabilmente va bene anche una lista più corta (però di di sicuro dovrebbe essere corretto) *
    length(L,Lunghezza),
    L::1..1000000000, %numero molto grande

    %fatti noti
    element(1,L,2), %il mago comincia con una moneta
    
    %vincolo di monotonia
    monotonia(L),

    %vincolo mago monete
    monete(L,L,1,N),

    %prendo solo il valore richiesto
    element(N,L,O),

    stampalista(L,1,N).

    %labeling (non serve perché andremmo a settare i valori nella parte della lista che non ci interessa)
   

%vincolo di monotonia stretta della sequenza
monotonia([_]).
monotonia([H1,H2|T]) :- H1 #< H2, monotonia([H2|T]).

%vincoli dati dal comportamento del mago (triplo)
monete(_, _, Stop, Stop).
monete([H|T], L, Idx, Stop) :- Triplo #= 3*Idx, element(H,L,Triplo), Idx1 #= Idx + 1, monete(T,L,Idx1,Stop).

stampalista(_,Fine,Fine).
stampalista([H|T],Idx,Fine) :- write(Idx), write(":"), write(H), write(" "), Idx1 #= Idx + 1 ,stampalista(T,Idx1,Fine).

% * la lista serve più grande dell'obiettivo perché ad ogni passo ottengo informazioni sui valori futuri
%   dato che f(X) = Y, f(f(X)) = 3*X, X < f(X) < f(f(X)) = 3*X allora f(X) < 3*X
%   per questo motivo è stata usata una lista di dimensioni 3*N 
%   in ogni caso non è detto che la scelta più efficiente