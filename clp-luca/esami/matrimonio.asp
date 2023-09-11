
%DB fatti

num_invitati(20).
num_tavoli(4).
capacita(6).

conflitto(1, 3).
conflitto(1, 11).
conflitto(1, 18).
conflitto(2, 4).
conflitto(2, 12).
conflitto(4, 18).
conflitto(5, 17).
conflitto(6, 8).
conflitto(6, 10).
conflitto(6, 13).
conflitto(6, 14).
conflitto(7, 20).
conflitto(8, 16).
conflitto(11, 16).
conflitto(11, 17).
conflitto(15, 19).
conflitto(16, 20).
conflitto(17, 20).
conosce(1, 8).
conosce(1, 15).
conosce(1, 19).
conosce(2, 4).
conosce(2, 6).
conosce(2, 7).
conosce(2, 9).
conosce(2, 11).
conosce(2, 14).
conosce(2, 15).
conosce(3, 4).
conosce(3, 8).
conosce(3, 14).
conosce(3, 17).
conosce(3, 19).
conosce(4, 12).
conosce(4, 15).
conosce(5, 6).
conosce(5, 11).
conosce(5, 12).
conosce(5, 13).
conosce(5, 16).
conosce(5, 20).
conosce(6, 7).
conosce(6, 8).
conosce(6, 14).
conosce(6, 20).
conosce(7, 18).
conosce(7, 19).
conosce(8, 12).
conosce(8, 17).
conosce(8, 20).
conosce(9, 10).
conosce(9, 12).
conosce(9, 16).
conosce(9, 17).
conosce(10, 13).
conosce(10, 16).
conosce(11, 12).
conosce(11, 13).
conosce(12, 17).
conosce(12, 18).
conosce(12, 20).
conosce(13, 15).
conosce(15, 16).
conosce(15, 19).
conosce(16, 17).
conosce(17, 18).


invitato(1..N) :- num_invitati(N).
tavoli(1..N) :- num_tavoli(N).

%associamo un invitato ad ogni tavolo -> assegnato(Invitato, Tavolo).
1{assegnato(I,T) :tavoli(T) }1 :- invitato(I) .

%vincolo conflitto
:- conflitti(A,B), assegnato(A,T), assegnato(B,T).

%vincolo capacità
:- #count{I:assegnato(I,T), tavolo(T)} > C , capacita(C).

%creo un fatto per ogni conoscenza rispettata
buono(A,B) :- conosce(A,B), assegnato(A,T), assegnato(B,T).

%massimizzazione
#maximize{1,A,B:buono(A,B)}.