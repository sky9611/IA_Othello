:-module('ai1',[chooseMove1/4]).
:-use_module([library(lists),io]).

chooseMove1(AI,X,Y,Board):-
    findall([XX,YY],getLegalMove(AI,XX,YY,Board),MoveList),
    length(MoveList,L),
    random(0,L,N),
    nth0(N,MoveList,[X,Y]),
    utils:retransformeX(NN,X),
    utils:retransformeY(Al,Y),
    reportMove(AI,NN,Al).

