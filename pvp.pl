:-module('pvp',[playPvP/0]).
:-use_module([io,fill,end,utils]).

% Module pour lancer le jeu en mode player versus player

playPvP :-
    writeln('Human Vs Human'),
    utils:initialBoard( Board ),    %Initialise le board
    io:displayBoard( Board ),       %Affiche le board
    utils:isBlack(Black),           %Initialise le premier joueur comme jouant les noirs
    play(Black,Board).              %Lance la boucle play

play(Player,Board):-
    (   end:noMoreLegalSquares(Board)->end:winner(Board,_);     %Arrete le jeu s'il n'y a plus de coup possibles sur le board
        end:noMoreLegalSquares(Board,Player)->utils:changePlayer(Player,NewPlayer),play(NewPlayer,Board);   %Si un joueur ne peut pas jouer, hange de joueur
        io:reportTurn(Player),
        utils:readInput(Player,X,Y,Board),      %Lis le coup jou par le joueur
        write(X),
        write(','),
        writeln(Y),
        fill:fillAndFlip(X,Y,Player,Board,NewBoard),        %Met  jour le board en fonction du coup
        io:displayBoard(NewBoard),                          %Affiche le nouveau board
        utils:changePlayer(Player,NewPlayer),               %Change de joueur
        play(NewPlayer,NewBoard)    ).
