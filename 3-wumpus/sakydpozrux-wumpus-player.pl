
act(Action, Knowledge):-
  not(gameStarted),
  assert(gameStarted),

  worldSize(X, Y),
  assert(myWorldSize(X,Y)),
  assert(myPosition(1, 1, east)),
  assert(visited([f(1,1)])),
  assert(toVisit([])),
  assert(haveGold(0)),
  assert(haveArrow(1)),
  assert(wumpus(alive)),
  Path = [],
  assert(path(Path)),

  act(Action, Knowledge).

act(Action, Knowledge) :- pre_process(Action, Knowledge).
act(Action, Knowledge) :- exit(Action, Knowledge).
act(Action, Knowledge) :- get_gold(Action, Knowledge).
act(Action, Knowledge) :- find_new_path(Action, Knowledge).
act(Action, Knowledge) :- follow_path(Action, Knowledge).

pre_process(Action, Knowledge) :-
  not(pre_process),
  assert(pre_process),

  visited(V),
  checkVisited(NewV),
  retract(visited(V)),
  assert(visited(NewV)),

  toVisit(TV),
  checkFieldsToVisit(NewTV),

  act(Action, Knowledge).


checkVisited(NewV) :-
  visited(V),
  myPosition(X,Y,_),
  (member(f(X,Y),V), NewV = V ;
  NewV = [f(X,Y)|V]).

select2(A, [A|B], B).
select2(A, [C|B], [C|B2] ) :-
  select2(A, B, B2).
checkFieldsToVisit(NewTV) :-
  toVisit(TV),
  myPosition(X,Y,_),
  (select2(f(X,Y),TV,TV2) ; TV2 = TV),
  retract(toVisit(TV)),
  assert(toVisit(TV2)),

  \+breeze, (\+stench ; wumpus(dead)),
  X1 is X-1, X2 is X+1, Y1 is Y-1, Y2 is Y+1,
  addFTV( [f(X1,Y),f(X2,Y),f(X,Y1),f(X,Y2)], TV2, NewTV),
  retract(toVisit(TV2)),
  assert(toVisit(NewTV)).

addFTV( [f(X,Y)|T], TV, NewTV) :-
  visited(V),
  myWorldSize(MaxX,MaxY),
  X >= 1, X =< MaxX, Y >= 1, Y=< MaxY,
  \+member(f(X,Y), TV), \+member(f(X,Y),V),
  addFTV( T, [f(X,Y)|TV], NewTV).
addFTV( [_|T], TV, NewTV) :-
  addFTV( T, TV, NewTV).
addFTV( [], NewTV, NewTV).


exit(Action, Knowledge) :-
  (toVisit([]) ; haveGold(1)),
  myPosition(1,1,_),
  Action = exit,
  Knowledge = [].
exit(Action, Knowledge) :-
  toVisit([]),
  path([]),
  myPosition(X,Y,O),
  visited(V),
  
  bfs(myPosition(X,Y,O), V, [f(1,1)], BFSpath),
  reconstructPath(BFSpath, Path),

  retract(path([])),
  assert(path(Path)),

  act(Action, Knowledge).

get_gold(Action, Knowledge) :-
  glitter,
  Action = grab,

  myWorldSize(MaxX,MaxY),
  myPosition(X,Y,O),
  visited(V),
  toVisit(TV),
  haveGold(Ngold),
  haveArrow(Narrow),
  wumpus(W),

  append(TV,V,V2),
  bfs(myPosition(X,Y,O), V2, [f(1,1)], BFSpath),
  reconstructPath(BFSpath, Path),

  Knowledge = [
    gameStarted, myWorldSize(MaxX,MaxY), myPosition(X,Y,O),
    visited(V), toVisit([]), haveGold(1), haveArrow(Narrow),
    wumpus(W), path(Path)
  ].
  
find_new_path(Action, Knowledge) :-
  path([]),
  toVisit(TV), TV \= [],
  visited(V),
  myPosition(X,Y,O),

  bfs(myPosition(X,Y,O), V, TV, BFSpath),
  reconstructPath(BFSpath, Path),
  retract(path([])),
  assert(path(Path)),

  act(Action, Knowledge).

follow_path(Action, Knowledge) :-
  path([Action|Path]),
  
  myWorldSize(MaxX,MaxY),
  myPosition(X,Y,O),
  visited(V),
  toVisit(TV),
  haveGold(Ngold),
  haveArrow(Narrow),
  wumpus(W),

  newPosition( myPosition(X,Y,O), Action, myPosition(X2,Y2,O2)),

  Knowledge = [
    gameStarted, myWorldSize(MaxX,MaxY), path(Path),
    myPosition(X2,Y2,O2), visited(V), toVisit(TV),
    haveGold(Ngold), haveArrow(Narrow), wumpus(W)
  ].
  
newPosition(myPosition(X,Y,O), turnLeft, myPosition(X,Y,O2)) :-
  turnLeftPos(O,O2).
newPosition(myPosition(X,Y,O), turnRight, myPosition(X,Y,O2)) :-
  turnRightPos(O,O2).
newPosition(myPosition(X,Y,O), moveForward, myPosition(X2,Y2,O)) :-
  moveForwardPos( myPosition(X,Y,O), myPosition(X2,Y2,O)).

reconstructPath(BFSpath, Path) :-
  reverse(BFSpath, BFSpath2),
  reconstruct(BFSpath2, Path).

reconstruct([myPosition(X,Y,O),myPosition(X2,Y2,O2)|BFSpath], [A|Path]) :-
  ((X =\= X2 ; Y =\= Y2), A = moveForward ;
  turnLeftPos(O,O2), A = turnLeft ;
  turnRightPos(O,O2), A = turnRight),
  reconstruct([myPosition(X2,Y2,O2)|BFSpath], Path).
reconstruct([_],[]).

bfs(myPosition(X,Y,Orient), Visited, ToVisit, BFSpath) :-
  bfs([[myPosition(X,Y,Orient)]], [], Visited, ToVisit, BFSpath).
%prevRoute, prevRoutes, dest, visited, tovisit, route
bfs([], NewPaths, Visited, ToVisit, BFSpath) :-
  bfs(NewPaths, [], Visited, ToVisit, BFSpath).

bfs([[P|Path]|_], _, _, ToVisit, [P|Path]) :-
  P = myPosition(X,Y,_),
  member(f(X,Y), ToVisit), !.

bfs([Path|Paths], NewPaths, Visited, ToVisit, BFSpath) :-
  addPaths(Path, NewPaths, Visited, ToVisit, NewPaths2),
  bfs(Paths, NewPaths2, Visited, ToVisit, BFSpath).
  

addPaths([P|Path], NewPaths, Visited, ToVisit, NewPaths2) :-
  moveForwardPos(P, myPosition(Xn,Yn,On)),
  myWorldSize(MaxX, MaxY),
  MaxX >= Xn, 1 =< Xn, MaxY >= Yn, 1 =< Yn,
  (member(f(Xn,Yn), Visited) ; member(f(Xn,Yn), ToVisit)),
  \+member(myPosition(Xn,Yn,On), Path),
  addPaths2([P|Path], [[myPosition(Xn,Yn,On),P|Path]|NewPaths], Visited, ToVisit, NewPaths2).

addPaths( P, NewPaths, Visited, ToVisit, NewPaths2) :-
  addPaths2(P, NewPaths, Visited, ToVisit, NewPaths2).

addPaths2([P|Path], NewPaths, Visited, ToVisit, NewPaths2) :-
  P = myPosition(X,Y,O),
  turnLeftPos(O, O2),
  \+member(myPosition(X,Y,O2), Path),
  addPaths3([P|Path], [[myPosition(X,Y,O2),P|Path]|NewPaths], Visited, ToVisit, NewPaths2).

addPaths2( P, NewPaths, Visited, ToVisit, NewPaths2) :-
  addPaths3(P, NewPaths, Visited, ToVisit, NewPaths2).

addPaths3([P|Path], NewPaths, _, _,[[myPosition(X,Y,O2),P|Path]|NewPaths] ) :-
  P = myPosition(X,Y,O),
  turnRightPos(O, O2),
  \+member(myPosition(X,Y,O2), Path).

addPaths3(_, NP, _, _, NP).

moveForwardPos(myPosition(X,Y,O), myPosition(Xn,Yn,O)) :-
  X1 is X - 1, X2 is X+1, Y1 is Y-1, Y2 is Y+1,
  member(o(Xn,Yn,O), [o(X1,Y,west),o(X2,Y,east),o(X,Y1,south),o(X,Y2,north)]).
  
turnLeftPos(O,O2) :-
  member(o(O,O2), [o(north,west),o(west,south),o(south,east),o(east,north)]).

turnRightPos(O,O2) :-
  member(o(O,O2), [o(north,east),o(east,south),o(south,west),o(west,north)]). 

