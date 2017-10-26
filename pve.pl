:-module('pve',[play/0]).
:-use_module([library(lists),io,fill,end,utils,ai1,ai3,ai4,ai2,ai5]).

%Initialise le jeu

play :-
    io:welcome,
    utils:initialBoard( Board ),
    io:displayBoard( Board ),
    chooseColor(_,AI),          %Choisi la couleur
    chooseLevel(D),             %Choisi le niveau de l'ia, puis lance la boucle correspondant à l'ia choisie
    (   D=:=1->play1(-1,AI,Board);
    D=:=2->play2(-1,AI,Board);
    D=:=3->play3(-1,AI,Board);
    D=:=4->play4(-1,AI,Board);
    D=:=5->play5(-1,AI,Board)).

%Permet au joueur de choisir la couleur avec laquelle il va jouer
chooseColor(Player,AI):-
    writeln('play white or black?(1 for white, -1 for black)'),
    read(Player),
    utils:changePlayer(Player,AI).
    
%Permet au joueur de choisir l'ia
chooseLevel(D):-
    writeln('play with which level of AI?(...)'),
    read(D).

/* Chaque boucle correspond à une ia.
   La structure est similaire au play de PVP.
   La seule différence est l'apparition d'un if afin de différencier si c'est le tour de l'humain ou de l'ia.
   Si c'est à l'humain de jouer, le principe est le même que dans PVP.
   Si c'est à l'ia de jouer, on appelle le chooseMove correspondant à l'ia afin de déterminer le coup, puis le board est mis à jour, affiché et on change de joueur.

play1(Player,AI,Board):-
    (   end:noMoreLegalSquares(Board)->end:printScore(Board),end:winner(Board,_);
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
    (   end:noMoreLegalSquares(Board)->end:printScore(Board),end:winner(Board,_);
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
    (   end:noMoreLegalSquares(Board)->end:printScore(Board),end:winner(Board,_);
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
    (   end:noMoreLegalSquares(Board)->end:printScore(Board),end:winner(Board,_);
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

play5(Player,AI,Board):-
    (   end:noMoreLegalSquares(Board)->end:printScore(Board),end:winner(Board,_);
        end:noMoreLegalSquares(Board,Player)->utils:changePlayer(Player,NewPlayer),play5(NewPlayer,AI,Board);
        io:reportTurn(Player),
        (   Player=:=AI->chooseMove5(AI,X,Y,Board),fill:fillAndFlip(X,Y,Player,Board,NewBoard),io:displayBoard(NewBoard),changePlayer(Player,NewPlayer),play5(NewPlayer,AI,NewBoard);
            utils:readInput(Player,X,Y,Board),
            %write(X),
            %write(','),
            %writeln(Y),
            fill:fillAndFlip(X,Y,Player,Board,NewBoard),
            io:displayBoard(NewBoard),
            utils:changePlayer(Player,NewPlayer),
            play5(NewPlayer,AI,NewBoard)    )).

