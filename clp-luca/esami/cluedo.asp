arma(1..6).
assasino(1..6).
giocatore(0..4).

%distribuzione carte
1{manoAss(Ass,Gioc):giocatore(Gioc)}1 :-  assasino(Ass).
1{manoArma(Arma,Gioc):giocatore(Gioc)}1 :-  arma(Arma).

%numero carte per giocatore
sommaGiocatore(Giocatore,S) :- 
    giocatore(Giocatore), 
    S1 = #count{Arma:manoArma(Arma,Giocatore)},
    S2 = #count{Ass:manoAss(Ass,Giocatore)},
    S = S1 + S2.

:- sommaGiocatore(Giocatore,S), S > 3.
:- sommaGiocatore(Giocatore,S), S  < 2.

:- #count{Ass:manoAss(Ass,0)} != 1.
:- #count{Arma:manoArma(Arma,0)} != 1.

%caso senza risposta
manoArma(Arma, 0); manoArma(Arma,Richiedente):-  risposta(Richiedente,Rispondente,Assassino,Arma), Rispondente = 0.
manoAss(Assassino, 0); manoAss(Assassino,Richiedente):-  risposta(Richiedente,Rispondente,Assassino,Arma), Rispondente = 0.

%caso con risposta
manoArma(Arma,Rispondente); manoAss(Assassino,Rispondente):- risposta(Richiedente,Rispondente,Assassino,Arma), Rispondente != 0.



%DB
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