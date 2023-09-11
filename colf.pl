:- lib(fd).
:- lib(cumulative).
% :- lib(edge_finder).

% % % % % % % % % % % % %% % % % % % % % % % % % % % % % % % % % % % % % % % %
% cumulative( +S, +D, +R, L).                                                %
% +S una lista che indica gli start time di ogni attività                    %
% +D una lista che indica la durata di ogni attività                         %
% +R una lista che indica la risorsa necessaria per ogni attività            %
% +L la lunghezza massima del consumo delle risorse (in questo caso 3 kW)    %
% % % % % % % % % % % %% % % % % % % % % % % % % % % % % % % % % % % % % % % %

% Lavare il bucato: ci vogliono 45 minuti, la lavatrice consuma 1,7kW.
% Asciugare il bucato: asciugatrice per 1 ora, 1kW
% Stirare il bucato: 1 ora, il ferro da stiro consuma 2kW. 
% Lavare i piatti: 40 minuti di lavastoviglie, la lavastoviglie consuma 1,8kW.
% Preparare una pizza: 
    % bisogna preparare l'impasto (15 minuti), 
    % lasciarlo lievitare da 1 a 2 ore, 
    % poi va cotta in forno per 15 minuti. 
    % Il forno consuma 2kW e va preriscaldato per 5 minuti (bisogna accenderlo 5 minuti prima di usarlo).
% Pulire la casa: 2 ore.
% Il consumo massimo di energia è di 3kW.
% Quale è l'ordine migliore per fare tutte queste cose?

% Lavatrice: Star_lavatrice, 45 minuti, 1,7kW
% Asciugatrice: Start_asciugatrice, 1 ora, 1kW
% Ferro da stiro: Start_ferro, 1 ora, 2kW
% Lavastoviglie: Start_lavastoviglie, 40 minuti, 1,8kW
% Impasto: Start_impasto, 15 minuti, 0kW
% Lievitazione: Start_lievitazione, 1-2 ore, 0kW
% Accensione forno: Start_accensione_forno, 5 minuti, 2kW
% Forno: Start_forno, 15 minuti, 2kW (va acceso cinque minuti prima di infornare)
% Pulizia: Start_pulizia, 2 ore, 0kW

csp(Start_times) :-
    % dichiaro le variabili per gli start delle attività
    Start_lavatrice :: 0..155,
    Start_asciugatrice :: 0..200,
    Start_ferro :: 0..140,
    Start_lavastoviglie :: 0..160,
    Start_impasto :: 0..200,
    Start_lievitazione :: 0..200,
    Start_accensione_forno :: 0..200,
    Start_cottura :: 0..185,
    Start_pulizia :: 0..80,
    Tempo_max #= 200,

    % dichiaro le liste per il predicato cumulative(Start_times, Duration, Resource, 30).
    Start_times = [Start_lavatrice, Start_asciugatrice, Start_ferro, Start_lavastoviglie, Start_impasto, Start_lievitazione, Start_accensione_forno, Start_cottura, Start_pulizia],
    Lievitation :: 60..120,
    Duration = [45, 60, 60, 40, 15, Lievitation, 5, 15, 120],
    Resource = [17, 10, 20, 18, 0, 0, 22, 22, 0],

    %% vincoli per l'inizio delle attività
    % vincolo per la cottura del pizza
    Start_impasto #<= Start_lievitazione - 15,
    Start_lievitazione #<= Start_cottura - Lievitation,
    Start_accensione_forno #<= Start_cottura - 5,
    Start_cottura #<= Tempo_max - 15,

    % vincolo per la lavatrice
    Start_lavatrice #<= Start_asciugatrice - 45,

    % vincolo asciugatrice
    Start_asciugatrice #< Start_ferro - 60,

    % eseguo il predicato cumulative() per le attività che consumano energia
    cumulative(Start_times, Duration, Resource, 30),

    % cumulative per le attività che impegnano la colf
    cumulative([Start_ferro, Start_impasto, Start_pulizia], [60, 15, 120], [1, 1, 1], 1),

    % labeling
    labeling(Start_times),
    labeling([Lievitation]).



    


