% PATH=$PATH:/home/ion/eclipse_dir/bin/x86_64_linux/

% Esercizio Gedeone, Umberto, Dario

:- lib(fd).

csp(Dario, Umberto, Gedeone) :-
    % Definisco le variabili
    Vars = [Dario, Umberto, Gedeone, Gedeone_passato, Dario_passato],

    % Definisco i domini
    Dario :: 1..100, Umberto :: 1..100, Gedeone :: 1..100, 
    Gedeone_passato :: 1..100, Dario_passato :: 1..100,

    % Definisco i vincoli della prima frase
    Dario + 11 #= Gedeone_passato, Gedeone_passato #= Dario_passato * 6,

    % Definisco i vincoli della seconda frase
    Umberto #= Dario + 3, Umberto #= (Gedeone - Dario) - 3, 

    % Definisco i vincoli miei
    Gedeone_passato - Dario_passato #=  Gedeone - Dario,

    labeling([Dario, Umberto, Gedeone]). 
    
