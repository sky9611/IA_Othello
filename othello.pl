:-module('othello',[play/0]).
:-use_module([pvp,pve]).

play :-
    io:welcome,
    writeln('Select mode(1 for Human Vs. Human, 2 for Human Vs. AI): '),
    read(N),
    (   N=:=1->playPvP,!;
    playPvE).
