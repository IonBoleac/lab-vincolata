:- lib(fd).
:- lib(listut).

:-[pack_inst].

csp(InstalledList, NewInstallList ,C) :-
    %recupero input
    install(ToInstall),
    installed(InstalledList),
    package(PackageList),
    length(PackageList, NumeroPacchetti),
    findall(requires(X,Y), requires(X,Y), RequiresList),
    findall(conflict(X,Y), conflict(X,Y), ConflictList),

    %definizione domini e variabili
    length(NewInstallList, NumeroPacchetti),
    NewInstallList :: 0..1, %o sono installati oppure no

    %vincoli
    nth1(ToInstall, NewInstallList, 1),
    imponi_conflict(ConflictList, NewInstallList),
    imponi_requires(RequiresList, NewInstallList),

    %calcolo del costo
    costo(InstalledList, NewInstallList, C),

    %ottimizzazione
    %labeling(NewInstallList).
    minimize(labeling(NewInstallList),C).



%costo (la differenza tra i pacchetti prima installati e ora)
costo([],[],0).
costo([H1|T1],[H2|T2],C):-  H1 #\= H2 #<=> B, write(B), costo(T1,T2,C1), C #= B + C1.

%vincolo di conflitto
imponi_conflict([],_).
imponi_conflict([conflict(X,Y)|T], NewInstallList) :- 
    nth1(X,NewInstallList,Pkt1), Pkt1 #= 1 #<=> B1,  
    nth1(Y,NewInstallList,Pkt2), Pkt2 #= 2 #<=> B2, 
    B1 + B2 #=< 1, 
    imponi_conflict(T, NewInstallList).

imponi_requires([],_).
imponi_requires([requires(X,Y)|T], NewInstallList) :- nth1(X,NewInstallList,Pkt1), Pkt1 #= 1 #<=> B1,  nth1(Y,NewInstallList,Pkt2), Pkt2 #= 1 #<=> B2, B1 #=< B2, imponi_requires(T, NewInstallList).