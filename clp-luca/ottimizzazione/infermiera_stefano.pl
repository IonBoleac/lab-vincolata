%testo https://www.unife.it/ing/lm.infoauto/constraint-programming/materiale-didattico-2/lucidi/esercizio-tsp-tw

%Versione "facile" senza circuit e ic. 
%Una variabile della lista è una città. La visita è ordinata
:-lib(fd).
:-lib(propia).

%caricamento file
:-[infermiera_db].

max_end(Lend,Llen,End) :- maxlist(Lend, A), maxlist(Llen, B), End is A+B.

cost_function([H1,H2|T], C, Tm) :-
    distanza(H1, H2, C1C2) infers most,
    paziente(H1, MinStart, MaxEnd) infers most,  
    Tm1 #= Tm + C1C2,
    Tm1 #>= MinStart,
    Tm1 #=< MaxEnd,
    cost_function([H2|T], C1, Tm1),    
    C #= C1 + C1C2.
    
csp(L) :-
    findall(MaxEnd, paziente(_,_,MaxEnd), Lend),
    findall(Length, distanza(_,_,Length) ,Llen),
    %max_end(Lend,Llen,End),
   
    length(Lend,X),   
    length(L,X),
    L :: 0..X,
    L = [First|_],
    First#=0,
    alldifferent(L),
    cost_function(L,C,0),
    minimize(labeling(L),C).