:-module('ai1',[chooseMove1/4]).
:-use_module([library(lists),io,fill,end,utils,ai1]).

chooseMove1(AI,X,Y,Board):-
    repeat,random(0,7,X),random(0,7,Y),getLegalMove(AI,X,Y,Board),!.

