:-module('end',[countPiece/3,winner/2,isBoardFull/1,isFinished/1,noMoreLegalSquares/1,noMoreLegalSquares/2,checkWinner/2]).
:- use_module([library(lists),io]).


noMoreLegalSquares(Board):-
    noMoreLegalSquares(Board,1),
    noMoreLegalSquares(Board,-1).

noMoreLegalSquares(Board,Player):-
    not(io:getLegalMove(Player,_,_,Board)).


count([],_,0).
count([X|T],X,Y):- count(T,X,Z), Y is 1+Z.
count([X1|T],X,Z):- X1\=X,count(T,X,Z).


countPiece(Board,NBlack,NWhite):-
    countBlack(Board,NBlack),
    countWhite(Board,NWhite).

countBlack(Board,N):-
    nth0(0,Board,Line1),countBlackLine(Line1,N1),
    nth0(1,Board,Line2),countBlackLine(Line2,N2),
    nth0(2,Board,Line3),countBlackLine(Line3,N3),
    nth0(3,Board,Line4),countBlackLine(Line4,N4),
    nth0(4,Board,Line5),countBlackLine(Line5,N5),
    nth0(5,Board,Line6),countBlackLine(Line6,N6),
    nth0(6,Board,Line7),countBlackLine(Line7,N7),
    nth0(7,Board,Line8),countBlackLine(Line8,N8),
    N is (N1+N2+N3+N4+N5+N6+N7+N8).



countBlackLine(List,C) :-
    count(List,-1,C).

countWhite(Board,N):-
    nth0(0,Board,Line1),countWhiteLine(Line1,N1),
    nth0(1,Board,Line2),countWhiteLine(Line2,N2),
    nth0(2,Board,Line3),countWhiteLine(Line3,N3),
    nth0(3,Board,Line4),countWhiteLine(Line4,N4),
    nth0(4,Board,Line5),countWhiteLine(Line5,N5),
    nth0(5,Board,Line6),countWhiteLine(Line6,N6),
    nth0(6,Board,Line7),countWhiteLine(Line7,N7),
    nth0(7,Board,Line8),countWhiteLine(Line8,N8),
    N is (N1+N2+N3+N4+N5+N6+N7+N8).

countWhiteLine(List,C) :-
    count(List,1,C).

checkWinner(Board,Winner):-
	countPiece(Board,NBlack,NWhite),
    (NBlack < NWhite->Winner is 1;
    NBlack > NWhite->Winner is -1;
    NBlack =:= NWhite->Winner is 0).
	
winner(Board,Player):-
    countPiece(Board,NBlack,NWhite),
    (NBlack < NWhite->Player is 1,io:reportWinner(Player);
    NBlack > NWhite->Player is -1,io:reportWinner(Player);
    NBlack =:= NWhite->Player is 0,io:reportWinner(Player)).
