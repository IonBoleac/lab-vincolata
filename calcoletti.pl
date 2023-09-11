:- lib(fd).


%  csp(L).
csp(Vars) :-

    Vars = [A, B, C, D, E],
    Vars :: 0..100,
    % C #> 0,

    % A*10 + B #= C + D + E,
    % A*B #= C + D + E,
     A*B #= (C*10 + D) + E,
    % (A*10 + B) * C #= D + E,
    alldifferent(Vars),
    labeling([A, B, C, D, E]).
