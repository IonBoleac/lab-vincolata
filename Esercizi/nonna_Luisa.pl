:- lib(fd).
:- lib(fd_global).


csp(L, TempoDistrarreNonna, TempoDistrarreCane, TempoSotrarreTorta, Tempi):-
    % lista L -> indice corrisponde al piano e il valore a chi lo fa (1=Carletto, 2=Pierino, 3=Tommaso)
    length(L, 3),
    L :: [1..3],
    L = [A, B, C],
    fd_global:alldifferent(L), % ogni parte del piano va fatto da un nipote differente
    Tempi = [InizioDistrazioneNonna, InizioDistrazioneCane, InizioSotrazzioneTorta, FineDistrazioneNonna, FineDistrazioneCane, FineSotrazzioneTorta],
    Tempi :: 0..10,

    % indice corrisppnde in ordine Carletto, Pierino, Tommaso
    %                  Carletto   Pierino  Tommaso
    LParlareNonna  =       [5,       3,       2],
    LDistrarreCane =       [4,       2,       3],
    LSotrarreTorta =       [2,       5,       4],

    element(A, LParlareNonna, TempoDistrarreNonna),
    element(B, LDistrarreCane, TempoDistrarreCane),
    element(C, LSotrarreTorta, TempoSotrarreTorta),

    % vincolo: nonna
    InizioDistrazioneNonna #= 0,
    FineDistrazioneNonna - InizioDistrazioneNonna #= TempoDistrarreNonna,

    % vincolo: il cane si deve iniziare a distrarre in una finestra temporale ben definito
    InizioDistrazioneNonna + 1 #=< InizioDistrazioneCane,
    FineDistrazioneNonna - 1 #>= InizioDistrazioneCane,
    FineDistrazioneCane - InizioDistrazioneCane #= TempoDistrarreCane,


    % vincolo: la torta deve essere sotratta mentre la nonna e il cane sono distratti
    InizioSotrazzioneTorta #>= InizioDistrazioneNonna,
    InizioSotrazzioneTorta #>= InizioDistrazioneCane,
    FineSotrazzioneTorta #=< FineDistrazioneNonna,
    FineSotrazzioneTorta #=< FineDistrazioneCane,
    FineSotrazzioneTorta - InizioSotrazzioneTorta #= TempoSotrarreTorta,



    labeling(L).