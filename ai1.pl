:-module('ai1',[chooseMove/4]).
:-use_module([library(lists),io,fill,end,utils,ai1]).

chooseMove(AI,X,Y,Board):-
    getLegalMove(AI,X,Y,Board),!.

