:-lib(fd).

csp(C1,C2,C3,C4,C5,C6,V1,V2,V3,V4,V5) :-
    %C = colpevole / innocente
    %V = onesto / mentitore

    %BAMBINI
    % Aldo = 1
    % Dario = 2 
    % Elio = 3
    % Bruno = 4
    % Carlo = 5
    % Franco = 6
    [C1,C2,C3,C4,C5,C6] :: 0..1,
    [V1,V2,V3,V4,V5] :: 0..1,

    %ci sono esattamente 2 colpevoli
    C1 + C2 + C3 + C4 + C5 + C6 #= 2,

    %un bambino ha mentito
    V1 + V2 + V3 + V4 + V5  #= 1,

    %Aldo dice " Dario ed Elio"
    V1 #= 1 #\/ C2 + C3 #= 1,
    V1 #= 0 #\/ C2 + C3 #= 0,

    % Bruno dice "Carlo e Franco"
    V4 #= 1 #\/ C5 + C6 #= 1,
    V4 #= 0 #\/ C5 + C6 #= 0,

    %Carlo dice "Franco ed Elio"
    V5 #= 1 #\/ C6 + C3 #= 1,
    V5 #= 0 #\/ C6 + C3 #= 0,

    %Dario dice "Aldo ed Elio"
    V2 #= 1 #\/ C1  + C3 #= 1,
    V2 #= 0 #\/ C1  + C3 #= 0,

    %Elio dice "Carlo e Bruno"
    V3 #= 1 #\/ C5  +  C4 #= 1,
    V3 #= 0 #\/ C5  +  C4 #= 0,

    %labeling
    labeling([C1,C2,C3,C4,C5,C6]),
    labeling([V1,V2,V3,V4,V5]).