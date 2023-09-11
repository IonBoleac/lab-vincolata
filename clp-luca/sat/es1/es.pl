:- lib(fd).
:- lib(listut).

:- [read_cnf].


csp(L) :-
    %carico i fatti
    read_cnf("istanza1"),
    cnf(NVariabili,NClausole),

    %definisco le variabili e domini
    length(L,NVariabili),
    domini(L,1),

    %recupero tutte le clausole
    findall(clausola(Cl),clausola(Cl),LClausole),

    %impongo i vincoli
    scorri_clausole(LClausole,L),

    labeling(L).


% ogni variabili ha due valori nel suo dominio +-idx
%domini(L,1)
domini([],_).
domini([H|T],Idx) :- NegIdx #= - Idx, H::[Idx,NegIdx], Idx1 #= Idx + 1, domini(T,Idx1).

%per ogni clausola imponiamo che il suo valore sia vero
%scorri_clausole(Lclausole,L)
scorri_clausole([],_).
scorri_clausole( [clausola([X1,X2,X3])|T] , L) :-
    %calcolo i valori assoluti delle variabili
    (X1 #> 0 -> X1abs #= X1 ; X1abs #= - X1), (X2 #>0 -> X2abs #= X2 ; X2abs #= - X2), (X3 #>0 -> X3abs #= X3 ; X3abs #= - X3),
    %trovo i valori corrispondenti
    nth1(X1abs,L,X1mia), nth1(X2abs,L,X2mia), nth1(X3abs,L,X3mia),
    %impongo che almeno uno sia uguale
    X1 #= X1mia #\/ X2 #= X2mia #\/ X3 #= X3mia,
    %ricorsione
    scorri_clausole(T,L).
