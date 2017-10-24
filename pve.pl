:-module('pve',[play/0]).
:-use_module([library(lists),io,fill,end,utils,ai1,ai3,ai4,ai2]).

play :-
    io:welcome,
    utils:initialBoard( Board ),
    io:displayBoard( Board ),
    chooseColor(_,AI),
    chooseLevel(D),
    (   D=:=1->play1(-1,AI,Board);
    D=:=2->play2(-1,AI,Board);
    D=:=3->play3(-1,AI,Board);
    D=:=4->play4(-1,AI,Board)).

chooseColor(Player,AI):-
    writeln('play white or black?(1 for white, -1 for black)'),
    read(Player),
    utils:changePlayer(Player,AI).

chooseLevel(D):-
    writeln('play with which level of AI?(...)'),
    read(D).

play1(Player,AI,Board):-
    (   end:noMoreLegalSquares(Board)->end:winner(Board,_);
        end:noMoreLegalSquares(Board,Player)->utils:changePlayer(Player,NewPlayer),play1(NewPlayer,AI,Board);
        io:reportTurn(Player),
        (   Player=:=AI->ai1:chooseMove1(AI,X,Y,Board),fill:fillAndFlip(X,Y,Player,Board,NewBoard),io:displayBoard(NewBoard),utils:changePlayer(Player,NewPlayer),play1(NewPlayer,AI,NewBoard);
            utils:readInput(Player,X,Y,Board),
            write(X),
            write(','),
            writeln(Y),
            fill:fillAndFlip(X,Y,Player,Board,NewBoard),
            io:displayBoard(NewBoard),
            utils:changePlayer(Player,NewPlayer),
            play1(NewPlayer,AI,NewBoard)    )).

play3(Player,AI,Board):-
    (   end:noMoreLegalSquares(Board)->end:winner(Board,_);
        end:noMoreLegalSquares(Board,Player)->utils:changePlayer(Player,NewPlayer),play3(NewPlayer,AI,Board);
        io:reportTurn(Player),
        (   Player=:=AI->chooseMove3(AI,X,Y,Board),fill:fillAndFlip(X,Y,Player,Board,NewBoard),io:displayBoard(NewBoard),changePlayer(Player,NewPlayer),play3(NewPlayer,AI,NewBoard);
            utils:readInput(Player,X,Y,Board),
            %write(X),
            %write(','),
            %writeln(Y),
            fill:fillAndFlip(X,Y,Player,Board,NewBoard),
            io:displayBoard(NewBoard),
            utils:changePlayer(Player,NewPlayer),
            play3(NewPlayer,AI,NewBoard)    )).

play4(Player,AI,Board):-
    (   end:noMoreLegalSquares(Board)->end:winner(Board,_);
        end:noMoreLegalSquares(Board,Player)->utils:changePlayer(Player,NewPlayer),play4(NewPlayer,AI,Board);
        io:reportTurn(Player),
        (   Player=:=AI->chooseMove4(AI,X,Y,Board),fill:fillAndFlip(X,Y,Player,Board,NewBoard),io:displayBoard(NewBoard),changePlayer(Player,NewPlayer),play4(NewPlayer,AI,NewBoard);
            utils:readInput(Player,X,Y,Board),
            %write(X),
            %write(','),
            %writeln(Y),
            fill:fillAndFlip(X,Y,Player,Board,NewBoard),
            io:displayBoard(NewBoard),
            utils:changePlayer(Player,NewPlayer),
            play4(NewPlayer,AI,NewBoard)    )).

play2(Player,AI,Board):-
    (   end:noMoreLegalSquares(Board)->end:winner(Board,_);
        end:noMoreLegalSquares(Board,Player)->utils:changePlayer(Player,NewPlayer),play2(NewPlayer,AI,Board);
        io:reportTurn(Player),
        (   Player=:=AI->chooseMove2(AI,X,Y,Board),fill:fillAndFlip(X,Y,Player,Board,NewBoard),io:displayBoard(NewBoard),changePlayer(Player,NewPlayer),play2(NewPlayer,AI,NewBoard);
            utils:readInput(Player,X,Y,Board),
            %write(X),
            %write(','),
            %writeln(Y),
            fill:fillAndFlip(X,Y,Player,Board,NewBoard),
            io:displayBoard(NewBoard),
            utils:changePlayer(Player,NewPlayer),
            play2(NewPlayer,AI,NewBoard)    )).

