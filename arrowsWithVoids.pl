:-use_module(library(clpfd)).
:-use_module(library(lists)).


init(Board, M, N):-
    write("WELCOME TO ARROWS WITH VOIDS"),
    write("Please enter the board dimensions:"),
    write("Introduce the length of the board"),
    read(M),
    %board check
    M < 10, !,
    write("Introduce the height of the board"),
    read(N),
    N < 10, !,
    initializeBoard(Board, M, N).

/*
fillColumns ([_], _).
fillColumns ([A|T]], N):-
    length(A, N),
    domain(A, 0, 8),
    all_distinct(A),
    fillColumns(A, N).

initializeBoard(Board, M, N):-
    length(Board, M),
    domain(Board, 0, 8),
    fillColumns(Board, N).
*/

/*
showResults:-
    labeling([maximize(Sum)], Vars),
     showBoard(),
     showAnswer().

showBoard:-
      write('w').

showAnswer:-
      write('q').
*/        
 

first:-
    A1 is 0, A2 is 0, A3 is 0, B1 is 0, B2 is 0, B3 is 0, C1 is 0, C2 is 0, C3 is 0,
    SE1 is 0, SE2 is 0, SE3 is 0, SD1 is 0, SD2 is 0, SD3 is 0, SB1 is 0, SB2 is 0, SB3 is 0, SC1 is 0, SC2 is 0, SC3 is 0,
    restrictions.

rest([]).
rest([H|T]):-
        domain(H, 0, 8),
        all_distinct(H),
        rest(T).

restrictions:-
    Vars=[[A1, A2, A3], [B1, B2, B3], [C1, C2, C3]],
    Vars2 = [[SE1, SE2, SE3], [SD1, SD2, SD3], [SB1, SB2, SB3], [SC1, SC2, SC3]],
    % Numbers in Cells must belong to domain [0, 8]
    
    % domain(Vars2, 1, 3),
    % Distinct Numbers in lines and columns
    rest(Vars),
    transpose(Vars, NVars),
    rest(NVars),
    
    % maximizing the sum
    labeling([maximize(A1 + A2 + A3 + B1 + B2 + B3 + C1 + C2 + C3)], [A1, A2, A3, B1, B2, B3, C1, C2, C3, SE1, SE2, SE3, SD1, SD2, SD3, SB1, SB2, SB3, SC1, SC2, SC3]),
    
    Sum is A1 + A2 + A3 + B1 + B2 + B3 + C1 + C2 + C3,
    write(Sum).


/*
    Arrows must point inside the rectangle
    Verify comformaty between numbers and pointing arrows
    Unique arrow solution
*/