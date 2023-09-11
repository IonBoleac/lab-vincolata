:- lib(fd).
:- lib(matrix_util).
:- lib(listut).
:- lib(lists).
:- [schema1].
:- ['estrai_confinanti.eco'].

% estrai_confinanti(++Nriga,++Ncol,+M,−LConfinanti)

csp(LConfinanti) :-
    schema(NumRighe, NumColonne, MatriceRigheSchema),
    matrix(NumRighe, NumColonne, MatriceRigheMine),
    flatten(MatriceRigheMine, FlattenMatriceRigheMine),
    FlattenMatriceRigheMine :: 0..1,

    imponiVincoloMine(MatriceRigheMine, MatriceRigheSchema, NumRighe, NumColonne),


    labeling(FlattenMatriceRigheMine).


