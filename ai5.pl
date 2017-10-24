:-module('ai5',[chooseMove5/4]).
:-use_module([library(apply),io,fill,end,utils,ai3]).

chooseMove5(AI,X,Y,Board):-
    alphaBeta(AI,Board,[X,Y],5),!
    .

alphaBeta(AI, Board, [X,Y], Depth) :-
    %writeln('Enter alphaBeta/4'),
    alphaBeta(AI,Depth, Board, AI, -1000, 1000, _, [X,Y]).

/* minimax(+Depth, +Position, +Player, -BestValue, -BestMove) :-
      Chooses the BestMove from the from the current Position
      using the minimax algorithm searching Depth ply ahead.
      Player indicates if this move is by player (1) or opponent (-1).
*/

alphaBeta(AI, 0, Board, _, _, _, Eval, _) :-
      %writeln('Enter end of alphaBeta/7'),
      ai3:eval(AI,Board,Eval)
      %displayBoard(Board),
      %writeln(Eval),
      %writeln('')
      .

alphaBeta(AI,D, Board, CurrentPlayer,Alpha, Beta, Eval, Move) :-
      %writeln('Enter alphaBeta/7'),
      D > 0,
      D1 is D - 1,
      findall([X,Y],getLegalMove(CurrentPlayer,X,Y,Board),MoveList),
      findBestMove(AI,MoveList, Board, D1, CurrentPlayer, Alpha, Beta, nil, Eval, Move).

/* findBestMove(+AI,+Moves,+Position,+Depth,+Player,+Value0,+Move0,-BestValue,-BestMove)
      Chooses the Best move from the list of Moves from the current Position
      using the minimax algorithm searching Depth ply ahead.
      Player indicates if we are currently minimizing (-1) or maximizing (1).
      Move0 records the best move found so far and Value0 its value.
*/
findBestMove(_,[], _, _, _, Eval, _, BestMove, Eval, BestMove).
      %writeln(BestMove),
      %writeln('Enter end of findBestMove').

findBestMove(AI,[[X,Y]|Moves],Board,D,CurrentPlayer,Alpha,Beta,Move0,BestEval,BestMove):-
      %writeln('Enter findBestMove'),
      %writeln([[X,Y]|Moves]),
      %write('Alpha: '),writeln(Alpha),
      %write('Beta: '),writeln(Beta),
      fillAndFlip(X,Y,CurrentPlayer,Board,NewBoard),
      Oppo is -CurrentPlayer,
      NewAlpha is -Beta,
      NewBeta is -Alpha,
      alphaBeta(AI, D, NewBoard, Oppo, NewAlpha, NewBeta, Eval, _OppoMove),
      %write('Eval: '),writeln(Eval),
      (   (AI =:= CurrentPlayer,Eval >= Beta) -> BestEval = Eval, BestMove = [X,Y];
      (AI =:= CurrentPlayer,Eval >= Alpha) -> findBestMove(AI,Moves,Board,D,CurrentPlayer,Eval,Beta,[X,Y],BestEval,BestMove);
      (AI =:= CurrentPlayer,Eval < Alpha ) -> findBestMove(AI,Moves,Board,D,CurrentPlayer,Alpha,Beta,Move0,BestEval,BestMove);
      (AI =:= -CurrentPlayer,Eval =< Alpha) -> BestEval = Eval, BestMove = [X,Y];
      (AI =:= -CurrentPlayer,Eval =< Beta) -> findBestMove(AI,Moves,Board,D,CurrentPlayer,Alpha,Eval,[X,Y],BestEval,BestMove);
      (AI =:= -CurrentPlayer,Eval > Beta)->findBestMove(AI,Moves,Board,D,CurrentPlayer,Alpha,Beta,Move0,BestEval,BestMove)).
