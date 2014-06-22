
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
  assert(wumpusPos(0,0)),

  act(Action, Knowledge).

act(Action, Knowledge) :- pre_process(Action, Knowledge).
act(Action, Knowledge) :- hit_wumpus(Action, Knowledge).
act(Action, Knowledge) :- lucky_shot(Action, Knowledge).
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
  myPosition(_,_,_),
  assert(visited(NewV)),

  toVisit(_),
  checkFieldsToVisit(_),

  act(Action, Knowledge).


checkVisited(NewV3) :-
  visited(V),
  myPosition(X,Y,_),
  (\+member(f(X,Y),V), NewV = [f(X,Y)|V]
  ;  NewV = V),
  (stench, \+member(stench(X,Y),NewV), NewV2 = [stench(X,Y)|NewV] 
    ; NewV2 = NewV),
  (breeze, \+member(breeze(X,Y),NewV2), NewV3 = [breeze(X,Y)|NewV2]
    ; NewV3 = NewV2).

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
  wumpusPos(X,Y),
  addFTV(T,TV,NewTV).
addFTV( [f(X,Y)|T], TV, NewTV) :-
  visited(V),
  myWorldSize(MaxX,MaxY),
  X >= 1, X =< MaxX, Y >= 1, Y=< MaxY,
  \+member(f(X,Y), TV), \+member(f(X,Y),V),
  addFTV( T, [f(X,Y)|TV], NewTV).
addFTV( [_|T], TV, NewTV) :-
  addFTV( T, TV, NewTV).
addFTV( [], NewTV, NewTV).


lucky_shot(Action, Knowledge) :-
  %when we just tried to kill wumpus but failed to, we can move forward
  luckyShoot,
  path([]),
  haveGold(0),
  haveArrow(0),
  toVisit([]),
  visited(V),
  myPosition(Xs,Ys,Om),
  member(stench(Xs,Ys),V),
  \+member(breeze(Xs,Ys),V),
  myWorldSize(MaxX,MaxY),

  Action = moveForward,
  newPosition(myPosition(Xs,Ys,Om), moveForward, myPosition(Xm2,Ym2,Om2)),
  % assert wumpus position - if fired arrow missed, we know where wumpus is
  get_wumpus_pos(wumpusPos(Xw,Yw)),
  revisit_stench(V,[],TV),
  % also revisit stench fields

  Knowledge = [
    gameStarted, myWorldSize(MaxX,MaxY), path([]),
    myPosition(Xm2,Ym2,Om2), visited(V), toVisit(TV),
    haveGold(0), haveArrow(0), wumpus(dead), wumpusPos(Xw,Yw), luckyDone
  ].
  
get_wumpus_pos(wumpusPos(Xw,Yw)) :-
  myPosition(Xm,Ym,Om),
  visited(V),
  myWorldSize(MaxX,MaxY),
  newPosition(myPosition(Xm,Ym,Om), moveForward, myPosition(Xm2,Ym2,Om)),
  X1 is Xm-1, X2 is Xm+1, Y1 is Ym-1, Y2 is Ym+1,
  member(f(Xw,Yw),[f(X1,Ym),f(X2,Ym),f(Xm,Y1),f(Xm,Y2)]),
  Xw >= 1, Xw =< MaxX, Yw >= 1, Yw =< MaxY,
  \+member(f(Xw,Yw),[f(Xm2,Ym2)|V]).
  
lucky_shot(Action, Knowledge) :-
  path([]),
  haveGold(0),
  haveArrow(1),
  toVisit([]),
  visited(V),
  member(stench(Xs,Ys),V),
  \+member(breeze(Xs,Ys),V),
  myPosition(Xm,Ym,Om),
  myWorldSize(MaxX,MaxY),

  (
  %if agent stands on stench field, turn towards any adjacent
  % unvisited field and shoot

  Xs == Xm, Ys == Ym,
  moveForwardPos(myPosition(Xm,Ym,Om), myPosition(Xf,Yf,Om)),
  %field pos reachable by moving forward
  (member(f(Xf,Yf),V) ;
   Xm == 1, Om=west ; Ym == 1, Om=south ;
   Xm == MaxX, Om=east ; Ym = MaxY, Om=north),
  Action = turnLeft,
  newPosition(myPosition(Xm,Ym,Om), turnLeft, myPosition(Xm,Ym,Om2)),

  Knowledge = [
    gameStarted, myWorldSize(MaxX,MaxY), path([]),
    myPosition(Xm,Ym,Om2), visited(V), toVisit([]),
    haveGold(0), haveArrow(1), wumpus(alive),wumpusPos(0,0)
  ]
  ;
  %agent stands on stench field and faces unvisited field

  Xs == Xm, Ys == Ym,
  Action = shoot,
  assert(luckyShoot),
  Knowledge = [
    gameStarted, myWorldSize(MaxX,MaxY), path([]),
    myPosition(Xm,Ym,Om), visited(V), toVisit([]),
    haveGold(0), haveArrow(0), wumpus(alive), luckyShoot,
    wumpusPos(0,0)
  ]
  ;
  %otherwise go to a stench field
  bfs(myPosition(Xm,Ym,Om), V, [f(Xs,Ys)], BFSpath),
  reconstructPath(BFSpath, Path),
  retract(path([])),
  assert(path(Path)),

  follow_path(Action, Knowledge)
  ).

agent_faces_wall(myPosition(Xm,_,west)) :-
  Xm>1.
agent_faces_wall(myPosition(_,Ym,south)) :-
  Ym>1.
agent_faces_wall(myPosition(Xm,_,east)) :-
  worldSize(MaxX,_), MaxX>Xm.
agent_faces_wall(myPosition(_,Ym,north)) :-
  worldSize(_,MaxY), MaxY>Ym.


exit(Action, Knowledge) :-
  (toVisit([]),path([]) ; haveGold(1)),
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
  haveGold(_),
  haveArrow(Narrow),
  wumpus(W),

  append(TV,V,V2),
  bfs(myPosition(X,Y,O), V2, [f(1,1)], BFSpath),
  reconstructPath(BFSpath, Path),

  Knowledge = [
    gameStarted, myWorldSize(MaxX,MaxY), myPosition(X,Y,O),
    visited(V), toVisit([]), haveGold(1), haveArrow(Narrow),
    wumpus(W), path(Path), wumpusPos(0,0)
  ].
 

 
hit_wumpus(Action, Knowledge) :-
  stench,

  myWorldSize(MaxX,MaxY),
  myPosition(X,Y,O),
  path(_),
  visited(V),
  toVisit(TV),
  haveGold(Ngold),
  haveArrow(Narrow),
  wumpus(W),

  (
  scream, Action = moveForward, %wumpus just killed
  newPosition(myPosition(X,Y,O), moveForward, myPosition(X2,Y2,O2)),
  Narrow2 = 0, W2=dead,
  revisit_stench(V,TV,TV2)
  ;
  % find wumpus pos
  Narrow > 0,
  W = alive,
  member(stench(Xb,Yb),V), \+member(breeze(Xb,Yb),V),  %make sure wumpus isn't standing on pit
  member(stench(Xs1,Ys1),V), member(stench(Xs2,Ys2),V),
  TV2 = TV,
  
   (
   %case 1.
   % W? S2
   % S1 W?
   Xs1<Xs2, Ys1<Ys2,
    (
     %  V S2
     % S1 W
     member(f(Xs1,Ys2),V), Xw=Xs2, Yw=Ys1
     ;
     %  W S2
     % S1 V
     member(f(Xs2,Ys1),V), Xw=Xs1, Yw=Ys2
    )
   ;
   %case 2.
   % S2 W?
   % W? S1
   Xs1>Xs2, Ys1<Ys2,
    (
     % S2 W
     % V  S1
     member(f(Xs2,Ys1),V), Xw=Xs1, Yw=Ys2
    ;
     % S2 V
     % W  S1
     member(f(Xs1,Ys2),V), Xw=Xs2, Yw=Ys1
    )
   ;
   %case 3.
   % S1 W S2
   Ys1 == Ys2, Xs1 < Xs2, Xw is Xs1+1, Yw=Ys1
   ;
   %case 4.
   % S2
   % W
   % S1
   Xs1 == Xs2, Ys1 < Ys2, Xw = Xs1, Yw is Ys1+1
   ),
   assert(wumpusPos(Xw,Yw)),

  % after wumpus pos found, turn towards wumpus
  % or shoot if agent faces him
  bfs(myPosition(X,Y,O), V, [f(Xw,Yw)], BFSpath),
  reconstructPath(BFSpath, [Act|_]),
   (
   Act == moveForward, Action = shoot, Narrow2 = 0,
   X2 = X, Y2 = Y, O2 = O
   ;
   Act =\= moveForward, Action = Act, Narrow2 = Narrow,
   newPosition( myPosition(X,Y,O), Action, myPosition(X2,Y2,O2))
   ),
  W2 = alive
  ),

  Knowledge = [
    gameStarted, myWorldSize(MaxX,MaxY), path([]),
    myPosition(X2,Y2,O2), visited(V), toVisit(TV2),
    haveGold(Ngold), haveArrow(Narrow2), wumpus(W2), wumpusPos(0,0), hit
  ].


revisit_stench([breeze(_,_)|V],TV,TV2) :-
  revisit_stench(V,TV,TV2).
revisit_stench([f(_,_)|V],TV,TV2) :-
  revisit_stench(V,TV,TV2).
revisit_stench([stench(X,Y)|V],TV,[f(X,Y)|TV2]) :-
  revisit_stench(V,TV,TV2).
revisit_stench([],TV,TV).

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
  wumpusPos(Xw,Yw),

  newPosition( myPosition(X,Y,O), Action, myPosition(X2,Y2,O2)),

  Knowledge = [
    gameStarted, myWorldSize(MaxX,MaxY), path(Path),
    myPosition(X2,Y2,O2), visited(V), toVisit(TV),
    haveGold(Ngold), haveArrow(Narrow), wumpus(W), wumpusPos(Xw,Yw)
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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bfs(myPosition(X,Y,Orient), Visited, ToVisit, BFSpath) :-
  bfs([[myPosition(X,Y,Orient)]], [], Visited, ToVisit, [], BFSpath).
%prevRoute, prevRoutes, dest, visited, tovisit, route
%%%%%%%%%%%%
bfs([], NewPaths, Visited, ToVisit, FoundRoutes, BFSpath) :-
  filterPaths(NewPaths, FoundRoutes, FoundRoutes2, NewPaths2),
  bfs(NewPaths2, [], Visited, ToVisit, FoundRoutes2, BFSpath).
%%%%%%%%%%%%
bfs([[P|Path]|_], _, _, ToVisit, _, [P|Path]) :-
  P = myPosition(X,Y,_),
  member(f(X,Y), ToVisit), !.

bfs([Path|Paths], NewPaths, Visited, ToVisit, FoundRoutes, BFSpath) :-
  addPaths(Path, NewPaths, Visited, ToVisit, NewPaths2),
  bfs(Paths, NewPaths2, Visited, ToVisit, FoundRoutes, BFSpath).
%%%%%%%%%%%%%%%%%%%%%%%

filterPaths([[P|_]|NewPaths], FR, FR2, NewPaths2) :-
  member(P, FR),% !,
  filterPaths(NewPaths, FR, FR2, NewPaths2).

filterPaths([[P|Path]|NewPaths], FR, FR2, [[P|Path]|NewPaths2]) :-
  %\+member(P, FR),
  filterPaths(NewPaths, [P|FR], FR2, NewPaths2).

filterPaths([], FR, FR, []).




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

