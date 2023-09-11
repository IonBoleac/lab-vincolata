:- lib(fd).
:- lib(cumulative).


% cumulative([start_time], [duration], [resources used], limit of resources)

csp(Start_times) :-
    Lavatrice :: 0..155,
    Asciugatrice :: 0..200,
    Stiro :: 0..140,
    Lavastoviglie :: 0..160,
    Preparazione :: 0..200,
    Lievitazione :: 0..200,
    Preforno :: 0..200,
    Forno :: 0..185,
    Pulizie :: 0..80,
    Start_times = [Lavatrice, Asciugatrice, Stiro, Lavastoviglie, Preparazione, Lievitazione, Preforno, Forno, Pulizie],
    % Lievitazione_time :: 60..120,
    Duration = [45, 60, 60, 40, 15, Lievitazione_time, 5, 15, 120],
    Resources = [17, 10, 20, 18, 0, 0, 20, 20, 0],
    Limit #= 30, % 3 kW di potenza massima

    L = [Lavatrice, Asciugatrice, Stiro, Lavastoviglie, Preparazione, Lievitazione, Preforno, Forno, Pulizie, Lievitazione_time],

    % vincoli
    % lavatrice prima della asciugatrice e a sua volta prima dello stiro
    Lavatrice #<= Asciugatrice - 45,
    Asciugatrice #<= Stiro - 60,
    
    % pizza
    Lievitazione #<= 120,
    Lievitazione #>= 60,
    Preparazione #<= Lievitazione - 15, 
    Lievitazione #<= Forno - Lievitazione_time,
    Preforno #<= Forno - 5,
    Forno #<= 200 - 15,




    cumulative(Start_times, Duration, Resources, Limit),
    cumulative([Preparazione, Stiro, Pulizie], [15, 60, 120], [1, 1, 1], 1),

    % labeling(Start_times),
    % labeling([Lievitazione_time]).

    labeling(L).



    