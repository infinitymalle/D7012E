conc([],L,L).
conc([X|L1],L2,[X|L3]):- conc(L1,L2,L3).

del(X,[X|L],L).
del(X,[A|L],[A|L1]):- del(X,L,L1).


createLayer(0, _, []).
createLayer(Width, Pile, [OneBrick | Rest]) :-
	member(OneBrick, Pile), 
	Width1 is Width - OneBrick, 
    del(OneBrick,Pile, Pile2),
	createLayer(Width1, Pile2, Rest).

niceLayer(Width, Pile, Bricks) :-
    createLayer(Width, Pile, Bricks),
    helper1(Bricks).

helper1([]).
helper1([Head | Tail]) :- 
    \+ member(Head, Tail),
    helper(Tail).





