:-module('ai4',[chooseMove4/4]).
:-use_module([library(apply),io,fill,end,utils,ai3]).

bwTurn(Board,Color) :-
    countPiece(Board,NBlack,NWhite),
    NPiece is NBlack+NWhite,
    X is (NPiece-4) mod 2,
    (   X =:= 0 -> Color is 1;
    X =:= 1 -> Color is -1).

chooseMove4(AI,X,Y,Board):-
    minimax(AI,Board,[X,Y],3),!
    .

minimax(AI, Board, [X,Y], Depth) :-
    writeln('Enter minimax/4'),
    minimax(AI,Depth, Board, AI, _, [X,Y]).

/* minimax(+Depth, +Position, +Player, -BestValue, -BestMove) :-
      Chooses the BestMove from the from the current Position
      using the minimax algorithm searching Depth ply ahead.
      Player indicates if this move is by player (1) or opponent (-1).
*/

minimax(AI, 0, Board, _, Eval, Move) :-
      writeln(Move),
      writeln('Enter end of minimax/6'),
      ai3:eval(AI,Board,Eval).

minimax(AI,D, Board, CurrentPlayer, Eval, Move) :-
      writeln('Enter minimax/6'),
      D > 0,
      D1 is D - 1,
      findall([X,Y],getLegalMove(CurrentPlayer,X,Y,Board),MoveList),
      findBestMove(AI,MoveList, Board, D1, CurrentPlayer, -1000, nil, Eval, Move).

/* findBestMove(+AI,+Moves,+Position,+Depth,+Player,+Value0,+Move0,-BestValue,-BestMove)
      Chooses the Best move from the list of Moves from the current Position
      using the minimax algorithm searching Depth ply ahead.
      Player indicates if we are currently minimizing (-1) or maximizing (1).
      Move0 records the best move found so far and Value0 its value.
*/
findBestMove(_,[], _, _, _, Eval, BestMove, Eval, BestMove):-
      writeln(BestMove),
      writeln('Enter end of findBestMove').

findBestMove(AI,[[X,Y]|Moves],Board,D,CurrentPlayer,Eval0,Move0,BestValue,BestMove):-
      writeln([[X,Y]|Moves]),
      writeln('Enter findBestMove'),
      fillAndFlip(X,Y,CurrentPlayer,Board,NewBoard),
      Oppo is -CurrentPlayer,
      minimax(AI, D, NewBoard, Oppo, Eval, _OppoMove),
      ( (AI =:= CurrentPlayer,Eval > Eval0) -> findBestMove(AI,Moves,Board,D,CurrentPlayer, Eval, [X,Y],BestValue,BestMove);
      (AI =:= -CurrentPlayer,Eval < Eval0) -> findBestMove(AI,Moves,Board,D,CurrentPlayer, Eval, [X,Y],BestValue,BestMove);
      findBestMove(AI,Moves,Board,D,CurrentPlayer,Eval0,Move0,BestValue,BestMove)).
