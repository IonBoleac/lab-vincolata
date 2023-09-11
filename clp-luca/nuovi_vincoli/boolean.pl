
%%% The following code has been produced by the CHR compiler


:- ( current_module(chr) -> true ; use_module(library(chr)) ).

:- get_flag(variable_names, Val), setval(variable_names_flag, Val), set_flag(variable_names, off).
and(A, B, C) :-
	'CHRgen_num'(D),
	coca(add_one_constraint(D, and(A, B, C))),
	'CHRand_3'(and(A, B, C), E, F, D).



%%% Rules handling for and / 3

'CHRand_3'(and(A, B, C), D, E, F) :-
	(
	    'CHRnonvar'(D)
	;
	    'CHRalready_in'('CHRand_3'(and(A, B, C), D, E, F)),
	    coca(already_in)
	),
	!.
'CHRand_3'(and(A, A, B), C, D, E) ?-
	coca(try_rule(E, and(A, A, B), anonymous("0"), and(F, F, G), replacement, true, G = F)),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("0"))),
	B = A.
'CHRand_3'(and(A, B, 1), C, D, E) ?-
	coca(try_rule(E, and(A, B, 1), anonymous("1"), and(F, G, 1), replacement, true, (F = 1, G = 1))),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("1"))),
	[A, B] = [1, 1].
'CHRand_3'(and(0, A, B), C, D, E) ?-
	coca(try_rule(E, and(0, A, B), anonymous("2"), and(0, F, G), replacement, true, G = 0)),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("2"))),
	B = 0.
'CHRand_3'(and(A, 0, B), C, D, E) ?-
	coca(try_rule(E, and(A, 0, B), anonymous("3"), and(F, 0, G), replacement, true, G = 0)),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("3"))),
	B = 0.
'CHRand_3'(and(A, B, 0), C, D, E) ?-
	coca(try_rule(E, and(A, B, 0), anonymous("4"), and(F, G, 0), replacement, true, (F \= 1, G \= 1))),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("4"))),
	A \= 1,
	B \= 1.
'CHRand_3'(and(A, B, C), D, E, F) :-
	'CHRand_3__10'(and(A, B, C), D, E, F).
:- set_flag('CHRand_3' / 4, leash, notrace).
:- current_macro('CHRand_3' / 4, _2690, _2691, _2692) -> true ; define_macro('CHRand_3' / 4, tr_chr / 2, [write]).
'CHRand_3__10'(A, B, C, D) :-
	'CHRand_3__11'(A, B, C, D).
:- set_flag('CHRand_3__10' / 4, leash, notrace).
'CHRand_3__11'(and(A, B, C), D, E, F) :-
	(
	    'CHRvar'(D)
	->
	    'CHRdelay'([D, and(A, B, C)], 'CHRand_3'(and(A, B, C), D, E, F))
	;
	    true
	).
:- set_flag('CHRand_3__11' / 4, leash, notrace).
or(A, B, C) :-
	'CHRgen_num'(D),
	coca(add_one_constraint(D, or(A, B, C))),
	'CHRor_3'(or(A, B, C), E, F, D).



%%% Rules handling for or / 3

'CHRor_3'(or(A, B, C), D, E, F) :-
	(
	    'CHRnonvar'(D)
	;
	    'CHRalready_in'('CHRor_3'(or(A, B, C), D, E, F)),
	    coca(already_in)
	),
	!.
'CHRor_3'(or(1, A, B), C, D, E) ?-
	coca(try_rule(E, or(1, A, B), anonymous("5"), or(1, F, G), replacement, true, G = 1)),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("5"))),
	B = 1.
'CHRor_3'(or(A, 1, B), C, D, E) ?-
	coca(try_rule(E, or(A, 1, B), anonymous("6"), or(F, 1, G), replacement, true, G = 1)),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("6"))),
	B = 1.
'CHRor_3'(or(0, 0, A), B, C, D) ?-
	coca(try_rule(D, or(0, 0, A), anonymous("7"), or(0, 0, E), replacement, true, E = 0)),
	!,
	'CHRkill'(B),
	coca(fired_rule(anonymous("7"))),
	A = 0.
'CHRor_3'(or(A, B, C), D, E, F) :-
	'CHRor_3__12'(or(A, B, C), D, E, F).
:- set_flag('CHRor_3' / 4, leash, notrace).
:- current_macro('CHRor_3' / 4, _3649, _3650, _3651) -> true ; define_macro('CHRor_3' / 4, tr_chr / 2, [write]).
'CHRor_3__12'(A, B, C, D) :-
	'CHRor_3__13'(A, B, C, D).
:- set_flag('CHRor_3__12' / 4, leash, notrace).
'CHRor_3__13'(or(A, B, C), D, E, F) :-
	(
	    'CHRvar'(D)
	->
	    'CHRdelay'([D, or(A, B, C)], 'CHRor_3'(or(A, B, C), D, E, F))
	;
	    true
	).
:- set_flag('CHRor_3__13' / 4, leash, notrace).
neg(A, B) :-
	'CHRgen_num'(C),
	coca(add_one_constraint(C, neg(A, B))),
	'CHRneg_2'(neg(A, B), D, E, C).



%%% Rules handling for neg / 2

'CHRneg_2'(neg(A, B), C, D, E) :-
	(
	    'CHRnonvar'(C)
	;
	    'CHRalready_in'('CHRneg_2'(neg(A, B), C, D, E)),
	    coca(already_in)
	),
	!.
'CHRneg_2'(neg(0, A), B, C, D) ?-
	coca(try_rule(D, neg(0, A), anonymous("8"), neg(0, E), replacement, true, E = 1)),
	!,
	'CHRkill'(B),
	coca(fired_rule(anonymous("8"))),
	A = 1.
'CHRneg_2'(neg(1, A), B, C, D) ?-
	coca(try_rule(D, neg(1, A), anonymous("9"), neg(1, E), replacement, true, E = 0)),
	!,
	'CHRkill'(B),
	coca(fired_rule(anonymous("9"))),
	A = 0.
'CHRneg_2'(neg(A, B), C, D, E) :-
	'CHRneg_2__14'(neg(A, B), C, D, E).
:- set_flag('CHRneg_2' / 4, leash, notrace).
:- current_macro('CHRneg_2' / 4, _4453, _4454, _4455) -> true ; define_macro('CHRneg_2' / 4, tr_chr / 2, [write]).
'CHRneg_2__14'(A, B, C, D) :-
	'CHRneg_2__15'(A, B, C, D).
:- set_flag('CHRneg_2__14' / 4, leash, notrace).
'CHRneg_2__15'(neg(A, B), C, D, E) :-
	(
	    'CHRvar'(C)
	->
	    'CHRdelay'([C, neg(A, B)], 'CHRneg_2'(neg(A, B), C, D, E))
	;
	    true
	).
:- set_flag('CHRneg_2__15' / 4, leash, notrace).

:- getval(variable_names_flag, Val), set_flag(variable_names, Val).
