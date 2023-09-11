% Torta di nonna lucia 21/02/2023
:- lib(fd).
% oppure lib(fd_global) per avere una all different diversa (vedere nelle slide cosa cambia)

clp(Nonna_tempo, Cane_tempo, Torta_tempo) :-
    % 1. Definizione delle variabili [carletto, pierino, tommaso]
    Nonna_tempo::[5,3,2],
    Cane_tempo::[4,2,3],
    Torta_tempo::[2,5,4],

    % 2. Definizione dei vincoli
  
    %vincolo nonna
    Inizio_nonna #= 0, Fine_nonna #= Inizio_nonna + Nonna_tempo,

    %vincolo cane
    Inizio_cane #>= Inizio_nonna + 1, Inizio_cane #=< Fine_nonna - 1, 
    Fine_cane #= Inizio_cane + Cane_tempo,

    %vincolo torta
    Inizio_torta #>= Inizio_nonna,  Inizio_torta #>= Inizio_cane,
    Fine_torta #=< Fine_nonna, Fine_torta #=< Fine_cane,
    Fine_torta #= Inizio_torta + Torta_tempo,

    %alldifferent sugli indici
    Nonna_lista#=[5,3,2],
    Cane_lista#=[4,2,3],
    Torta_lista#=[2,5,4],

    element(Inonna,Nonna_lista , Nonna_tempo),
    element(Icane,Cane_lista , Cane_tempo),
    element(Itorta,Torta_lista , Torta_tempo),

    alldifferent([Icane,Inonna,Itorta]),

    %labeling
    labeling([Nonna_tempo,Cane_tempo,Torta_tempo]).