%smallestKset List K = write ("Sum\ti\tj\tsubList\n")

listSum([], 0).
listSum([Head | Tail], Sum) :-
    listSum(Tail, Restsum),
    Sum is Head + Restsum.

subListI(List, 0, List).
subListI([_ | Tail], I, Sub) :- 
    I>0,
    I2 is I-1,
    subListI(Tail, I2, Sub).

subListJ(_, 0, []).
subListJ([Head | Tail], I, [Head | Sub]) :- 
    I>0,
    I2 is I-1,
    subListJ(Tail, I2, Sub).

subList(List, I, J, Sublist) :-
    I >= 0,
    J >= I,
    subListI(List, I, Remaining),
    Len is J - I + 1,
    subListJ(Remaining, Len, Sublist).

iterI(List, [(Size, )]):-
    N is length(List),
    Size is listSum(List),


allSubLists([List], [(Size, I, J, Sub)]):-
    
    
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
