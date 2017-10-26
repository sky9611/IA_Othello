:-module('ai_utils',[eval/3]).
:-use_module([library(apply),end,utils,io]).


evalEdgeStable(Player,Board,E):-
    countPieceEdgeStable(Player,Board,NP),
    Oppo is -Player,
    countPieceEdgeStable(Oppo,Board,NO),
    E is 2.5*(NP-NO).

%calculer le nombre des pices stables sur les 4 cotes
countPieceEdgeStable(Player,Board,N):-
    (   isPieceEdgeStable(Player,0,0,Board)->N1 is 1;
    N1 is 0),(   isPieceEdgeStable(Player,0,1,Board)->N2 is N1+1;
    N2 is N1),(   isPieceEdgeStable(Player,0,2,Board)->N3 is N2+1;
    N3 is N2),(   isPieceEdgeStable(Player,0,3,Board)->N4 is N3+1;
    N4 is N3),(   isPieceEdgeStable(Player,0,4,Board)->N5 is N4+1;
    N5 is N4),(   isPieceEdgeStable(Player,0,5,Board)->N6 is N5+1;
    N6 is N5),(   isPieceEdgeStable(Player,0,6,Board)->N7 is N6+1;
    N7 is N6),(   isPieceEdgeStable(Player,0,7,Board)->N8 is N7+1;
    N8 is N7),(   isPieceEdgeStable(Player,7,0,Board)->N9 is N8+1;
    N9 is N8),(   isPieceEdgeStable(Player,7,1,Board)->N10 is N9+1;
    N10 is N9),(   isPieceEdgeStable(Player,7,2,Board)->N11 is N10+1;
    N11 is N10),(   isPieceEdgeStable(Player,7,3,Board)->N12 is N11+1;
    N12 is N11),(   isPieceEdgeStable(Player,7,4,Board)->N13 is N12+1;
    N13 is N12),(   isPieceEdgeStable(Player,7,5,Board)->N14 is N13+1;
    N14 is N13),(   isPieceEdgeStable(Player,7,6,Board)->N15 is N14+1;
    N15 is N14),(   isPieceEdgeStable(Player,7,7,Board)->N16 is N15+1;
    N16 is N15),(   isPieceEdgeStable(Player,1,0,Board)->N17 is N16+1;
    N17 is N16),(   isPieceEdgeStable(Player,2,0,Board)->N18 is N17+1;
    N18 is N17),(   isPieceEdgeStable(Player,3,0,Board)->N19 is N18+1;
    N19 is N18),(   isPieceEdgeStable(Player,4,0,Board)->N20 is N19+1;
    N20 is N19),(   isPieceEdgeStable(Player,5,0,Board)->N21 is N20+1;
    N21 is N20),(   isPieceEdgeStable(Player,6,0,Board)->N22 is N21+1;
    N22 is N21),(   isPieceEdgeStable(Player,1,7,Board)->N23 is N22+1;
    N23 is N22),(   isPieceEdgeStable(Player,2,7,Board)->N24 is N23+1;
    N24 is N23),(   isPieceEdgeStable(Player,3,7,Board)->N25 is N24+1;
    N25 is N24),(   isPieceEdgeStable(Player,4,7,Board)->N26 is N25+1;
    N26 is N25),(   isPieceEdgeStable(Player,5,7,Board)->N27 is N26+1;
    N27 is N26),(   isPieceEdgeStable(Player,6,7,Board)->N is N27+1;
    N is N27).

%isPieceEdgeStable(Player,0,0,Board):-getVal(Board,0,0,Player),!.
%isPieceEdgeStable(Player,7,0,Board):-getVal(Board,7,0,Player),!.
%isPieceEdgeStable(Player,0,7,Board):-getVal(Board,0,7,Player),!.
%isPieceEdgeStable(Player,7,7,Board):-getVal(Board,7,7,Player),!.

isPieceEdgeStable(Player,0,Y,Board):-
    %write('Juge if 0,'),
    %write(Y),
    %writeln(' is stable'),
    getVal(Board,0,Y,Player),
    (   end:isLineFull(Board,0,0)->!;
    (   (Y=:=0;Y=:=7)->!;
    YY is Y-1,
    YYY is Y+1,
    (   isLeftPieceSameColor(Player,0,YY,Board);
    isRightPieceSameColor(Player,0,YYY,Board))->!)).
isPieceEdgeStable(Player,7,Y,Board):-
    %write('Juge if 7,'),
    %write(Y),
    %writeln(' is stable'),
    getVal(Board,7,Y,Player),
    (   end:isLineFull(Board,7,0)->!;
    (   (Y=:=0;Y=:=7)->!;
    %writeln('aaa'),
    YY is Y-1,
    YYY is Y+1,
    %writeln('bbb'),
    (   isLeftPieceSameColor(Player,7,YY,Board);
    isRightPieceSameColor(Player,7,YYY,Board))->!)).
isPieceEdgeStable(Player,X,0,Board):-
    %write('Juge if '),
    %write(X),
    %writeln(',0 is stable'),
    getVal(Board,X,0,Player),
    (   end:isRowFull(Board,0,0)->!;
    (   (X=:=0;X=:=7)->!;
    %writeln('aaa'),
    XX is X-1,
    XXX is X+1,
    %writeln('bbb'),
    (   isUpPieceSameColor(Player,XX,0,Board);
    isDownPieceSameColor(Player,XXX,0,Board))->!)).
isPieceEdgeStable(Player,X,7,Board):-
    %write('Juge if '),
    %write(X),
    %writeln(',7 is stable'),
    getVal(Board,X,7,Player),
    (   end:isRowFull(Board,0,7)->!;
    (   (X=:=0;X=:=7)->!;
    %writeln('aaa'),
    XX is X-1,
    XXX is X+1,
    %writeln('bbb'),
    (   isUpPieceSameColor(Player,XX,7,Board);
    isDownPieceSameColor(Player,XXX,7,Board))->!)).




isLeftPieceSameColor(Player,0,0,Board):-
    getVal(Board,0,0,Player).
isLeftPieceSameColor(Player,7,0,Board):-
    getVal(Board,7,0,Player).
isLeftPieceSameColor(Player,0,Y, Board):-
    %write('Juge if 0,'),
    %write(Y),
    %writeln(' is stable'),
    getVal(Board,0,Y,Player),
    YY is Y-1,
    isLeftPieceSameColor(Player,0,YY,Board).
isLeftPieceSameColor(Player,7,Y, Board):-
    %write('Juge if 7,'),
    %write(Y),
    %writeln(' is stable'),
    getVal(Board,7,Y,Player),
    YY is Y-1,
    isLeftPieceSameColor(Player,7,YY,Board).

isRightPieceSameColor(Player,0,7,Board):-
    getVal(Board,0,7,Player).
isRightPieceSameColor(Player,7,7,Board):-
    getVal(Board,7,7,Player).
isRightPieceSameColor(Player,0,Y, Board):-
    %write('Juge if 0,'),
    %write(Y),
    %writeln(' is stable'),
    getVal(Board,0,Y,Player),
    YY is Y+1,
    isRightPieceSameColor(Player,0,YY,Board).
isRightPieceSameColor(Player,7,Y, Board):-
    %write('Juge if 7,'),
    %write(Y),
    %writeln(' is stable'),
    getVal(Board,7,Y,Player),
    YY is Y+1,
    isRightPieceSameColor(Player,7,YY,Board).

isUpPieceSameColor(Player,0,0,Board):-
    getVal(Board,0,0,Player).
isUpPieceSameColor(Player,0,7,Board):-
    getVal(Board,0,7,Player).
isUpPieceSameColor(Player,X,0, Board):-
    %writeln('Enter judge UP'),
    %write('Juge if '),
    %write(X),
    %writeln(',0 is stable'),
    getVal(Board,0,X,Player),
    XX is X-1,
    isUpPieceSameColor(Player,XX,0,Board).
isUpPieceSameColor(Player,X,7, Board):-
    getVal(Board,X,7,Player),
    XX is X-1,
    isUpPieceSameColor(Player,XX,7,Board).

isDownPieceSameColor(Player,7,0,Board):-getVal(Board,7,0,Player).
isDownPieceSameColor(Player,7,7,Board):-getVal(Board,7,7,Player).
isDownPieceSameColor(Player,X,0, Board):-
    getVal(Board,0,X,Player),
    XX is X+1,
    isDownPieceSameColor(Player,XX,0,Board).
isDownPieceSameColor(Player,X,7, Board):-
    getVal(Board,X,7,Player),
    XX is X+1,
    isDownPieceSameColor(Player,XX,7,Board).

frontierLength(Board,Player,[X,Y],L):-
    %write(X),write(','),writeln(Y),
    checkBorder(Player,X,Y,_,_,Board,L).
    %writeln(L).

getTotalFrontierLength(Player,Board,L):-
    findall([X,Y],getVal(Board,X,Y,0),R),
    %writeln(R),
    maplist(frontierLength(Board,Player),R,RL),
    sumList(RL,L).

checkBorder(Player,X,Y,-1,-1,Board,N):-
    XX is X-1,
    YY is Y-1,
    (   isOnBoard(XX,YY) -> getVal(Board,XX,YY,Player),N is 1,!).
checkBorder(Player,X,Y,-1,0,Board,N):-
    XX is X-1,
    YY is Y,
    (   isOnBoard(XX,YY) -> getVal(Board,XX,YY,Player),N is 1,!).
checkBorder(Player,X,Y,-1,1,Board,N):-
    XX is X-1,
    YY is Y+1,
    (   isOnBoard(XX,YY) -> getVal(Board,XX,YY,Player),N is 1,!).
checkBorder(Player,X,Y,0,1,Board,N):-
    XX is X,
    YY is Y+1,
    (   isOnBoard(XX,YY) -> getVal(Board,XX,YY,Player),N is 1,!).
checkBorder(Player,X,Y,1,1,Board,N):-
    XX is X+1,
    YY is Y+1,
    (   isOnBoard(XX,YY) -> getVal(Board,XX,YY,Player),N is 1,!).
checkBorder(Player,X,Y,1,0,Board,N):-
    XX is X+1,
    YY is Y,
    (   isOnBoard(XX,YY) -> getVal(Board,XX,YY,Player),N is 1,!).
checkBorder(Player,X,Y,1,-1,Board,N):-
    XX is X+1,
    YY is Y-1,
    (   isOnBoard(XX,YY) -> getVal(Board,XX,YY,Player),N is 1,!).
checkBorder(Player,X,Y,0,-1,Board,N):-
    XX is X,
    YY is Y-1,
    (   isOnBoard(XX,YY) -> getVal(Board,XX,YY,Player),N is 1,!).
checkBorder(_,_,_,_,_,_,N):-N is 0.

evalPotentialMobility(Player,Board,E):-
    getTotalFrontierLength(Player,Board,L1),
    changePlayer(Player,Oppo),
    getTotalFrontierLength(Oppo,Board,L2),
    (    L1 > L2 -> E is -100*L1/(L1+L2);
    L1 < L2 -> E is 100*L2/(L1+L2);
    L1 = L2 -> E is 0).

mobility(Player,Board,N):-
    count(getLegalMove(Player,_,_,Board),N).

evalMobility(Player,Board,E):-
    mobility(Player,Board,N1),
    changePlayer(Player,Oppo),
    mobility(Oppo,Board,N2),
    (   N2 =:= 0 -> E is 150;
    N1 =:= 0 -> E is -450;
    N1 > N2 -> E is 100*N1/(N1+N2);
    N1 < N2 -> E is -100*N2/(N1+N2);
    N1 = N2 -> E is 0).

isValueBoard(VBoard):-
    VBoard = [[20,-3,11, 8, 8,11,-3,20],
              [-3,-15,-4, 1, 1,-4,-15,-3],
              [11,-4, 2, 2, 2, 2,-4,11],
              [ 8, 1, 2, 2, 2, 2, 1, 8],
              [ 8, 1, 2, 2, 2, 2, 1, 8],
              [11,-4, 2, 2, 2, 2,-4,11],
              [-3,-15,-4, 1, 1,-4,-15,-3],
              [20,-3,11, 8, 8,11,-3,20]].

evalPosition(Player,Board,E):-
    isValueBoard(VBoard),
    dot2(Board,VBoard,R),
    (   Player =:= -1 -> E is -R;
    E is R).

evalCorner(Player,Board,E):-
    getVal(Board,0,0,V1),
    getVal(Board,0,7,V2),
    getVal(Board,7,0,V3),
    getVal(Board,7,7,V4),
    R is 25*(V1+V2+V3+V4),
    (   Player =:= -1 -> E is -R;
    E is R).

evalPlusPosition(Player,Board,E):-
    (   end:isLineOnlyPiece(Player,Board,0,0,1)->getVal(Board,0,1,VP1);VP1 is 0),
    (end:isLineOnlyPiece(Player,Board,0,0,1)->getVal(Board,0,6,VP2);VP2 is 0),
    (end:isRowOnlyPiece(Player,Board,0,0,1)->getVal(Board,1,0,VP3);VP3 is 0),
    (end:isRowOnlyPiece(Player,Board,0,7,1)->getVal(Board,1,7,VP4);VP4 is 0),
    (end:isRowOnlyPiece(Player,Board,0,0,1)->getVal(Board,6,0,VP5);VP5 is 0),
    (end:isRowOnlyPiece(Player,Board,0,7,1)->getVal(Board,6,7,VP6);VP6 is 0),
    (end:isLineOnlyPiece(Player,Board,7,0,1)->getVal(Board,7,1,VP7);VP7 is 0),
    (end:isLineOnlyPiece(Player,Board,7,0,1)->getVal(Board,7,6,VP8);VP8 is 0),
    R is 25*(VP1+VP2+VP3+VP4+VP5+VP6+VP7+VP8),
    (   Player =:= -1 -> E is -R;
    E is R).

evalDanger(Player,Board,E):-
    getVal(Board,0,1,VP1),
    getVal(Board,0,6,VP2),
    getVal(Board,1,0,VP3),
    getVal(Board,1,7,VP4),
    getVal(Board,6,0,VP5),
    getVal(Board,6,7,VP6),
    getVal(Board,7,1,VP7),
    getVal(Board,7,6,VP8),
    getVal(Board,1,1,VS1),
    getVal(Board,1,6,VS2),
    getVal(Board,6,1,VS3),
    getVal(Board,6,6,VS4),
    R is -12.5*(VP1+VP2+VP3+VP4+VP5+VP6+VP7+VP8+2*VS1+2*VS2+2*VS3+2*VS4),
    (   Player =:= -1 -> E is -R;
    E is R).

evalBWRate(Player,Board,E):-
    countPiece(Board,NBlack,NWhite),
    (   (Player =:= -1,NBlack > NWhite) -> E = 100*NBlack/(NBlack+NWhite);
    (Player =:= -1,NBlack < NWhite) -> E = -100*NWhite/(NBlack+NWhite);
    (Player =:= 1,NWhite > NBlack) -> E = 100*NWhite/(NBlack+NWhite);
    (Player =:= 1,NWhite < NBlack) -> E = -100*NBlack/(NBlack+NWhite);
    (NBlack =:= NWhite) -> E = 0).

countTurn(Board,N):-
    countPiece(Board,NBlack,NWhite),
    N is (NBlack+NWhite-4)/2.

eval(Player,Board,E):-
    countTurn(Board,T),
    Turn is round(T),
    evalPosition(Player,Board,PositionEval),
    evalCorner(Player,Board,CornerEval),
    evalDanger(Player,Board,DangerEval),
    evalBWRate(Player,Board,RateEval),
    evalMobility(Player,Board,MobilityEval),
    evalPotentialMobility(Player,Board,PotentialMobilityEval),
    evalEdgeStable(Player,Board,EdgeStableEval),
    evalPlusPosition(Player,Board,PlusPositionEval),
    (         Turn > 23 -> E is 0.2*RateEval+0.6*(DangerEval+PlusPositionEval)+8*CornerEval+0.24*MobilityEval+0.01*PositionEval+0.24*PotentialMobilityEval+6*EdgeStableEval;
    between(21,23,Turn) -> E is 0.15*RateEval+1.2*(DangerEval+PlusPositionEval)+8*CornerEval+0.24*MobilityEval+0.01*PositionEval+0.24*PotentialMobilityEval+6*EdgeStableEval;
    between(18,21,Turn) -> E is 0.12*RateEval+4.5*(DangerEval+PlusPositionEval)+8*CornerEval+0.45*MobilityEval+0.04*PositionEval+0.66*PotentialMobilityEval+5*EdgeStableEval;
    between(14,18,Turn) -> E is 0.08*RateEval+8.0*(DangerEval+PlusPositionEval)+9.5*CornerEval+0.59*MobilityEval+0.09*PositionEval+0.89*PotentialMobilityEval+4*EdgeStableEval;
    between( 8,14,Turn) -> E is 0.06*RateEval+9.5*(DangerEval+PlusPositionEval)+9.5*CornerEval+(0.71-Turn/60)+0.12*PositionEval+1.02-Turn/50+4*EdgeStableEval;
    between( 0, 8,Turn) -> E is 0.04*RateEval+9.0*(DangerEval+PlusPositionEval)+7.5*CornerEval+(0.82-Turn/60)+0.2*PositionEval+1.27-Turn/50+0*EdgeStableEval).
