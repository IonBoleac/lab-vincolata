:- lib(fd).
:- lib(fd_global_gac).

% la nonna Luisa e il cane devono essere distratti nello stesso momento affinchè la torta possa essere sotratta
%             nonna     cane    torta
% Carletto      5         4       2
% Pierino       3         2       5
% Tommaso       2         3       4

csp(Nonna_tempo, Cane_tempo, Torta_tempo) :-
    % 1. Definizione delle variabili [carletto, pierino, tommaso]
    Vars = [Nonna_tempo, Cane_tempo, Torta_tempo],
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

    fd_global_gac:alldifferent([Icane,Inonna,Itorta]),

    %labeling
    labeling(Vars).