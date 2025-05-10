%smallestKset List K = write ("Sum\ti\tj\tsubList\n" ++ )

listSum([], 0).
listSum([Head | Tail], Sum) :-
    listSum(Tail, Restsum),
    Sum is Head + Restsum.

firstKTuples([], _, []).
firstKTuples(_, 0, []).
firstKTuples([Head | Tail], K, [Head | Result]) :-
    K2 is K -1,
    firstKTuples(Tail, K2, Result)

print_tuple((Sum, I, J, Sub)) :-
    format("~w\t~w\t~w\t~w~n", [Sum, I, J, Sub]).



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
