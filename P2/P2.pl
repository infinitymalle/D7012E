listSum([], 0).
listSum([Head | Tail], Sum) :-
    listSum(Tail, Restsum),
    Sum is Head + Restsum.

firstKTuples([], _, []).
firstKTuples(_, 0, []).
firstKTuples([Head | Tail], K, _) :-
    K > 0,
    print_tuple(Head),
    K2 is K -1,
    firstKTuples(Tail, K2, Result).
    
print_tuple((Sum, I, J, Sub)) :-
    I1 is I + 1,
    J1 is J + 1,
    format("~w\t~w\t~w\t~w~n", [Sum, I1, J1, Sub]).


smallestKset(List, K) :-
    allSubLists(List, Tuples),
    insertionSort(Tuples, Sorted),
    writeln("Sum\tI\tJ\tSublist"),
    firstKTuples(Sorted, K, _).


insertionSort([], []).
insertionSort([Head | Tail], Result) :- 
    insertionSort(Tail, SortedTail),
    insert(Head, SortedTail, Result).

% insert(X, [], [X]).
% insert(X, [Head | Tail], [X, Head | Tail]) :- 
%     X =< Head.
% insert(X, [Head | Tail], [Head | R]) :- 
%     X > Head, 
%     insert(X, Tail, R).

insert(X, [], [X]).
insert((SX, I1, J1, Sub1), [(SY, I2, J2, Sub2) | T], [(SX, I1, J1, Sub1), (SY, I2, J2, Sub2) | T]) :-
    SX =< SY.
insert((SX, I1, J1, Sub1), [(SY, I2, J2, Sub2) | T], [(SY, I2, J2, Sub2) | R]) :-
    SX > SY,
    insert((SX, I1, J1, Sub1), T, R).

allSubLists(List, Result) :-
    length(List, Len),
    iteri(List, 0, Len, Result).
    

iteri(_, I, Len, []) :- I >= Len, !.
iteri(List, I, Len, Result) :-
    I < Len,
    iterj(List, I, I, Len, Part1),
    I1 is I + 1,
    iteri(List, I1, Len, Part2),
    append(Part1, Part2, Result).

iterj(_, _, J, Len, []) :- J >= Len, !.
iterj(List, I, J, Len, [(Sum, I, J, Sub) | Rest]) :-
    J < Len,
    subList(List, I, J, Sub),
    listSum(Sub, Sum),
    J1 is J + 1,
    iterj(List, I, J1, Len, Rest).

% Drop first I elements from list
subListI(List, 0, List).
subListI([_ | Tail], I, Result) :-
    I > 0,
    I1 is I - 1,
    subListI(Tail, I1, Result).

% Take first N elements from list
subListJ(_, 0, []).
subListJ([Head | Tail], N, [Head | Result]) :-
    N > 0,
    N1 is N - 1,
    subListJ(Tail, N1, Result).
subListJ([], _, []). 

% Combine dropping and taking: sublist from I to J
subList(List, I, J, Sub) :-
    I >= 0,
    J >= I,
    subListI(List, I, Dropped),
    Len is J - I + 1,
    subListJ(Dropped, Len, Sub).


% consult("P2.pl").
% smallestKset([-1, 2, -3, 4, -5, 6, -7, 8, -9, 10, -11, 12, -13,    14, -15, 16, -17, 18, -19, 20, -21, 22, -23, 24, -25, 26,    -27, 28, -29, 30, -31, 32, -33, 34, -35, 36, -37, 38, -39,    40, -41, 42, -43, 44, -45, 46, -47, 48, -49, 50, -51, 52,    -53, 54, -55, 56, -57, 58, -59, 60, -61, 62, -63, 64, -65,    66, -67, 68, -69, 70, -71, 72, -73, 74, -75, 76, -77, 78,    -79, 80, -81, 82, -83, 84, -85, 86, -87, 88, -89, 90, -91,    92, -93, 94, -95, 96, -97, 98, -99, 100], 15). 
% smallestKset([24,-11,-34,42,-24,7,-19,21], 6).
% smallestKset([3,2,-4,3,2,-5,-2,2,3,-3,2,-5,6,-2,2,3], 8).
