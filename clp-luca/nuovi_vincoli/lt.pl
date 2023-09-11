
%%% The following code has been produced by the CHR compiler


:- ( current_module(chr) -> true ; use_module(library(chr)) ).

:- get_flag(variable_names, Val), setval(variable_names_flag, Val), set_flag(variable_names, off).
lt(A, B) :-
	'CHRgen_num'(C),
	coca(add_one_constraint(C, lt(A, B))),
	'CHRlt_2'(lt(A, B), D, E, C).



%%% Rules handling for lt / 2

'CHRlt_2'(lt(A, B), C, D, E) :-
	(
	    'CHRnonvar'(C)
	;
	    'CHRalready_in'('CHRlt_2'(lt(A, B), C, D, E)),
	    coca(already_in)
	),
	!.
'CHRlt_2'(lt(A, A), B, C, D) ?-
	coca(try_rule(D, lt(A, A), anonymous("1"), lt(E, E), replacement, true, false)),
	!,
	'CHRkill'(B),
	coca(fired_rule(anonymous("1"))),
	false.
'CHRlt_2'(lt(A, B), C, D, E) ?-
	'CHRget_delayed_goals'(A, F),
	'CHRlt_2__4'(F, [A, B], [], G),
	coca(try_double(E, lt(A, B), G, lt(B, A), lt(H, I), lt(I, H), replacement, true, false, anonymous("0"))),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("0"))),
	false.
'CHRlt_2'(lt(A, B), C, D, E) ?-
	'CHRget_delayed_goals'(A, F),
	'CHRlt_2__5'(F, [A, B], [], G),
	coca(try_double(E, lt(A, B), G, lt(B, A), lt(H, I), lt(I, H), replacement, true, false, anonymous("0"))),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("0"))),
	false.
'CHRlt_2'(lt(A, B), C, D, E) :-
	'CHRlt_2__3'(lt(A, B), C, D, E).
'CHRlt_2__4'(['CHRlt_2'(lt(A, B), C, D, E)|F], [B, A], [], G) ?-
	'CHRvar'(C),
	'CHRkill'(C),
	'CHR='([], []),
	'CHR='(E, G).
'CHRlt_2__4'([A|B], C, D, E) :-
	'CHRlt_2__4'(B, C, D, E).
:- set_flag('CHRlt_2__4' / 4, leash, notrace).
'CHRlt_2__5'(['CHRlt_2'(lt(A, B), C, D, E)|F], [B, A], [], G) ?-
	'CHRvar'(C),
	'CHRkill'(C),
	'CHR='([], []),
	'CHR='(E, G).
'CHRlt_2__5'([A|B], C, D, E) :-
	'CHRlt_2__5'(B, C, D, E).
:- set_flag('CHRlt_2__5' / 4, leash, notrace).
:- set_flag('CHRlt_2' / 4, leash, notrace).
:- current_macro('CHRlt_2' / 4, _24967, _24968, _24969) -> true ; define_macro('CHRlt_2' / 4, tr_chr / 2, [write]).
'CHRlt_2__3'(A, B, C, D) :-
	'CHRlt_2__6'(A, B, C, D).
:- set_flag('CHRlt_2__3' / 4, leash, notrace).
'CHRlt_2__6'(lt(A, B), C, D, E) ?-
	'CHRvar'(C),
	!,
	'CHRget_delayed_goals'(B, F),
	'CHRlt_2__6__7'(F, C, lt(A, B), D, E).
'CHRlt_2__6'(lt(A, B), C, D, E) :-
	'CHRlt_2__6__8'(lt(A, B), C, D, E).
:- set_flag('CHRlt_2__6' / 4, leash, notrace).
'CHRlt_2__6__7'(['CHRlt_2'(lt(A, B), C, D, E)|F], G, lt(H, A), I, J) ?-
	'CHRvar'(C),
	'CHRcheck_and_mark_applied'('12'(anonymous("2")), G, C, I, D),
	coca(try_double(J, lt(H, A), E, lt(A, B), lt(K, L), lt(L, M), augmentation, true, lt(K, M), anonymous("2"))),
	!,
	coca(fired_rule(anonymous("2"))),
	'CHRlt_2__6__7'(F, G, lt(H, A), I, J),
	lt(H, B).
'CHRlt_2__6__7'([A|B], C, D, E, F) :-
	'CHRlt_2__6__7'(B, C, D, E, F).
'CHRlt_2__6__7'([], A, B, C, D) :-
	'CHRlt_2__6__8'(B, A, C, D).
:- set_flag('CHRlt_2__6__7' / 5, leash, notrace).
'CHRlt_2__6__8'(lt(A, B), C, D, E) ?-
	'CHRvar'(C),
	!,
	'CHRget_delayed_goals'(A, F),
	'CHRlt_2__6__8__9'(F, C, lt(A, B), D, E).
'CHRlt_2__6__8'(lt(A, B), C, D, E) :-
	'CHRlt_2__6__8__10'(lt(A, B), C, D, E).
:- set_flag('CHRlt_2__6__8' / 4, leash, notrace).
'CHRlt_2__6__8__9'(['CHRlt_2'(lt(A, B), C, D, E)|F], G, lt(B, H), I, J) ?-
	'CHRvar'(C),
	'CHRcheck_and_mark_applied'('21'(anonymous("2")), G, C, I, D),
	coca(try_double(J, lt(B, H), E, lt(A, B), lt(K, L), lt(M, K), augmentation, true, lt(M, L), anonymous("2"))),
	!,
	coca(fired_rule(anonymous("2"))),
	'CHRlt_2__6__8__9'(F, G, lt(B, H), I, J),
	lt(A, H).
'CHRlt_2__6__8__9'([A|B], C, D, E, F) :-
	'CHRlt_2__6__8__9'(B, C, D, E, F).
'CHRlt_2__6__8__9'([], A, B, C, D) :-
	'CHRlt_2__6__8__10'(B, A, C, D).
:- set_flag('CHRlt_2__6__8__9' / 5, leash, notrace).
'CHRlt_2__6__8__10'(lt(A, B), C, D, E) :-
	(
	    'CHRvar'(C)
	->
	    'CHRdelay'([C, lt(A, B)], 'CHRlt_2'(lt(A, B), C, D, E))
	;
	    true
	).
:- set_flag('CHRlt_2__6__8__10' / 4, leash, notrace).

:- getval(variable_names_flag, Val), set_flag(variable_names, Val).
