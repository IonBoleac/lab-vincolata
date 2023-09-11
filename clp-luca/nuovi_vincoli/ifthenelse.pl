ifthenelse(Cond,GoalThen,GoalElse):-
    call(Condizione), !, call(GoalThen).

ifthenelse(Cond,GoalThen,GoalElse):-
    call(GoalElse).