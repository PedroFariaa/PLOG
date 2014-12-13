:-use_module(library(clpfd)).
:-use_module(library(lists)).


init:-
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
fillColumns ([], _).
            
fillColumns ([H|T], N):-
    length(H, N),
    domain(H, 0, 8),
    all_distinct(H),
    fillColumns(H, N).
*/

initializeBoard(Board, M, N):-
    length(Board, M),
    domain(Board, 0, 8),
   % fillColumns(Board, N).

showLine([]).
showLine([H|T]):-
        H = 9,
        !,
        write('-'),
        showLine(T).

showLine([H|T]):-
        write(H),
        showLine(T).

showBoard([]).
showBoard([H|T]):-
        showLine(H),
        write(','),
        showBoard(T).  

showAnswer(Sum, [H|T]):-
      write('Sum: '), write(Sum), nl,
      showBoard([H|T]).           
 

first:-
    A1 is 0, A2 is 0, A3 is 0, B1 is 0, B2 is 0, B3 is 0, C1 is 0, C2 is 0, C3 is 0,
    SE1 is 0, SE2 is 0, SE3 is 0, SD1 is 0, SD2 is 0, SD3 is 0, SB1 is 0, SB2 is 0, SB3 is 0, SC1 is 0, SC2 is 0, SC3 is 0,
    restrictions.

rest([]).
rest([H|T]):-
        % 9 represents the empty space
        domain(H, 0, 9),
        all_distinct(H),
        rest(T).

updateBoardHor([]).
updateBoardHor([H|T]):-
        H is H + 1,
        updateBoardHor(T).

arrowConditions([], []).
arrowConditions([H|T], [C|K]):-
        C is 1,
        !,
        updateBoardHor(H),
        arrowConditions(T, K).
        
arrowConditions([H|T], [C|K]):-
        C is 2,
        !,
        updateBoardCima(H),
        arrowConditions(T, K).
        
arrowConditions([H|T], [C|K]):-
        C is 3,
        !,
        updateBoardBaixo(H),
        arrowConditions(T, K).

calcSum([], _).
calcSum(Sum, [H|T]):-
   H < 9,
   !,
   Sum #= Sum + H ,
   calcSum(Sum, T).

calcSum(Sum, [H|T]):-
   H >= 9,
   !,
   calcSum(Sum, T).

restrictions:-
    Vars=[[A1, A2, A3], [B1, B2, B3], [C1, C2, C3]],
    SE = [SE1, SE2, SE3],
    SD = [SD1, SD2, SD3],
    SB = [SB1, SB2, SB3],
    SC = [SC1, SC2, SC3],
    % Numbers in Cells must belong to domain [0, 8]
    
    % domain(Vars2, 1, 3),
    
    % Distinct Numbers in lines and columns
    rest(Vars),
    transpose(Vars, NVars),
    rest(NVars),

    arrowConditions(Vars, SE),
    arrowConditions(Vars, SD),
    arrowConditions(NVars, SC),
    arrowConditions(NVars, SB),
    
    % maximizing the sum
    labeling([maximize(Sum)], [A1, A2, A3, B1, B2, B3, C1, C2, C3, SE1, SE2, SE3, SD1, SD2, SD3, SB1, SB2, SB3, SC1, SC2, SC3]),
    
    Sum is 0,
    calcSum(Sum, Vars),

    showAnswer(Sum, A1, A2, A3, B1, B2, B3, C1, C2, C3).


/*
    Arrows must point inside the rectangle
    Verify comformaty between numbers and pointing arrows
    Unique arrow solution
*/