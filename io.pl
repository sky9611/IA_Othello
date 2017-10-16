%:-module('display', [displayBoard/1, getLegalMove/4, reportMove/3,
% reportNoMove/1, reportStalemate/0, reportWinner/1, welcome/0]).

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

getLegalMove
