:-module('ai2',[chooseMove2/4]).
:-use_module([library(lists),io,fill,end,utils,ai3]).



chooseMove2(AI,X,Y,Board):-
    findall([X,Y],getLegalMove(AI,X,Y,Board),MoveList),
    maplist(ai3:fillAndFlipTemp(Board,AI),MoveList,BoardList),
    maplist(evalSimple(AI),BoardList,EvalList),
    listMax(EvalList,Max),
    getLegalMove(AI,X,Y,Board),
    fillAndFlip(X,Y,AI,Board,NewBoard),
    evalSimple(AI,NewBoard,Max),
    utils:retransformeX(N,X),
    utils:retransformeY(Al,Y),
    reportMove(AI,N,Al),
    !.

evalSimple(Player,Board,E):-
    countPlayer(Board,Player,E).


countPlayer(Board,Player,N):-
    nth0(0,Board,Line1),countPlayerLine(Line1,Player,N1),
    nth0(1,Board,Line2),countPlayerLine(Line2,Player,N2),
    nth0(2,Board,Line3),countPlayerLine(Line3,Player,N3),
    nth0(3,Board,Line4),countPlayerLine(Line4,Player,N4),
    nth0(4,Board,Line5),countPlayerLine(Line5,Player,N5),
    nth0(5,Board,Line6),countPlayerLine(Line6,Player,N6),
    nth0(6,Board,Line7),countPlayerLine(Line7,Player,N7),
    nth0(7,Board,Line8),countPlayerLine(Line8,Player,N8),
    N is (N1+N2+N3+N4+N5+N6+N7+N8).

countPlayerLine(List,Player,C):-
    end:count(List,Player,C).
