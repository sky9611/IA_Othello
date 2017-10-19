:-module('io', [displayBoard/1, getLegalMove/4, reportMove/3,reportNoMove/1, reportStalemate/0, reportWinner/1, welcome/0]).

% Board =
% [[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,1,-1,0,0,0],[0,0,0,-1,1,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0]].

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

%printVal(N):- var(N),write('- '),!.
printVal(0):- write('- ').
printVal(1):- write('O ').
printVal(-1):- write('X ').


displayBoard(Board) :-
    writeln('*---------*'),
    writeln('  a  b  c  d  e  f  g  h'),
    printLists(Board,0),
    writeln('*---------*').

getVal(Board, X, Y, Val) :-
  nth0(X, Board, Column),
  nth0(Y, Column, Val).

isOnBoard(X,Y):-
    between(1,8,X),
    between(1,8,Y).

getLegalMove(Player,X,Y,Board) :-
    isOnBoard(X,Y),
    getVal(Board,X,Y,0),
    chain(Player,X,Y,Board).

chainDirection(Player,X,Y,Dx,Dy,N,Board):-
    XX is X+Dx,
    YY is Y+Dy,
    getVal(Board,XX,YY,Player),
    N is 0,
    !.

chainDirection(_,X,Y,Dx,Dy,N,Board):-
    XX is X+Dx,
    YY is Y+Dy,
    getVal(Board,XX,YY,0),
    N is -10,
    !.

chainDirection(Player,X,Y,Dx,Dy,N,Board):-
    XX is X+Dx,
    YY is Y+Dy,
    isOnBoard(X,Y),
    chainDirection(Player,XX,YY,Dx,Dy,NN,Board),
    N is NN+1.



chain(Player,X,Y,Board):-
    chainDirection(Player,X,Y,-1,-1,N,Board),N>0.
chain(Player,X,Y,Board):-
    chainDirection(Player,X,Y,-1,0,N,Board),N>0.
chain(Player,X,Y,Board):-
    chainDirection(Player,X,Y,-1,1,N,Board),N>0.
chain(Player,X,Y,Board):-
    chainDirection(Player,X,Y,0,1,N,Board),N>0.
chain(Player,X,Y,Board):-
    chainDirection(Player,X,Y,1,1,N,Board),N>0.
chain(Player,X,Y,Board):-
    chainDirection(Player,X,Y,1,0,N,Board),N>0.
chain(Player,X,Y,Board):-
    chainDirection(Player,X,Y,1,-1,N,Board),N>0.
chain(Player,X,Y,Board):-
    chainDirection(Player,X,Y,0,-1,N,Board),N>0.

transformeAndWriteY(Y):-(Y=:=1->write('a');
                        Y=:=2->write('b');
                        Y=:=3->write('c');
                        Y=:=4->write('d');
                        Y=:=5->write('e');
                        Y=:=6->write('f');
                        Y=:=7->write('g');
                        Y=:=8->write('h')).

reportMove(Player,X,Y):-
    isOnBoard(X,Y),
    write(Player),
    write(' played on '),
    write(X),
    transformeAndWriteY(Y).

reportNoMove(Player):-
     write(Player),
     write(' has an illigal move').

reportStalemate():-
    write('Drawn').

reportWinner(Player):-
    (Player=:=1->write('White is winner');
    Player=:=8->write('Black is winner')).

welcome():-
    write('Welcome!').
