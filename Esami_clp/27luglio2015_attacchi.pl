:- [attacchi].
:- lib(fd).


csp(L) :-
    difese(ListaDifese),
    findall(attacco(Tipologia,ListaContromisure), attacco(Tipologia,ListaContromisure), ListaAtacchi),

    