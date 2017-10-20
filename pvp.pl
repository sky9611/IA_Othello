:-module('pvp',[play/0]).
:-use_module([library(lists),io,fill,end,utils]).

play :-
    io:welcome,
    utils:initialBoard( Board ),
    io:displayBoard( Board ),
    utils:isBlack(Black),
    play(Black,Board).

play(Player,Board):-
    (   end:noMoreLegalSquares(Board)->end:winner(Board,_);
        end:noMoreLegalSquares(Board,Player)->utils:changePlayer(Player,NewPlayer),play(NewPlayer,Board);
        io:reportTurn(Player),
        utils:readInput(Player,X,Y,Board),
        write(X),
        write(','),
        writeln(Y),
        fill:fillAndFlip(X,Y,Player,Board,NewBoard),
        io:displayBoard(NewBoard),
        utils:changePlayer(Player,NewPlayer),
        play(NewPlayer,NewBoard)    ).
