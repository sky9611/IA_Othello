:-module('ai5',[chooseMove5/4]).
:-use_module([io,fill,ai_utils]).

chooseMove5(AI,X,Y,Board):-
    alphaBeta(AI,Board,[X,Y],3),
    utils:retransformeX(N,X),
    utils:retransformeY(Al,Y),
    reportMove(AI,N,Al),!
    .

alphaBeta(AI, Board, [X,Y], Depth) :-
    %writeln('Enter alphaBeta/4'),
    alphaBeta(AI,Depth, Board, AI, -1000, 1000, _, [X,Y]).


alphaBeta(AI, 0, Board, _, _, _, Eval, _) :-
      %writeln('Enter end of alphaBeta/7'),
      ai_utils:eval(AI,Board,Eval)
      %eval(AI,Board,Eval)
      %displayBoard(Board),
      %writeln(Eval),
      %writeln('')
      .

alphaBeta(AI,D, Board, CurrentPlayer,Alpha, Beta, Eval, Move) :-
      D > 0,
      D1 is D - 1,
      findall([X,Y],getLegalMove(CurrentPlayer,X,Y,Board),MoveList),
      delete(MoveList,[1,1],List1),
      delete(List1,[1,6],List2),
      delete(List2,[6,1],List3),
      delete(List3,[6,6],NewMoveList),
      length(NewMoveList,L),
      (   L =:= 0 -> findBestMove(AI,MoveList, Board, D1, CurrentPlayer, Alpha, Beta, nil, Eval, Move);
      findBestMove(AI,NewMoveList, Board, D1, CurrentPlayer, Alpha, Beta, nil, Eval, Move)).

/* findBestMove(+AI,+Moves,+Position,+Depth,+CurrentPlayer,Alpha,Beta,+Move0,-BestValue,-BestMove)
      Chooses the Best move from the list of Moves from the current Position
      using the minimax algorithm searching Depth ply ahead.
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
