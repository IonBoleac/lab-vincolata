%EserciziCLP1.pdf slide 1 - Divisioni
%Bisogna dividere le sfere fra 2 fratelli in modo che abbiamo lo stesso peso

:- lib(fd).


divisioni(N,Fratelli):-

    %genero la lista di N elementi booleani (fratello 1 o 0)
    length(Fratelli,N),
    Fratelli::0..1,
    
    %genero la lista dei pesi (cubi di 1,2,3,...,N)
    generalista(L,N),
    peso(L,Pesi),

    %determino il peso che deve avere ogni fratello
    sommalista(Pesi,Somma),
    Div * 2 #= Somma,

    %determino il peso che ha ogni fratello
    sommacondizionale(Pesi,Fratelli,Somma1),

    %imponngo che il fratello 1 abbia esattamente metà del peso (di conseguenza anche l'altro avrà la metà)
    Somma1 #= Div,

    labeling(Fratelli).

%peso(Lista, ListaCubi) ListaCubi è la lista dei cubi di ogni elemento di Lista
peso([X],[Y]):- Y #= X*X*X.
peso([X|Z],[Y|P]):- Y #= X*X*X, peso(Z,P).

%generalista(Lista, N) Genero una Lista da 1 a N
generalista([],0):-!.
generalista([N|T],N) :-
    N1 is N-1, generalista(T,N1).

%sommalista(L,Somma) Calcolo la somma di una lista
sommalista([],0).
sommalista([H|T],Somma) :- sommalista(T,Somma1), Somma is Somma1 + H.

%sommacondizionale(L1,L2,Somma) Calcolo la somma di L1 * L2 (elemento per elemento)
%In questo caso serve a sommanre i pesi del fratello 1 dato che l'altro moltiplica per 0 i suoi pesi
sommacondizionale([],_,0).
sommacondizionale([H|T],[Htest|Ttest],Somma) :-  sommacondizionale(T,Ttest, Somma1), Somma #= Somma1 + H*Htest.
