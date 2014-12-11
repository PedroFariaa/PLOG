:-use_module(library(clpfd)).
:-use_module(library(lists)).


init(Board, M, N):-
	write("WELCOME TO ARROWS WITH VOIDS"),
	write("Please enter the board dimensions:"),
	write("Introduce the length of the board"),
	read(M),
	write("Introduce the height of the board"),
	read(N),
	initializaBoard(Board, M, N).


fillColumns([], _).
fillColumns([A|T]], N):-
	length(A, N),
	domain(A, 0, 8),
	all_distinct(A),
	fillColumns(A, N).

initializaBoard(Board, M, N):-
	length(Board, M),
	domain(Board, 0, 8),
	fillColumns(Board, N).

/*
	maximizing the sum 
		labeling([maximize(Sum)], Vars).
	Distinct Numbers in lines and columns
		all_distinct([Array Column])
		all_distinct([Array Line])
	Numbers in Cells must belong to domain [0, 8]
		domain([ARRAYS WITH ALL CELLS OF THE BOARD], 0, 8).
	Board Dimension check
		M #< 10 #/\ M #>0
		N #< 10 #/\ N #>0
	One or less empty cells for edge

	Arrows must point inside the rectangle
	Verify comformaty between numbers and pointing arrows
	Unique arrow solution
*/

showResults:-
	labeling([maximize(Sum)], Vars),
	showBoard(),
	showAnswer().
