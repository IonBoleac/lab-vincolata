% Es slide 22 - da_logica_a_CLP.pdf
:- lib(fd).

%clp
clp(L,S) :-
    %domini
    L::0..10, sommalista(L,S),

    %labelling
    labeling(L).

%caso base
sommalista([],0) :- !.

%caso ricorsivo
sommalista([H|T],S) :- sommalista(T,S1), S #= S1 + H.

