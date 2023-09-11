giocatore(1..2).

manoArma(2,1).
manoArma(3,1).
manoAss(5,1).

%numero carte per giocatore
sommaGiocatore(Giocatore,S) :- 
    giocatore(Giocatore), 
    S1 = #count{Arma:manoArma(Arma,Giocatore)},
    S2 = #count{Ass:manoAss(Arma,Giocatore)},
    S = S1 + S2.