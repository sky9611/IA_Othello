:-module('eve',[playEvE/0]).
:-use_module([library(lists),io,fill,end,utils,ai1,ai3,ai4,ai2,ai5]).

playEvE :-
    io:welcome,
    utils:initialBoard( Board ),
    io:displayBoard( Board ),
    playEvE(-1,Board).

playEvE(Player,Board):-
    (   end:noMoreLegalSquares(Board)->end:printScore(Board),end:winner(Board,_),!;
        end:noMoreLegalSquares(Board,Player)->utils:changePlayer(Player,NewPlayer),playEvE(NewPlayer,Board);
     (   Player =:= -1 -> ai1:chooseMove1(-1,X,Y,Board),fill:fillAndFlip(X,Y,-1,Board,NewBoard),playEvE(1,NewBoard);
     ai3:chooseMove3(1,X,Y,Board),fill:fillAndFlip(X,Y,1,Board,NewBoard),playEvE(-1,NewBoard))).
