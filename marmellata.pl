:- lib(fd).


% csp(Aldo, Bruno, Carlo, Dario, Elio, Franco, L).
csp(A, B, C, D, E, F, Mentito) :-
    %% dichiaro le variabili e i propri domini
    % chi ha rubato la marmellata e chi no
    Rubato = [A, B, C, D, E, F],
    Rubato :: [0,1], % 0 = non colpevole, 1 = colpevole

    % chi ha mentito e chi ha detto la verità verità
    Mentito = [Aldo, Bruno, Carlo, Dario, Elio],
    Mentito :: [0,1], % 0 = ha detto la mezza verità, 1 = ha mentito

    %% vincoli (uno mente sempre e tutti gli altri mezza verità)
    % vincolo che due bambini esatti hanno rubato la marmellata
    A + B + C + D + E + F #= 2,
    % vincolo che un bambino esatto ha mentito (cinque dicono la mezza verità e uno mente sempre)
    Aldo + Bruno + Carlo + Dario + Elio #= 1,

    % Aldo dice " Dario ed Elio" (or esclusivo)
    (D #= 1 #\/ E #= 1) #/\ D#\=E #<=> Aldo #= 0,

    % Bruno dice "Carlo e Franco" (or esclusivo)
    (C #= 1 #\/ F #= 1) #/\ C#\=F #<=> Bruno #= 0,

    % Carlo dice "Franco ed Elio" (or esclusivo)
    (F #= 1 #\/ E #= 1) #/\ F#\=E #<=> Carlo #= 0,
 
    % Dario dice "Aldo ed Elio" (or esclusivo)
    (A #= 1 #\/ E #= 1) #/\ A#\=E #<=> Dario #= 0,

    % Elio dice "Carlo e Bruno" (or esclusivo)
    (C #= 1 #\/ B #= 1) #/\ C#\=B #<=> Elio #= 0,

    % Franco è assente: quindi non può essere colpevole e di conseguenza non può mentire
    % F #= 0, Franco #= 0, % F #= 0 (ho dedotto che Franco non è colpevole visto che non è presente)
    %
    % Uno dei cinque bambini nomina due inocenti. Gli altri nomina un innocente e un colpevole
    %
    % Suggerimento: per ogni bambino, dobbiamo scoprire due cose: 
    % 1. se ha mentito sempre o ha detto una verità, 
    % 2: se ha rubato la marmellata.



    labeling(Rubato),
    labeling(Mentito).