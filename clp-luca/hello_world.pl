% CSP:

% A,B :: 1..10, A>B

:- lib(fd).
csp(A,B) :- A::1..10, B::1..10, A#>B.