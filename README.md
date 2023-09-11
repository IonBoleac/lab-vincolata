## Carico le librerie necessarie
:- lib(fd).
:- lib(fd_global).
:- lib(cumulative). # serve per fare i vincoli cumulativi
:- lib(edge_finder). o :- lib(edge_finder). # fa molto più prunning

# aggiorno il path
PATH=$PATH:/home/ion/eclipse/bin/x86_64_linux/

# sito delle librerie di eclipse
https://eclipseclp.org/doc/bips/lib_public/fd_global_gac/index.html

# concatena due liste A e B concatenate in AB -> (fa liste di liste)
append(A, B, AB).

# lungehzza di una lista -> 
length(L, N). 
# se N è una variabile, allora N è il numero di elementi di L.
# se L è una variabile, allora L è una lista di N elementi di cui N è dichiarato.

flatten(L, F).
# -> F è la lista ottenuta dalla lista L con tutti gli elementi annidati
# L = [[1,2],3,[4,5]] -> F = [1,2,3,4,5]

# fornisce la lista di tutti i valori che possono assumere una variabile
# X = 1..10 -> X = [1,2,3,4,5,6,7,8,9,10]
# X = 1..10::2 -> X = [1,3,5,7,9]
# X = 1..10::3 -> X = [1,4,7,10]

# foreach(X, L, G) -> per ogni elemento X della lista L, esegue il goal G
# foreach(X, L, G, R) -> per ogni elemento X della lista L, esegue il goal G e salva il risultato in R

# somma tutti gli elementi di una lista
sommalista([], 0) .
sommalista([H|T], S) :- 
    sommalista(T, S1), 
    S #= S1 + H.

# ordina in ordine crescente gli elementi di una lista (cambia solo l'ordine, non la lista) dipende dal segno #< (crescente) o #> (decrescente)
ordina([]) :- !.
ordina([_]) :- !.
ordina([A, B|T]) :- ordina([B|T]), A #< B.

# calcola la distanza tra tutti gli elementi di una lista e le inserisce in un'altra lista tali distanze
distanze([A,B], [C]) :- C #= B-A, !.
distanze([A, B|T], [C|Td]) :- C #= B-A, distanze([B|T], Td).


# trova il minimo di una lista
minimo([X], X) :- !.
minimo([X|T], X) :- minimo(T, Y), X #=< Y, !.
minimo([_|T], Y) :- minimo(T, Y).

# trova il massimo di una lista
massimo([X], X) :- !.
massimo([X|T], X) :- massimo(T, Y), X #>= Y, !.
massimo([_|T], Y) :- massimo(T, Y).

# trova elemento E in posizione I di una lista L oppure restituisce la posizione I di un elemento E in una lista L
element(I, L, E).

# restituisce una lista di tutte le distanze tra un elemento E e una lista L dentro una lista D (con tutti valori >0)
# dist(E, L, Dist).
dist(_, [], []) :- !.
dist(E, [H|T], [O|To]) :-
    O #= H-E,
    O #> 0,
    dist(E, T, To).

# estrai l'ultimo elemento di una lista L
ultimo_elemento([H], H) :- !.
ultimo_elemento([H|T], E) :-
    ultimo_elemento(T,E).

# estrai il primo elemento di una lista
primo_elemento([Primo|_], Primo).

## golomb(L, N, M) :- L è la lista di numeri di golomb di lunghezza N, dove M è il valore massimo che deve assumere l'ultimo elemento della lista L
dist(_, [], []) :- !.
dist(E, [H|T], [O|To]) :-
    O #= H-E,
    O #> 0,
    dist(E, T, To).

# funzione di golomb che restituisce tutte le distanze tra due tacche
golomb([A], []) :-!.
golomb([A|T], [Ldist|Ldist1]) :-
    golomb(T, Ldist1),
    dist(A, T, Ldist).

## fine golomb

# restiruisce la lista al contrario -> reverse(L, R)
reverse([], []).
reverse([H|T], R) :- reverse(T, R1), append(R1, [H], R).


## cazzate su liste
# 1. The first 5 elements of L are 1.
L = [1,1,1,1,1|_],

# 2. The last 5 elements of L are 0.
reverse(L, [0,0,0,0,0|_]),

# 3. The 6th element of L is 1.
L = [_|L1],
L1 = [_,_,_,_,_,1|_],

# 4. The 7th element of L is 0.
L = [_|L2],
L2 = [_,_,_,_,_,_,0|_],
## fine cazzate

# predicato per la stampa di una lista
stampa([]) :- !.
stampa([X|T]) :- write(X), stampa(T).

# predicato if then else (da utilizzare solamente con elemnti ground)
ifthenesle(Condizione, GoalThen, GoalElse) :-
   call(Condizione), !,
   call(GoalThen).
   
ifthenesle(Condizione, GoalThen, GoalElse) :-
   call(GoalElse).

# altrimenti si può utilizzare la forma contratta (da utilizzare solamente con elemnti ground)
( H1 #\= H2 -> B = 1 ; B = 0 ) -> B = 1 se H1 #\= H2, altrimenti B = 0


# predicato per la ricerca di un elemento in una lista
ennesimo(1, [X|_], X) :- !.
ennesimo(N, [_|T], X) :- N1 is N-1, ennesimo(N1, T, X).



# 3 *EXIT  member(_591{[0 .. 6]}, [_591, _609{[...]}, _627{...}, ...])   %>
# l'asterisco dice che ci sono altri punti di scelta. Quando farà backtracking potrebbe partire da questo punto

