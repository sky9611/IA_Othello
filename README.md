# Prolog Othello
A declarative programming Othello with AI players

# Prerequisites

SWI Prolog

# Use

To launch the game, consult `othello.pl` and run `play.`.

Then follow the hints to choose the mode(Human vs Human or Human vs AI) and color.


Format for moves:

`[1,a].`

# AI complexity
AI complexity ranges from 1 to 5,

AI 1 plays a random move 

AI 2 plays the move that captures the most pieces 

AI 3 plays the move with the best score, scores are evaluated dinamically 

AI 4 uses the same scoring system as AI 3 and uses MM decision rule 

AI 5 uses the same scoring system as AI 3, and Alpha Beta Pruning 

# Comparing AIs
To make AIs play against each other we use `eve.pl`, run `playEvE.`. To change the AIs compared just change `ai1:chooseMove1`
into `aiN:chooseMoveN` to use the N AI.
