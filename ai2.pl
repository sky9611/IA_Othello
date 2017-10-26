:-module('ai2',[chooseMove2/4]).
:-use_module([library(lists),io,fill,end,utils,ai3]).



chooseMove2(AI,X,Y,Board):-
    findall([X,Y],getLegalMove(AI,X,Y,Board),MoveList),             %Cherche tous les coups possibles de l'ia, les stocke dans MoveList
    maplist(ai3:fillAndFlipTemp(Board,AI),MoveList,BoardList),      %Joue tous les coups possibles déterminés à l'étape précédente,stocke le résultat dans BoardList
    maplist(evalSimple(AI),BoardList,EvalList),                     %Evalue la situation sur les nouveaux boards, stocke les résultats dans EvalList
    listMax(EvalList,Max),                                          %Determine la situation la plus favorable
    %Teste les X et Y possibles, choisi le couple qui permet d'avoir la valeur maximum de evalSimple
    getLegalMove(AI,X,Y,Board),                                     
    fillAndFlip(X,Y,AI,Board,NewBoard),                             
    evalSimple(AI,NewBoard,Max),
    %Affiche le coup joué
    utils:retransformeX(N,X),
    utils:retransformeY(Al,Y),
    reportMove(AI,N,Al),
    !.

%Appelle countPlayer en changeant l'ordre des variables pour le maplist
evalSimple(Player,Board,E):-
    countPlayer(Board,Player,E).

%Compte les pièces d'un joueur
countPlayer(Board,Player,N):-
    nth0(0,Board,Line1),countPlayerLine(Line1,Player,N1),
    nth0(1,Board,Line2),countPlayerLine(Line2,Player,N2),
    nth0(2,Board,Line3),countPlayerLine(Line3,Player,N3),
    nth0(3,Board,Line4),countPlayerLine(Line4,Player,N4),
    nth0(4,Board,Line5),countPlayerLine(Line5,Player,N5),
    nth0(5,Board,Line6),countPlayerLine(Line6,Player,N6),
    nth0(6,Board,Line7),countPlayerLine(Line7,Player,N7),
    nth0(7,Board,Line8),countPlayerLine(Line8,Player,N8),
    N is (N1+N2+N3+N4+N5+N6+N7+N8).

countPlayerLine(List,Player,C):-
    end:count(List,Player,C).
