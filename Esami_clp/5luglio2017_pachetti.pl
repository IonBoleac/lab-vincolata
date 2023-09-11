:- [pack_inst].
:- lib(fd).
:- lib(listut).
:- lib(propia).

csp(LInstalled, NewInstallList) :-
    package(LPackege),
    installed(LInstalled),
    install(LInstall),
    findall(requires(A, B), requires(A, B), LRequires),
    findall(conflict(A, B), conflict(A, B), LConflicts),

    length(LPackege, NumPackage),
    length(NewInstallList, NumPackage),
    NewInstallList :: 0..1,

    % installa i pachetti desiderati
    install_package(NewInstallList, LInstall),

    % vincolo di require e conflict
    incoloConflicts(NewInstallList, LConflicts),
    vincoloRequires(NewInstallList, LRequires),

    % distanza di hamming
    distanzaHamming(LInstalled, NewInstallList, Distanza),

    
    min_max(labeling(NewInstallList), Distanza).

distanzaHamming([], [], 0).
distanzaHamming([Hnew|TnewList], [Hold|ToldList], Distanza) :-
    Hnew #\= Hold #<=> B,
    Distanza #= B + Distanza1,
    distanzaHamming(TnewList, ToldList, Distanza1).

vincoloRequires(_, []).
vincoloRequires(NewInstallList, [requires(A, B)|T]) :-
    nth1(A, NewInstallList, A1),
    nth1(B, NewInstallList, B1),
    A1 #= 1 #=> B1 #= 1,
    vincoloRequires(NewInstallList, T).

incoloConflicts(_, []).
incoloConflicts(NewInstallList, [conflict(A,B)|T]) :-
    nth1(A, NewInstallList, A1),
    nth1(B, NewInstallList, B1),
    A1 + B1 #=< 1,
    incoloConflicts(NewInstallList, T).


install_package(_, []).
install_package(NewInstallList, [Pachetto|T]) :-
    nth1(Pachetto, NewInstallList, 1),
    install_package(NewInstallList, T).
install_package(NewInstallList, Pachetto) :-
    nth1(Pachetto, NewInstallList, 1).

