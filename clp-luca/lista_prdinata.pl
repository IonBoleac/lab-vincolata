% Es slide 22 - da_logica_a_CLP.pdf

%import della libreria
:- lib(fd).

%caso base la lista contiene un solo elemento (con cut per evitare backtracking)
ordina([_]) :- !.

%caso ricorsivo
ordina([A,B|T]) :- A #>B, ordina([B|T]).
