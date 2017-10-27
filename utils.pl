:-module('utils',[add_tail/3,getVal/4,isOnBoard/2,initialBoard/1,isBlack/1,isWhite/1,readInput/4,changePlayer/2,isCorner/2,isStarDangerous/2,isPlusDangerous/2,isEdge/2,count/2,dot2/3,sumList/2,listMax/2]).
:-use_module([io]).

add_tail([],X,[X]).
add_tail([H|T],X,[H|L]):-add_tail(T,X,L).


%obtenir l'element maximal d'une liste.
listMax(List, Max) :-
    sort(List, Sorted),
    reverse(Sorted, [Max|_]).
% il fait la somme des element de la list.
sumList([], 0).
sumList([H|T], Sum) :-
   sumList(T, Rest),
   Sum is H + Rest.
% produit de deux list.
dot([], [], 0).
dot([H1|T1], [H2|T2], Result) :-
  Prod is H1 * H2,
  dot(T1, T2, Remaining),
  Result is Prod + Remaining.

dot2([],[],0).
dot2([H1|T1], [H2|T2], Result):-
  dot(H1,H2,SUM),
  dot2(T1,T2,Remaining),
  Result is SUM + Remaining.

%compter le nombre de element dans la liste p.
count(P,Count) :-
  findall(1,P,L),
  length(L,Count).
% Obtenir la valeur du element avec coordones [x,y] sur le board
getVal(Board, X, Y, Val) :-
  nth0(X, Board, Column),
  nth0(Y, Column, Val).
% se assurer que les coordonnes se sont doans le Board.
isOnBoard(X,Y):-
  between(0,7,X),
  between(0,7,Y).

% Pour initialiser le Board.
initialBoard(Board):-
  Board = [[0,0,0,0,0,0,0,0],
           [0,0,0,0,0,0,0,0],
           [0,0,0,0,0,0,0,0],
           [0,0,0,1,-1,0,0,0],
           [0,0,0,-1,1,0,0,0],
           [0,0,0,0,0,0,0,0],
           [0,0,0,0,0,0,0,0],
           [0,0,0,0,0,0,0,0]].
% Donner la valeur -1(Black o croix) a la variable Player.
isBlack(Player):-
  Player = -1.
% Donner la valeur 1(White ou cercle) a la variable Player.
isWhite(Player):-
  Player = 1.

% C'est pour transformer notre Input de X de type(a,b...,h) a une
% coordonne Y du tableau(0,1,...,7).
transformeY(Al,N):-
  (Al == a -> N = 0;
   Al == b -> N = 1;
   Al == c -> N = 2;
   Al == d -> N = 3;
   Al == e -> N = 4;
   Al == f -> N = 5;
   Al == g -> N = 6;
   Al == h -> N = 7).

retransformeY(Al,N):-
  (N == 0 -> Al = a;
  N == 1 -> Al = b;
  N == 2 -> Al = c;
  N == 3 -> Al = d;
  N == 4 -> Al = e;
  N == 5 -> Al = f;
  N == 6 -> Al = g;
  N == 7 -> Al = h).

% C'est pour transformer notre Input de X de type(a,b...,h) a une
% coordonne X du tableau(0,1,....7).
transformeX(N,NN):-
  (N =:= 1->NN = 0;
   N =:= 2->NN = 1;
   N =:= 3->NN = 2;
   N =:= 4->NN = 3;
   N =:= 5->NN = 4;
   N =:= 6->NN = 5;
   N =:= 7->NN = 6;
   N =:= 8->NN = 7).

retransformeX(N,NN):-
  (NN =:= 0->N = 1;
   NN =:= 1->N = 2;
   NN =:= 2->N = 3;
   NN =:= 3->N = 4;
   NN =:= 4->N = 5;
   NN =:= 5->N = 6;
   NN =:= 6->N = 7;
   NN =:= 7->N = 8).

% Lire les inputs
readInput(Player,X,Y,Board):-
    write('play where?'),
    read([N,Al]),
    transformeX(N,XX),
    transformeY(Al,YY),
    (   io:getLegalMove(Player,XX,YY,Board)->X is XX, Y is YY, io:reportMove(Player,N,Al);
    writeln('Wrong Move!'),readInput(Player,X,Y,Board)).
    %il faut un input comme "[3,5]."
    %reportMove(Player,X,Y).


% Changer de joueur.
changePlayer(Player,NewPlayer):-
     (Player =:= 1->NewPlayer = -1;
     Player =:= -1->NewPlayer = 1).
% se sont de coordonnes du coin?
isCorner(X,Y):-
    X = 0, Y = 0;
    X = 0, Y = 7;
    X = 7, Y = 0;
    X = 7, Y = 7.
% les coordonnes [X,Y] se trouve sur le borde du tableau?
isEdge(X,Y):-
    X = 0,between(2,5,Y);
    Y = 0,between(2,5,X);
    X = 7,between(2,5,Y);
    Y = 7,between(2,5,X).

%star dangers are (2,b),(2,g),(7,b),(7,g)
isStarDangerous(X,Y):-
    X = 1, Y = 1;
    X = 1, Y = 6;
    X = 6, Y = 1;
    X = 6, Y = 6.

%Plus dangers are (1,b),(1,g),(2,a),(2,h),(7,a),(7,h),(8,b),(8,g)
isPlusDangerous(X,Y):-
    X = 0, Y = 1;
    X = 0, Y = 6;
    X = 1, Y = 0;
    X = 1, Y = 7;
    X = 6, Y = 0;
    X = 6, Y = 7;
    X = 7, Y = 1;
    X = 7, Y = 6.

%List de coordonnes de tous les star dangers.
starDangerousList(L):-
    findall([X,Y],isStarDangerous(X,Y),L).

