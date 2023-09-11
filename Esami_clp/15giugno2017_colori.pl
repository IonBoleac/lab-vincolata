:- lib(fd).
:- lib(fd_global).
:- lib(listut).

% sequenza dei colori 
% rosso = 1
% giallo = 2
% verde = 3

% Sequenza => lista dell'ordine da effettura dove l'indice è il numero della macchina e il valore corrisponde al colore in sequenza da consegnare in out
% LNew => indice corrisponde all'ordine in cui le macchine vengono colorate
%         valore corrisponde al numero della macchina quindi all'indice della lista Sequenza
% MaxD è il numero massimo di spostamenti possibili nella sequenza


csp(LNew, Costo) :-
    Lin = [1, 2, 1, 3, 2],
    MaxD #= 1,

    length(Lin, Dim),
    length(LNew, Dim),
    LNew :: 1..Dim,
    fd_global:alldifferent(LNew),

    %vincolo_posizione(LNew, 1, MaxD),
    impostaVincoloMaxD(LNew, 1, MaxD),

    calcolaCostoCambio(LNew, Lin, Costo),

    %labeling(LNew).
    min_max(labeling(LNew), Costo).


impostaVincoloMaxD([], _, _).
impostaVincoloMaxD([Hnew|Tnew], Idx, MaxD) :-
    % indici della lista Lin corrisponde all'id delle macchine
    % il valore della lista Lin può stare nella nuova lista in un range di indici Idx - MaxD =< Idx =< Idx + MaxD
    % la nuova lista corrisponde all'ordine in cui vengono colorate le macchine il cui valore corrisonde all'indice 
    % della lista Lin (li prendo come se fossero gli id degli ordini)
    Hnew #=< Idx + MaxD,
    Hnew #>= Idx - MaxD,
    Idx1 #= 1 + Idx,
    write("indice: "), write(Idx), write("\n"),
    impostaVincoloMaxD(Tnew, Idx1, MaxD).

calcolaCostoCambio([_], _, 0).
calcolaCostoCambio([A, B|T], Lin, Costo) :-
    element(A, Lin, Val1), element(B, Lin, Val2),
    Val1 #\= Val2 #<=> Z,
    Costo #= Costo1 + Z,
    calcolaCostoCambio([B|T], Lin, Costo1).