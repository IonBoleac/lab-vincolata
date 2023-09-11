:- lib(fd).

%  1     2      3       4     5     6
% Aldo, Bruno, Carlo, Daro, Elio, Franco
% Bugiardi totali possibili 5 visto che uno è assente, sicuramente bugiardo totale
% Ladri possibili 6, sicuramente 2 ladri


csp(Ladri, Bugiardi) :-
    Ladri = [A1, B1, C1, D1, E1, F1],
    Bugiardi = [A2, B2, C2, D2, E2],
    Ladri :: [0, 1], % 1 = ladro, 0 = non ladro
    Bugiardi :: [0, 1], % 1 = bugiardo totale, 0 = mezzo bugiardo


    %% VINCOLI
    % Aldo dice " Dario ed Elio"
    (D1 #= 1 #\/ E1 #=1) #/\ D1 #\= E1 #<=> A2 #= 0, % se è mezzo bugiardo
    %D1 #= 1 #/\ E1 #=1 #<=> A2 #= 1, % se è disonesto

    % Bruno dice "Carlo e Franco"
    (C1 #= 1 #\/ F1 #=1) #/\ C1 #\= F1 #<=> B2 #= 0,
    %C1 #= 1 #/\ F1 #=1 #<=> B2 #= 1,

    % Carlo dice "Franco ed Elio"
    (F1 #= 1 #\/ E1 #=1) #/\ F1 #\= E1 #<=> C2 #= 0,
    %F1 #= 1 #/\ E1 #=1 #<=> C2 #= 1,

    % Dario dice "Aldo ed Elio"
    (A1 #= 1 #\/ E1 #=1) #/\ A1 #\= E1 #<=> D2 #= 0,
    %A1 #= 1 #/\ E1 #=1 #<=> D2 #= 1,

    % Elio dice "Carlo e Bruno"
    (C1 #= 1 #\/ B1 #=1) #/\ C1 #\= B1 #<=> E2 #= 0,
    %C1 #= 1 #/\ B1 #=1 #<=> E2 #= 1,

    A2 + B2 + C2 + D2 + E2 #= 1, % c'è un solo bugiardo totale
    A1 + B1 + C1 + D1 + E1 + F1 #= 2, % ci sono due ladri


    labeling(Ladri),
    labeling(Bugiardi).
    
    

