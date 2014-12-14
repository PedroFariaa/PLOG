:-use_module(library(clpfd)).
:-use_module(library(lists)).


init:-
    write('WELCOME TO ARROWS WITH VOIDS'), nl,
    write('Please enter the board dimensions:'), nl,
    write('Introduce the length of the board'), nl,
    read(M),
    read(M),
    %board size check
    M < 10,
    M > 0, !,
    read(N),
    N < 10,
    N > 0, !,
    initializeBoard(Board, M, N),
    initializeArrows(Arrows, M, N),
    Sum is 0,
    restrictions(Sum, Board, Arrows),
    write('Funciona'), nl, nl,
    showAnswer(Sum, Board).

addToEnd([], E, [E]).
addToEnd([H|T], E, [H|C]):-
    addToEnd(T, E, C).

initializeBoard([], _, _).
initializeBoard(Board, M, N):-
    length(Lista, M),
    addToEnd(Board2, Lista, Board),
    N2 is N-1,
    initializeBoard(Board2, M, N2).

initializeArrows([], _, _).
initializeArrows(Arrows, M, N):-
    length(SE, N),
    domain(SE, 1, 3),
    addToEnd(Arrows, SE, Arrows),
    length(SD, N),
    domain(SD, 1, 3),
    addToEnd(Arrows, SD, Arrows),
    length(SC, M),
    domain(SC, 1, 3),
    addToEnd(Arrows, SC, Arrows),
    length(SB, M),
    domain(SB, 1, 3),
    addToEnd(Arrows, SB, Arrows),

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


restNumb([]).
restNumb([H|T]):-
        % 9 represents the empty space
        domain(H, 0, 9),
        all_distinct(H),
        restNumb(T).

        
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

appendBoard(_, []).
appendBoard(Vars, [H|T]):-
        append(Vars, H, Vars),
        appendBoard(Vars, T).

appendArrows(_, []).
appendArrows(Vars, [C|K]):-
        append(Vars, C, Vars),
        appendArrows(Vars, K).

appendVars(Vars, [H|T], [C|K]):-
        appendBoard(Vars, [H|T]),
        appendArrows(Vars, [C|K]).

arrowRestrictions([]).
arrowRestrictions([C|K]):-
        domain(C, 1, 3),
        arrowRestrictions(K).

restrictions(Sum, [H|T], [C|K]):- 
    restNumb([H|T]),
    transpose([H|T], BoardT),
    restNumb(BoardT),
    
    arrowRestrictions([C|K]),
    
    calcSum(Sum, [H|T]),
    
    %append para Vars
    appendVars(Vars, [H|T], [C|K]),
    
    % maximizing the sum
    labeling([maximize(Sum)], Vars).



/*
updateBoardHor([]).
updateBoardHor([H|T]):-
        H is H + 1,
        updateBoardHor(T).

updateBoardCima([], _, _).
updateBoardCima(Board, P, Q):-
        Q is Q + 1,
        P is P - 1,
        P > 0,
        Q < M,
        !,
        nth1(P, Board, Line),
        nth1(Q, Line, Elem),
        Elem is Elem + 1,
        updateBoardCima(Board, P, Q).
        

arrowCondInc([], [], _).
arrowCondInc([H|T], [C|K], P):-
        C is 1,
        !,
        P is P + 1,
        updateBoardHor(H),
        arrowCondInc(T, K, P).
        
arrowCondInc([H|T], [C|K], P):-
        C is 2,
        !,
        P is P + 1,
        Q is 0,
        updateBoardCima([H|T], P, Q),
        arrowCondInc(T, K, P).
        
arrowCondInc([H|T], [C|K], P):-
        C is 3,
        !,
        P is P + 1,
        updateBoardBaixo(H),
        arrowCondInc(T, K, P).
*/

