:- lib(fd).

csp(L1, L2) :-
    % variabili e domini
    L1 = [X1, X2, X3, X4, X5, X6, X7, X8, X9, X10],
    L2 = [X11, X12, X13, X14, X15, X16, X17, X18, X19, X20],
    L1 :: [0, 1],
    L2 :: [0, 1],

    % vincoli
    % i) The answers to #6 and #7 are the same.
    X6 #= X7 #<=> X1,
    % ii) #1 is false.
    X1 #= 0 #<=> X2,
    % iii) The answers to #4 and #20 are different.
    X4 #\= X20 #<=> X3,
    % iv) The answers to #3 and #20 are different.
    X3 #\= X20 #<=> X4,
    % v) The answer to this statement is different from the answer to #19.
    X5 #\= X19 #<=> X5,
    % vi) #2 is true.
    X2 #= 2 #<=> X6,
    % vii) #15 is true.
    X15 #= 1 #<=> X7,
    % viii) The answers to #11 and #19 are the same.
    X11 #= X19 #<=> X8,
    % ix) #10 is true.
    X10 #= 1 #<=> X9,
    % x) #13 is false.
    X13 #= 0 #<=> X10, 
    % xi) Mrs. Jones is allergic to strawberries.

    % xii) #16 is true.
    X16 #= 1 #<=> X12,
    % xiii) #12 is true.
    X12 #= 1 #<=> X13,
    % xiv) The answer to this statement is the same as the answer to #11.
    X14 #= X11 #<=> X14,
    % xv) At least half the statements in this problem are false.
    X1 + X2 + X3 + X4 + X5 + X6 + X7 + X8 + X9 + X10 + X11 + X12 + X13 + X14 + X15 + X16 + X17 + X18 + X19 + X20 #<= 10 #<=> X15,
    % xvi) At least half the statements in this problem are true.
    X1 + X2 + X3 + X4 + X5 + X6 + X7 + X8 + X9 + X10 + X11 + X12 + X13 + X14 + X15 + X16 + X17 + X18 + X19 + X20 #>= 10 #<=> X16,
    % xvii) The answers to #9 and #4 are the same.
    X9 #= X4 #<=> X17,
    % xviii)#7 is true.
    X7 #= 1 #<=> X18,
    % ixx) Mrs. Jones first name is Shirley.

    % xx) The answers to #3 and #4 are different
    X3 #\= X4 #<=> X20,

    labeling(L1),
    labeling(L2).
