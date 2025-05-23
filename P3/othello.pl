/* ------------------------------------------------------- */
%
%    D7012E Declarative languages
%    Luleå University of Technology
%
%    Student full name: Malkolm Lundkvist
%    Student user id  : amouli-0
%
/* ------------------------------------------------------- */



%do not chagne the follwoing line!
%:- ensure_loaded('play.pl').


% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
% /* ------------------------------------------------------ */
%               IMPORTANT! PLEASE READ THIS SUMMARY:
%       This files gives you some useful helpers (set &get).
%       Your job is to implement several predicates using
%       these helpers. Feel free to add your own helpers if
%       needed, as long as you write comments (documentation)
%       for all of them. 
%
%       Implement the following predicates at their designated
%       space in this file. You might like to have a look at
%       the file  ttt.pl  to see how the implementations is
%       done for game tic-tac-toe.
%
%          * initialize(InitialState,InitialPlyr).
%          * winner(State,Plyr) 
%          * tie(State)
%          * terminal(State) 
%          * moves(Plyr,State,MvList)
%          * nextState(Plyr,Move,State,NewState,NextPlyr)
%          * validmove(Plyr,State,Proposed)
%          * h(State,Val)  (see question 2 in the handout)
%          * lowerBound(B)
%          * upperBound(B)
% /* ------------------------------------------------------ */



directions(
	[[0, -1], %North
	[1, -1], %NorthEast
	[1, 0],  % East
	[1, 1],  % SouthEast
	[0, 1],  % South
	[-1, 1],  % SoutWest
	[-1, 0],  % West
	[-1, -1]]). % NorthWest


% /* ------------------------------------------------------ */

% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
% We use the following State Representation: 
% [Row0, Row1 ... Rown] (ours is 6x6 so n = 5 ).
% each Rowi is a LIST of 6 elements '.' or '1' or '2' as follows: 
%    . means the position is  empty
%    1 means player one has a stone in this position
%    2 means player two has a stone in this position. 


% DO NOT CHANGE THE COMMENT BELOW.
%
% given helper: Inital state of the board

initBoard([ [.,.,.,.,.,.], 
            [.,.,.,.,.,.],
	    	[.,.,1,2,.,.], 
	    	[.,.,2,1,.,.], 
        	[.,.,.,.,.,.], 
	    	[.,.,.,.,.,.] ]).

%initialize(InitialState, 1) :- rndBoardXYZ(InitialState).


initialize(InitialState, 1) :- initBoard(InitialState).


% initialize(InitialState,1):- flipRLtop(InitialState). %%Funkar
% initialize(InitialState,1):- flipLRbottom(InitialState). %Funkar
% initialize(InitialState,1):- flipTBleft(InitialState).%Funkar
% initialize(InitialState,1):- flipBTright(InitialState). %Funkar
% initialize(InitialState,1):- flipDiagULtoLR(InitialState). %Funkar
% initialize(InitialState,1):- flipDiagURtoLL(InitialState). %Funkar
% initialize(InitialState,1):- noMovesNoFlipsA(InitialState). %Funkar
% initialize(InitialState,1):- noMovesNoFlipsB(InitialState). %Funkar

% initialize(InitialState,1):- flipLRonly1(InitialState). %Funkar
% initialize(InitialState,1):- flipAll8Dirs1(InitialState). %Funkar
% initialize(InitialState,1):- flipAll8Dirs2(InitialState). %Funkar
% initialize(InitialState,1):- tieInTwoMovesFullBoard(InitialState). %Funkar
% initialize(InitialState,1):- tieFourEmptyInCorners(InitialState). %Funkar
% initialize(InitialState,1):- tieFourEmptyOnBorders(InitialState). %Funkar

% initialize(InitialState,1):- tieFourEmptyOnly1canMove(InitialState). %Funkar
% initialize(InitialState,1):- tie30emptyOnly1canMove(InitialState). %Funkar
% initialize(InitialState,1):- tie30emptyOnly2canMove(InitialState). %Funkar
% initialize(InitialState,1):- winInTwoMovesFullBoard(InitialState). %Funkar
% initialize(InitialState,1):- onlyTwos(InitialState). %Funkar
% initialize(InitialState,1):- onlyOnes(InitialState). %Funkar
% initialize(InitialState,1):- forcing2toDoNullMove(InitialState). %Funkar
% initialize(InitialState,1):- forcing1toDoNullMoves(InitialState). %Funkar

% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
%%%%%%%%%%%%%%%%%% IMPLEMENT: initialize(...)%%%%%%%%%%%%%%%%%%%%%
%%% Using initBoard define initialize(InitialState,InitialPlyr). 
%%%  holds iff InitialState is the initial state and 
%%%  InitialPlyr is the player who moves first. 

%initialize(InitialState, 1) :- initBoard(InitialState).



% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%winner(...)%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% define winner(State,Plyr) here.  
%     - returns winning player if State is a terminal position and
%     Plyr has a higher score than the other player 

winner(State, Plyr) :- 
	terminal(State), 
	winnerIs(State, Plyr). 
	%showState(State).

% ; binds harder?
winnerIs(State, Plyr) :-
	%writeln('starting function winnerIs'),
	 (
		(setof(Position, get(State, Position, 1),ListPlyr1)
	 -> length(ListPlyr1, Plyr1Score)
		; 
	 Plyr1Score is 0)
	),
	(
		(setof(Position, get(State, Position, 2),ListPlyr2)-> 
		length(ListPlyr2, Plyr2Score)
		; 
		%writeln('why are u running2'),
		Plyr2Score is 0)
	),
	((Plyr1Score < Plyr2Score) -> Plyr = 1 ; (Plyr2Score < Plyr1Score) -> Plyr = 2).
	%writeln(Plyr1Score),
	%writeln(Plyr2Score). 


% Just a not function
notFunc(Statment) :- 
	Statment, 
	!, 
	fail.

notFunc(Statment). 



% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%tie(...)%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% define tie(State) here. 
%    - true if terminal State is a "tie" (no winner) 

tie(State) :- 
	terminal(State),
	\+ (winnerIs(State, 1), 
		winnerIs(State, 2)).


% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%terminal(...)%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% define terminal(State). 
%   - true if State is a terminal   

terminal(State) :- 
	%write('starting terminal*'),
    (moves(1, State, MvList1), MvList1 == [n]),
	%writeln('mvlist1: '),
	%writeln(MvList1),
    (moves(2, State, MvList2), MvList2 == [n]).
	%writeln(MvList2).



% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%showState(State)%%%%%%%%%%%%%%%%%%%%%%%%%%
%% given helper. DO NOT  change this. It's used by play.pl
%%

showState( G ) :- 
	printRows( G ). 
 
printRows( [] ). 
printRows( [H|L] ) :- 
	printList(H),
	nl,
	printRows(L). 

printList([]).
printList([H | L]) :-
	write(H),
	write(' '),
	printList(L).

% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%moves(Plyr,State,MvList)%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
%% define moves(Plyr,State,MvList). 
%   - returns list MvList of all legal moves Plyr can make in State
%

moves(Plyr, State, Moves) :-
	%writeln('starting function moves'),
	setof([X, Y], validmove(Plyr, State, [X, Y]), Moves).
	%writeln(Moves),
	%writeln('trying to format'),
    %format("Player ~w has moves: ~w~n", [Plyr, Moves]).
	%writeln('succeded to format').

moves(Plyr, State, [n]) :-
	%writeln('moves with [n]'),
	\+ setof([X,Y], validmove(Plyr, State, [X, Y]), Moves).




% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
%%%%%%%%%%%%%%nextState(Plyr,Move,State,NewState,NextPlyr)%%%%%%%%%%%%%%%%%%%%
%% 
%% define nextState(Plyr,Move,State,NewState,NextPlyr). 
%   - given that Plyr makes Move in State, it determines NewState (i.e. the next 
%     state) and NextPlayer (i.e. the next player who will move).
%
nextState(Plyr, n, State, State, NextPlyr) :-
	opponent(Plyr, NextPlyr).
nextState(Plyr, [n], State, State, NextPlyr) :-
	opponent(Plyr, NextPlyr).

nextState(Plyr, Move, State, NewState, NextPlyr) :-
	%writeln('starting function nextState'),
	%writeln(Plyr),
	%writeln(Move),
	%showState(State),
	validmove(Plyr, State, Move), 
	%set(State, NewState, Move, Plyr), 
	flipAllDirection(Plyr, State, Move, NewState),
	%showState(NewState),
	opponent(Plyr, NextPlyr).

flipAllDirection(Plyr, State, Move, FinalState) :-
	%writeln('Trying to flip now: '),
    opponent(Plyr, Opponent),
    testFlip(Plyr, State, Opponent, Move, [0, -1], S1),    % North
    testFlip(Plyr, S1,   Opponent, Move, [1, -1], S2),     % NorthEast
    testFlip(Plyr, S2,   Opponent, Move, [1, 0], S3),      % East
    testFlip(Plyr, S3,   Opponent, Move, [1, 1], S4),      % SouthEast
    testFlip(Plyr, S4,   Opponent, Move, [0, 1], S5),      % South
    testFlip(Plyr, S5,   Opponent, Move, [-1, 1], S6),     % SouthWest
    testFlip(Plyr, S6,   Opponent, Move, [-1, 0], S7),     % West
    testFlip(Plyr, S7,   Opponent, Move, [-1, -1], FinalState).  % NorthWest
	%writeln('Done flipping: '), 
	%showState(FinalState).

testFlip(Plyr, State, Opponent, [X, Y], [DirX, DirY], NewState) :-
	%write('starting function testFlip'),
	(
		(	checkDir(Plyr, State, Opponent, [X, Y], [DirX, DirY]),
			flipDir(Plyr, State, Opponent, [X, Y], [DirX, DirY], TempState),
			set(TempState, NewState, [X, Y], Plyr))

		;
			NewState = State
	).


flipDir(Plyr, State, Opponent, [X, Y], [DirX, DirY], NewState) :-
	%write('starting function flipDir \n'),
	X1 is X + DirX,
	Y1 is Y + DirY,
	inBounds(X1, Y1),
	(
		(get(State, [X1, Y1], Plyr),
		NewState = State)
		;
		(%writeln(flip(X1, Y1)),
		set(State, TempState, [X1, Y1], Plyr),
		flipDir(Plyr, TempState, Opponent, [X1, Y1], [DirX, DirY], NewState))
		
	).


opponent(Plyr, Opponent) :-
	%write('starting function opponent \n'),
	(Plyr == 1 -> Opponent is 2 ; Opponent is 1). 


% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%validmove(Plyr,State,Proposed)%%%%%%%%%%%%%%%%%%%%
%% 
%% define validmove(Plyr,State,Proposed). 
%   - true if Proposed move by Plyr is valid at State.

validmove(Plyr, State, Proposed) :- 
	%write('starting function validmove \n'),
	opponent(Plyr, Opponent), 
	get(State, Proposed, '.'),
	directions(Dirs),
	member([DirX, DirY], Dirs),
	checkDirection(Plyr, State,  Opponent, Proposed, [DirX, DirY]).
% !,.
	%writeln('finishing validmove'), !.
validmove(Plyr, State, [n]) :-
	moves(Plyr, State, [n]).


checkDirection(Plyr, State,  Opponent, [X, Y], [DirX, DirY]) :-
	%write('starting function checkDirection \n'),
	X1 is X + DirX,
	Y1 is Y + DirY,
	get(State, [X1, Y1], Opponent), 
	checkDir(Plyr, State,  Opponent, [X1, Y1], [DirX, DirY]).
	%checkDirection(Plyr, State, Opponent, [X, Y], [DirX, DirY]).
	%write('finishing checkdirections \n'). 

checkDir(Plyr, State, Opponent, [X, Y], [DirX, DirY]) :-
	%write('starting function chekcDir \n'),
	X1 is X + DirX,
	Y1 is Y + DirY,
	inBounds(X, Y),
	(
		get(State, [X1, Y1], Plyr) 
	;
		(get(State, [X1, Y1], Opponent),
		checkDir(Plyr, State, Opponent, [X1, Y1], [DirX, DirY]))
	).
	%write('finishing checkdir \n'). 

inBounds(X, Y) :-
	number(X), number(Y),
	X >= 0, X =< 5,
    Y >= 0, Y =< 5.


% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%h(State,Val)%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
%% define h(State,Val). 
%   - given State, returns heuristic Val of that state
%   - larger values are good for Max, smaller values are good for Min
%   NOTE1. If State is terminal h should return its true value.
%   NOTE2. If State is not terminal h should be an estimate of
%          the value of state (see handout on ideas about
%          good heuristics.

h(State, Val) :-
	%write('starting function h'),
	terminal(State), 
	(
		winnerIs(State, 2) -> Val is 100
		;
		winnerIs(State, 1) -> Val is -100
		;
		tie(State) -> Val is 0
	).
h(State, 0):- \+(terminal(State)).
	


% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%lowerBound(B)%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
%% define lowerBound(B).  
%   - returns a value B that is less than the actual or heuristic value
%     of all states.


lowerBound(-1001).


% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%upperBound(B)%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
%% define upperBound(B). 
%   - returns a value B that is greater than the actual or heuristic value
%     of all states.


upperBound(1001).


% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                       %
%                                                                       %
%                Given   UTILITIES                                      %
%                   do NOT change these!                                %
%                                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get(Board, Point, Element)
%    : get the contents of the board at position column X and row Y
% set(Board, NewBoard, [X, Y], Value):
%    : set Value at column X row Y in Board and bind resulting grid to NewBoard
%
% The origin of the board is in the upper left corner with an index of
% [0,0], the upper right hand corner has index [5,0], the lower left
% hand corner has index [0,5], the lower right hand corner has index
% [5,5] (on a 6x6 board).
%
% Example
% ?- initBoard(B), showState(B), get(B, [2,3], Value). 
%. . . . . . 
%. . . . . . 
%. . 1 2 . . 
%. . 2 1 . . 
%. . . . . . 
%. . . . . . 
%
%B = [['.', '.', '.', '.', '.', '.'], ['.', '.', '.', '.', '.', '.'], 
%     ['.', '.', 1, 2, '.', '.'], ['.', '.', 2, 1, '.'|...], 
%     ['.', '.', '.', '.'|...], ['.', '.', '.'|...]]
%Value = 2 
%Yes
%?- 
%
% Setting values on the board
% ?- initBoard(B),  showState(B),set(B, NB1, [2,4], 1),
%         set(NB1, NB2, [2,3], 1),  showState(NB2). 
%
% . . . . . . 
% . . . . . . 
% . . 1 2 . . 
% . . 2 1 . . 
% . . . . . . 
% . . . . . .
% 
% . . . . . . 
% . . . . . . 
% . . 1 2 . . 
% . . 1 1 . . 
% . . 1 . . . 
% . . . . . .
%
%B = [['.', '.', '.', '.', '.', '.'], ['.', '.', '.', '.', '.', '.'], ['.', '.', 
%1, 2, '.', '.'], ['.', '.', 2, 1, '.'|...], ['.', '.', '.', '.'|...], ['.', '.',
% '.'|...]]
%NB1 = [['.', '.', '.', '.', '.', '.'], ['.', '.', '.', '.', '.', '.'], ['.', '.'
%, 1, 2, '.', '.'], ['.', '.', 2, 1, '.'|...], ['.', '.', 1, '.'|...], ['.', '.
%', '.'|...]]
%NB2 = [['.', '.', '.', '.', '.', '.'], ['.', '.', '.', '.', '.', '.'], ['.', '.'
%, 1, 2, '.', '.'], ['.', '.', 1, 1, '.'|...], ['.', '.', 1, '.'|...], ['.', 
%'.', '.'|...]]

% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
% get(Board, Point, Element): get the value of the board at position
% column X and row Y (indexing starts at 0).
% Do not change get:

get( Board, [X, Y], Value) :- 
	nth0( Y, Board, ListY), 
	nth0( X, ListY, Value).

% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
% set( Board, NewBoard, [X, Y], Value): set the value of the board at position
% column X and row Y to Value (indexing starts at 0). Returns the new board as
% NewBoard. Do not change set:

set( [Row|RestRows], [NewRow|RestRows], [X, 0], Value) :-
    setInList(Row, NewRow, X, Value). 

set( [Row|RestRows], [Row|NewRestRows], [X, Y], Value) :-
    Y > 0, 
    Y1 is Y-1, 
    set( RestRows, NewRestRows, [X, Y1], Value). 

% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
% setInList( List, NewList, Index, Value): given helper to set. Do not
% change setInList:

setInList( [_|RestList], [Value|RestList], 0, Value). 

setInList( [Element|RestList], [Element|NewRestList], Index, Value) :- 
	Index > 0, 
	Index1 is Index-1, 
	setInList( RestList, NewRestList, Index1, Value). 
 
