%vincolo di valore assoluto
:-lib(fd).

%VERSIONE ARC CONSISTENCY


abs_val(X,A) :- 
    %recupero dominio di X
    dvar_domain(X,DomX),
    dvar_domain(A,DomA),

    %elimino i valori dal dominio di A 
    dvar_remove_smaller(A,0),

    %traformo il dominio in lista
    dom_to_list(DomX,ListDomX),
    dom_to_list(DomA,ListDomA),

    %aggiorno il dominio di A. 
    %Elimino tutti i valori che non sono abs di valori nel dominio di X
    valoreAssoluto(ListDomX,Xpos),
    list_to_dom(Xpos,XposDom),
    dom_intersection(DomA,XposDom,NewDomA,_),
    dvar_update(A,NewDomA),

    %aggiorno il dominio di X
    %Elimino tutti i valori che non sono uguali a +- quelli di A 
    pom(ListDomA,XConNeg),
    list_to_dom(XConNeg, XConNegDom),
    dom_intersection(DomX,XConNegDom,NewDomX,_),
    dvar_update(X,NewDomX),

    %sospensione
    sospendi(X,A).


valoreAssoluto([],[]).
valoreAssoluto([H|T],[Hout|Tout]) :- (H #< 0 -> Hout #= -H ; Hout #= H), valoreAssoluto(T,Tout).

pom([],[]).
pom([H|T],[H,Hneg|Tout]) :- Hneg #= -H, pom(T,Tout).

sospendi(_,A) :- nonvar(A), !.
sospendi(X,_) :- nonvar(X), !.
sospendi(X,A):- suspend(abs_val(X,A),5,[A->any,X->any]).

%query: X::[-1,-2,0,3,4,5], A :: [-1,7,8,9,3,4], abs_val(X,A).

