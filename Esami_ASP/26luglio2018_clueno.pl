%risposta(Richiedente,Rispondente,Assassino,Arma).
risposta(1,3,2,4).
risposta(2,4,1,3).
risposta(3,0,5,6).
risposta(4,1,3,1).

risposta(1,2,2,3).
risposta(2,1,6,3).
risposta(3,2,1,3).
risposta(4,3,2,4).

risposta(1,4,4,1).
risposta(2,4,2,4).
risposta(3,2,6,5).
risposta(4,1,4,3).

risposta(1,3,2,6).
risposta(2,3,5,2).

numCarte(1..6).
numPossessore(0..4).

1{cartaPersonaggio(Num, NumPossessore):numPossessore(NumPossessore)}1 :- numCarte(Num).
1{cartaArma(Num, NumPossessore):numPossessore(NumPossessore)}1 :- numCarte(Num).

% controllare il numero di carte in mano dei giocatori
contaCarte(Cont, NumPossessore):- 
    numPossessore(NumPossessore),
    #count{Num:cartaPersonaggio(Num, NumPossessore)} = Num1,
    #count{Num:cartaArma(Num, NumPossessore)} = Num2,
    Cont = Num1 + Num2.

:- contaCarte(Cont, NumPossessore), Cont < 2.
:- contaCarte(Cont, NumPossessore), Cont > 3.

% numero di carte nella busta fisso a due
:- #count{Num:cartaPersonaggio(Num, 0)} != 1.
:- #count{Num:cartaArma(Num, 0)} != 1.

% caso risposta diverso da 0
cartaPersonaggio(Assassino, Rispondente); cartaArma(Arma, Rispondente) :- risposta(_, Rispondente, Assassino, Arma), Rispondente != 0.

% caso risposta uguale a 0
cartaPersonaggio(Assassino, Richiedente); cartaPersonaggio(Assassino, 0):- risposta(Richiedente,0,Assassino,Arma).
cartaArma(Arma, Richiedente); cartaArma(Arma, 0) :- risposta(Richiedente,0,Assassino,Arma).

#show cartaPersonaggio/2.
#show cartaArma/2.