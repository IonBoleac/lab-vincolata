%slide 41 scheduling

:-lib(fd).
:-lib(edge_find).

%dobbiamo decidere ogni job quando inizia (gli start time S1...S6)
%vogliamo minimizzare la durata totale

%fatti 
task(j1,3,[],m1).
task(j2,8,[],m1).
task(j3,8,[j4,j5],m1).
task(j4,6,[],m2).
task(j5,3,[j1],m2).
task(j6,4,[j1],m2).


schedule(L):-
    %prendo i dati in ingresso
    findall(task(Nome,Durata,Precedenze,Macchina),task(Nome,Durata,Precedenze,Macchina),Lin),

    %definisco le variabili decisionali
    %è vantaggioso avere tutto in un unico predicato
    crea_start(Lin,L), %la lista L contiene tutto (anche gli start time) 

    %vincoli di precedenza
    precedenze(L,L),

    %imponiamo il vincolo disjunctive (non due job sulla stessa macchina)
    imponi_disjunctive(L),

    %end time globale
    seleziona_end_start(L,Lend,Lstart),
    maxlist(Lend,End),
    
    %search e ottimizzazione
    minimize(labeling(Lstart),End).
    
%aggiunge al predicato task un parametro start time. 
crea_start([],[]).
crea_start([task(Nome,Durata,Precedenze,Macchina)|Tin],[task(Nome,Durata,Precedenze,Macchina,Start,End)|Tout]) :-
    Start::0..1000000, %metto un numero molto grande per il dominio di Start
    End #= Start + Dur,
    crea_start(Tin,Tout). 


%vincoli di precedenza
precedenze([],_).
precedenze([task(Nome,Durata,Precedenze,Macchina,Start,End)|T], L) :- imponi_precedenze(End,Precedenze,L), precedenze(T,L).

%END deve essere prima di tutti gli start time dei task con gli ID nella lista PREC (imponi_precedenze(End,Prec,L).)
%la member estrae lo start corrispondente all'ID specificato
imponi_precedenze(_,[],_).
imponi_precedenze(End,[ID|T],L) :- member(task(ID,_,_,_,Start,_),L), End #=< Start, imponi_precedenze(End,T,L).


%non si possono avviare due task sulla stessa macchina contemporaneamente
imponi_disjunctive(L) :- findall(Macch,task(Nome,Durata,Precedenze,Macchina),LMacch), elimina_ripetuti(Lmacch,Lmacch1), imponi_disjunctive_loop(Lmacch1,L).

imponi_disjunctive_loop([],L).
imponi_disjunctive_loop([M|TM],L) :- selezione_task_tacchina(M,L,Lstart,Ldur), disjunctive(Lstart,Ldur), imponi_disjunctive_loop(TM,L).

selezione_task_tacchina(M,[],[],[]).
selezione_task_tacchina(M,[task(Nome,Durata,Precedenze,M,Start,End)|T],[Start|LSstart],[Durata|LDurata]) :-  selezione_task_tacchina(M,L,Lstart,LDurata). %notare che M è lo stesso
selezione_task_tacchina(M,[task(Nome,Durata,Precedenze,Macchina,Start,End)|T],LSstart,LDurata) :- M #\= Macchina, selezione_task_tacchina(M,L,Lstart,LDurata). %se la macchina non è quella specificata procedo con la ricorsione


%FARE ELIMINA RIPETUTI COME ESERCIZIO
%elimina_ripetuti(Lmacch,Lmacch1)

%FARE ELIMINA RIPETUTI COME ESERCIZIO
%seleziona_end(L,Lend)