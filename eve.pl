:-module('eve',[playEvE/0]).
:-use_module([library(lists),io,fill,end,utils,ai1,ai3,ai4,ai2]).

playEvE :-
    io:welcome,
    utils:initialBoard( Board ),
    io:displayBoard( Board ),
    play(-1,Board).

play(Player,Board):-
    (   end:noMoreLegalSquares(Board)->end:winner(Board,_);
        end:noMoreLegalSquares(Board,Player)->utils:changePlayer(Player,NewPlayer),play(NewPlayer,Board);
     (   Player =:= -1 -> chooseMove3(-1,X,Y,Board),fill:fillAndFlip(X,Y,Player,Board,NewBoard),io:displayBoard(NewBoard),utils:changePlayer(Player,NewPlayer),play(NewPlayer,NewBoard);
     chooseMove5(1,X,Y,Board),fill:fillAndFlip(X,Y,Player,Board,NewBoard),io:displayBoard(NewBoard),utils:changePlayer(Player,NewPlayer),play(NewPlayer,NewBoard))).
