/*
    TODO define a DCG to analyse a small subset of English used to describe mathematiacal equations
    TODO Interface the DCG with the finite domain equation solver built into prolog
    TODO Tests
    TODO Build a smaller program to check results of deduction, reporting if there is a unique solution
*/

% front end: lpsolve/2 succeeds when its first
% argument is a list of well formed sentences
% and its second is a list of constrained variables
lpsolve( Data, Answers ) :-
    lpsolve( [], Answers, Data, [] ).
% lpsolve/4 succeeds when its first argument is a
% list of variable name/Prolog variable pairs, its
% second is the same list modified with any new
% variables introduced in the list of sentences
% in argument 3 which is parsed with the remainder
% given in argument 4
lpsolve( VariablesIn, VariablesOut ) -->
    sentence( VariablesIn, VariablesOut ).
lpsolve( VariablesIn, VariablesOut ) -->
    sentence( VariablesIn, VariablesBetween ),
   lpsolve( VariablesBetween, VariablesOut ).

look_up(A, B, C, D). %needed according to the docs.