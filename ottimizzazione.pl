:- lib(fd).

p(1).
p(10).
p(100).



% utlizzando findall posso trovare tutti i risultati per cui la condizione è vera

csp(L, A) :-
    % trovami tutte le X tale che p(X) è vero
    findall(X, p(X), L),

    % trovami tutte le X tale che p(X) è vero e X > 1, Quello nelle parentesi è una condizione che deve essere vera per ogni elemento di A (in questo caso è una AND tra condizioni)
    findall(X, (p(X), X #> 1), A).


% si può aggiungere una nuoca clausola al programma utilizzando assert in fase di runtime 
% in questo caso aggiungo una nuova clausola per il predicato r(X) che è vero se p(Y) è vero tale per cui X è Y + 1
assert((r(X) :- p(Y), X is Y + 1)).

% se si vuole rimuovere una clausola si può utilizzare retract in fase di runtime
% in questo caso rimuovo la clausola aggiunta in precedenza
retract((r(X) :- p(Y), X is Y + 1)).


% si può creare una propria finall
mia_findall :- 
    assert(lista([])), % creo il predicato lista con una lista vuota
    p(X),

    % Serve la retract per rimuovere il predicato lista perchè altrimenti si aggiungerebbero predicati lista all'infinito. 
    % Mettendo la retract si manterebbe solamentee un predicato lista
    lista(L), retract(lista(L)), 
    
    assert(lista([X|L])), fail. % qua infatti creo un nuovo predicato lista con la lista aggiornata