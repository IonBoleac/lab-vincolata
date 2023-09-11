:- dynamic cnf/2.
:- dynamic clausola/1.

read_cnf(FileName):-
    open(FileName,read,File),
    read_token(File,C,_),
    retract_all(cnf(_,_)),
    retract_all(clausola(_)),
    parse_cnf(C,File),
    close(File).

parse_cnf('c',File):- !, read_string(File, end_of_line, _, _), read_token(File,C,_), parse_cnf(C,File).
parse_cnf('p',File):- !,  
    expect(File,_,cnf),
    read_token(File,Nvar,_), read_token(File,Nclauses,_),
    assert(cnf(Nvar,Nclauses)),
    read_token(File,C,_), parse_cnf(C,File).
parse_cnf(C,File):-
    cnf(_,Nclauses), Nclauses1 is Nclauses-1,
    read_clause(File,Clause),
    fix_sign([C|Clause],ClausolaFixed),
    assert(clausola(ClausolaFixed)),
    parse_clauses(File,Nclauses1).

parse_clauses(_,0):-!.
parse_clauses(File,Nclauses):-
    read_clause(File,Clause),!,
    fix_sign(Clause,ClausolaFixed),
    assert(clausola(ClausolaFixed)),
    Nclauses1 is Nclauses-1,
    parse_clauses(File,Nclauses1).

read_clause(File,Clause):-
    read_token(File,A,_),
    (A=0 -> Clause = []
        ;   Clause = [A|Clause1], read_clause(File,Clause1)
    ).

expect(File,X,E):-
    read_token(File,X,_),
    (X=E -> true ; write("Expecting "), write(E), write("Found "), writeln(X), fail).

fix_sign([],[]).
fix_sign([-,N|T],[MN|Tfix]):-!,
    MN is -N,
    fix_sign(T,Tfix).
fix_sign([N|T],[N|Tfix]):-
    fix_sign(T,Tfix).
