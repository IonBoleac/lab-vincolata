%esame genitori 25 luglio 2017
:-lib(fd).
:-lib(listut).
:- [impegni].

%Valori del dominio:
% 1 mamma
% 2 papà
% 3 asilo
% 4 babysitter

csp(L,InizioAsilo, FineAsilo, CostoTot, BAsilo) :-
    %domini e variabili
    length(L,30),
    L::1..4,
    %InizioAsilo::1..30,
    %FineAsilo::1..30,
    

    %RECUPERO INFORMAZIONI
    %Conto il numero di giorni
    conta_giorni(L,1,GiorniMamma),
    conta_giorni(L,2,GiorniPapa),
    %conta_giorni(L,3,GiorniAsilo),
    conta_giorni(L,4,GiorniBabisitter),

    %recupero lista di impegni
    findall(impegno(Genitore,Giorno), impegno(Genitore,Giorno), Limpegni),

    %VINCOLI
    %vincoli mamma e papa (numero giorni)
    GiorniMamma :: 0..6,
    GiorniPapa:: 0..4,
   

    %vincolo impegni
    imponi_impegni(Limpegni,L),
    %impegni_genitori(L,1),

    %vincolo asilo consecutivo
    FineAsilo - InizioAsilo #< 7,
   % FineAsilo #>= InizioAsilo,
    vincolo_asilo_consecutivo(L,1,InizioAsilo,FineAsilo,BAsilo),


    %CALCOLO DEL COSTO
    CostoTot #= (50 * GiorniBabisitter +  BAsilo * 100),

    %OTTIMIZZAZIONE
    %append(L,[InizioAsilo,FineAsilo], LLabel),
    min_max( (labeling(L),stampaLista(L)), CostoTot).
   
    

% conto il numero di giorni che il bambino sta con qualcuno
% conta(L,DaContare,Cont)
conta_giorni([],_,0).
conta_giorni([Giorno|T], DaContare, Cont) :- Giorno #= DaContare #<=> B, conta_giorni(T,DaContare,Cont1), Cont #= Cont1 + B.

%impongo il vincolo legato agli impegni
%imponi_impegni(Limpegni,L)
imponi_impegni([],_).
imponi_impegni([impegno(Genitore,Giorno)|T], L) :- nth1(Giorno, L, Var), Var #\= Genitore, imponi_impegni(T,L).

%vincolo_asilo_consecutivo(L, 1)
vincolo_asilo_consecutivo([],_,_, _, _).
vincolo_asilo_consecutivo([H|T],Idx, Inizio, Fine, GiornoAsilo) :- 
    H #= 3 #=> GiornoAsilo, % se il bambino va all'asilo in quel giorno
    H #= 3 #=> Inizio #=< Idx,
    H #= 3 #=> Fine #>= Idx,
    Idx1 #= Idx + 1,
    vincolo_asilo_consecutivo(T, Idx1, Inizio, Fine, GiornoAsilo).

stampaLista([]) :- write("\n").
stampaLista([H|T]) :- write(H), write(" "), stampaLista(T).