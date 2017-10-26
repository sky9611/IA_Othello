# Prolog Othello
A declarative programming Othello with AI players

# Prerequisites

SWI Prolog

# Use

To launch the Human vs Human mode, execute pvp.pl and run

`play.`

To launch the Human vs Computer mode, execute pve.pl and run

`play.`


Format for moves:

`[1,a].`

# AI complexity
AI complexity ranges from 1 to 5,

AI 1 plays a random move 

AI 2 plays the move that captures the most pieces 

AI 3 plays the move with the best score, scores are evaluated dinamically 

AI 4 uses the same scoring system as AI 3 and uses MM decision rule 

AI 5 uses the same scoring system as AI 3, and Alpha Beta Pruning 

