%esercizio sulle 20 frasi legate fra loro
:- lib(fd).

clp(B1,B2,B3,B4,B5,B6,B7,B8,B9,B10,B11,B12,B13,B14,B15,B16,B17,B18,B19,B20) :- 
    %Definisco la lista di 20 variabili binarie
    % length(L,20),
    [B1,B2,B3,B4,B5,B6,B7,B8,B9,B10,B11,B12,B13,B14,B15,B16,B17,B18,B19,B20] :: 0..1,
    

    %Definisco il dominio delle variabili
    

    %Relazioni tra le frasi 
    %Prima colonna
    B6 #= B7 #<=> B1,
    B1 #= 0 #<=> B2,
    B4 #\= B20 #<=> B3,
    B3 #\= B20 #<=> B4,
    B19 #\= B5 #<=> B5,
    B2 #= 1 #<=> B6,
    B15 #= 1 #<=> B7,
    B11 #= B19 #<=> B8,
    B10 #= 1 #<=> B9,
    B13 #= 0 #<=> B10,
    %Seconda colonna
    %B11 non è legata a nessuna frase
    B16 #= 1 #<=> B12,
    B12 #= 1 #<=> B13,
    B14 #= B11 #<=> B14,
    %B15 IMPONE CHE ALMENO 10 FRASI SIANO VERE
    (B1 + B2 + B3 + B4 + B5 + B6 + B7 + B8 + B9 + B10 + B11 + B12 + B13 + B14 + B15 + B16 + B17 + B18 + B19 + B20) #>= 10 #<=> B16,
    %B16 IMPONE CHE ALMENO 10 FRASI SIANO FALSI
    (B1 + B2 + B3 + B4 + B5 + B6 + B7 + B8 + B9 + B10 + B11 + B12 + B13 + B14 + B15 + B16 + B17 + B18 + B19 + B20) #=< 10 #<=>  B15 ,
    B9 #= B4 #<=> B17,
    B7 #= 1 #<=> B18,
    %B19 non legata ad altre
    B3 #\= B4 #<=> B20,

    %labeling
    labeling([B1,B2,B3,B4,B5,B6,B7,B8,B9,B10,B11,B12,B13,B14,B15,B16,B17,B18,B19,B20]).