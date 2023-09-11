% esercizio righello di golomb
:- lib(fd).
:-lib(fd_global).

%L = lista di tacche in outuput
%N = numero tacche
%Lmax = massimo grandezza di una tacca
csp(L,N, Lmax, DistanzeFlat) :- 

    %creo lista di tacche di N variabili
    length(L,N),
    L::[0..Lmax],

    %calcolo distanze tra tacche
    calcola_distanze(L, Distanze),
    flatten(Distanze, DistanzeFlat),

    %non ci possono essere tacche uguali
    fd_global:alldifferent(DistanzeFlat),
    fd_global:alldifferent(L),

    %ultimo elemento = Lmax
    %primo elemento = 0
    Ultimo #= Lmax,
    Primo #= 0,

    %estraggo ultimo e primo elemento della lista L
    trova_ultimo(L, Ultimo),
    trova_primo(L, Primo),

    labeling(L).


%calcolo la distanza di un elemento dagli altri della lista
distance(_, [], []).
distance(E, [H|T], [Hout|Tout]) :- 
    Hout #= H - E,
    Hout #>= 0,
    distance(E, T, Tout).

%calcolo la distanza di tutti gli elementi della lista
calcola_distanze([], []).
calcola_distanze([H|T], [Hout|Tout]) :- 
    distance(H, T, Hout),
    calcola_distanze(T, Tout).


%estrai ultimo elemento di una lista
trova_ultimo([H], H).
trova_ultimo([H|T], Ultimo) :- 
    trova_ultimo(T, Ultimo).

%estraggo il primo elemento di una lista
trova_primo([Primo|_], Primo).