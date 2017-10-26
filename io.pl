:-module('io', [displayBoard/1, getLegalMove/4, reportMove/3,reportNoMove/1, reportStalemate/0, reportWinner/1, welcome/0,reportTurn/1]).
:-use_module([utils]).


% Board =
% [[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,1,-1,0,0,0],[0,0,0,-1,1,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0]].

%prints every line of the Board
displayBoard(Board) :-
    writeln('*-----------------------*'),
    writeln('  a  b  c  d  e  f  g  h'),
    printLists(Board,0),
    writeln('*-----------------------*').

%printList is able to print a line of the Board
printList([]) :- format('~n', []).

printList([H|T]) :-
    printVal(H),
    write(' '),
    printList(T).

printLists([], _).
printLists([H|T], N) :-
    M is N + 1,
    format('~d ', M),
    printList(H),
    printLists(T, M).

%prints accordingly with the value of the cell
printVal(0):- write('- ').
printVal(1):- write('O ').
printVal(-1):- write('X ').

%calculate the cells that Player can place a piece
getLegalMove(Player,X,Y,Board) :-
    utils:isOnBoard(X,Y),
    utils:getVal(Board,X,Y,0),
    chain(Player,X,Y,Board).

%checks top left
chain(Player,X,Y,Board):-
    chainDirection(Player,X,Y,-1,-1,N,Board),N>0.
%checks left
chain(Player,X,Y,Board):-
    chainDirection(Player,X,Y,-1,0,N,Board),N>0.
%checks bottom left
chain(Player,X,Y,Board):-
    chainDirection(Player,X,Y,-1,1,N,Board),N>0.
%checks bottom
chain(Player,X,Y,Board):-
    chainDirection(Player,X,Y,0,1,N,Board),N>0.
%checks bottom right
chain(Player,X,Y,Board):-
    chainDirection(Player,X,Y,1,1,N,Board),N>0.
%checks right
chain(Player,X,Y,Board):-
    chainDirection(Player,X,Y,1,0,N,Board),N>0.
%checks top right
chain(Player,X,Y,Board):-
    chainDirection(Player,X,Y,1,-1,N,Board),N>0.
%checks top
chain(Player,X,Y,Board):-
    chainDirection(Player,X,Y,0,-1,N,Board),N>0.

%stop us from looking outside of the board
chainDirection(_,X,Y,Dx,Dy,N,_):-
    XX is X+Dx,
    YY is Y+Dy,
    not(utils:isOnBoard(XX,YY)),
    N is -10,
    !.
%N is 0 if it's the same color
chainDirection(Player,X,Y,Dx,Dy,N,Board):-
    XX is X+Dx,
    YY is Y+Dy,
    utils:getVal(Board,XX,YY,Player),
    N is 0,
    !.
%N is -10 if looking an empty cell
chainDirection(_,X,Y,Dx,Dy,N,Board):-
    XX is X+Dx,
    YY is Y+Dy,
    utils:getVal(Board,XX,YY,0),
    N is -10,
    !.
%if all of the above fail, eg we are looking at another color,
%we will keep following the same direction
%if we can capture them, N will be positive in the end
chainDirection(Player,X,Y,Dx,Dy,N,Board):-
    XX is X+Dx,
    YY is Y+Dy,
    utils:isOnBoard(XX,YY),
    chainDirection(Player,XX,YY,Dx,Dy,NN,Board),
    N is NN+1.

reportTurn(Player):-
    (Player =:= 1->writeln('It\'s White\'s turn!');
     Player =:= -1->writeln('It\'s Black\'s turn!')).

reportMove(Player,X,Y):-
    (   Player =:= 1 -> write('White ');
    write('Black ')),
    write('played on '),
    write(X),write(','),write(Y),
    writeln('').

reportNoMove(Player):-
     write(Player),
     write(' has an illigal move').

reportStalemate:-
    write('Drawn').

welcome:-
    writeln('Welcome!').

reportWinner(Player):-
    (Player =:= 1 -> write('White is winner');
     Player =:= -1 -> write('Black is winner');
     Player =:= 0 -> write('Drawn')).


