%esercizio colf
%usiamo il vincolo cumulative([S1,...Sn], [D1,...Dn], [R1,...Rn], L)
:-lib(fd).
:-lib(cumulative).
:-lib(fd_global).

%TASK: lavare, asciugare, stirare, piatti, pizza, pulizia.
csp(L) :-
    %definisco la lista di startime
    L = [ Lavare, Asciugare, Stirare, Piatti, Impasto, Preriscladamento, Cottura, Pulizia],
    L::0..200,

    Durata = [45,60,60,40,15,5,15,120],
    Consumi_energia = [17,10,20,18,0,20,20,0], %consumi energetici degli elettrodomestici
    Colf=[0,0,1,0,1,0,0,1], %attività che può fare solo la colf (non fatti dalle macchine)

    %Soglie massimo di consumi
    Max_consumi #= 30, 
    Max_colf #= 1, %c'è una sola colf

    %durata massima giornaliera di lavoro della colf
    Max_durata #= 200, 

    %vincoli sulle attività (CUMULATIVE)
    cumulative(L, Durata, Consumi_energia, Max_consumi),
    cumulative(L, Durata, Colf, Max_colf),

    %lievitazione
    Impasto + 15 + 60 #=< Cottura,
    Impasto + 15 + 120 #>= Cottura,

    %vincoli sulle attività (DURATA massima dei lavori)
    somma_liste(L,Durata, Stoptime),
    maxlist(Stoptime, Fine),
    Fine #=< Max_durata,

    %lavara prima di asciugura e di stirare
    Lavare + 45 #=< Asciugare,
    Asciugare + 60 #=< Stirare,

    %precedenze nella pizza
    Preriscladamento +5 #=< Cottura,
    Impasto + 15 #=< Cottura,


    labeling(L).

%somma elemento per elemento si due liste in una lista di output
somma_liste([X1],[X2],[SOMMA]) :- SOMMA #= X1 + X2.
somma_liste([H1|T1],[H2|T2],[Hsomma|Tsomma]) :- Hsomma #= H1 + H2, somma_liste(T1,T2,Tsomma).

%trovo il massimo di una lista

    