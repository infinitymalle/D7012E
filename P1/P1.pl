% The state represents the place of the items state(robot, steelkey, brasskey, package)
% invalid state
invalid(state(_, robot, robot, robot)).

% Move r1 -> r2
move(state(room1, robot, X, Y), 
    move(room1 -> room2),
    state(room2, robot, X, Y)).

% Move r2 -> r1
move(state(room2, robot, X, Y), 
    move(room2 -> room1),
    state(room1, robot, X, Y)).

% Move r1 -> r3
move(state(room1, X, robot, Y),
    move(room1 -> room3),
    state(room3, X, robot, Y)).

% Move r3 -> r1
move(state(room3, X, robot, Y), 
    move(room3 -> room1),
    state(room1, X, robot, Y)).

% pickup steelkey
move(state(R, R, X, Y), 
    pickup(steelkey),
    state(R, robot, X, Y)).
% pickup brasskey 
move(state(R, X, R, Y), 
    pickup(brasskey),
    state(R, X, robot, Y)).
% pickup Package
move(state(R, X, Y, R), 
    pickup(package),
    state(R, X, Y, robot)).

% Drop steelkey
move(state(R, robot, X, Y), 
    drop(steelkey),
    state(R, R, X, Y)).
% Drop brasskey 
move(state(R, X, robot, Y), 
    drop(brasskey),
    state(R, X, R, Y)).
% Drop Package
move(state(R, X, Y, robot), 
    drop(package),
    state(R, X, Y, R)).



fetchpackage(state(room2, _, _, room2), N, [done|[]] ).
fetchpackage( State1, N, [Move| TRace2])  :-
    N > 0,
    move( State1, Move, State2),
    \+ invalid(State2),
    N1 is N - 1,
    fetchpackage( State2, N1,TRace2). 



solveR(State, N, TRace) :- 
    fetchpackage(State, N, TRace).


%solveR(state(room1, room1, room2, room3), 12, TRace).
%solveR(state(room1, room3, room2, room3), 12, TRace).
%solveR(state(room1, room3, room1, room3), 12, TRace).
%?- set_prolog_flag(answer_write_options, [max_depth(0)]).
