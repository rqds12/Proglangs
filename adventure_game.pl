:- dynamic(relation/3).
:- dynamic(group/2).
:- dynamic(noun/2).
:- dynamic(currentRoom/1).
:- dynamic(inventory/1).
:- dynamic(state/1).

switch(X, [Val: Goal|Cases]) :-
    ( X=Val ->
      call(Goal)
    ;
      switch(X, Cases)
    ).

equal(X,Y):-
    X=Y.
read_in:-
    write('enter the game data'), assert(state(read)), next_data(), process_game().
next_data():-
    write('\n'),
    read_string(user_input, "\n", "\t", End, Input), split_string(Input, ",", ",", Line),
    (state(read))->(process(Line),next_data()); write("Complete\n").

process([Head|Rest]):- split_string(Head, " ", " ", Head_split),process_first(Head_split,Rest).
process_first([Format| L],Rest):-
    switch(Format, [
               "relation": (reprocess_secondNoun(Rest,SecondSplit,Relation),convert_stringList_atomList([Relation|SecondSplit],AtomRest),(convert_stringList_atomList(L,AtomList),parse_relation(AtomRest, AtomList))),
               "group": (convert_stringList_atomList(L,AtomList), parse_group(AtomList)) ,
               "noun": (convert_stringList_atomList(L,AtomList), parse_noun(AtomList)),
               "end": (retract(state(read)), assert(state(repl)), !) %change state to the repl
           ]).

reprocess_secondNoun(In,SecondSplit,Relation):-
    nth0(0,In,Relation),nth0(1,In,SecondNouns),trim(SecondNouns,[SecondNounTrim|TrimRest]), split_string(SecondNounTrim, " ", " ",SecondSplit).

%parse group
parse_group([Type|Rest]):- assert_groups(Type, Rest).
assert_groups(Type, [Htype|Rest]):-
    assert(group(Type,Htype)), assert_groups(Type, Rest).
assert_groups(Type, []).  %base case

%parse noun
parse_noun([Type|Rest]):- assert_noun(Type, Rest).
assert_noun(Atom, [Hatom|Rest]):-
    assert(noun(Atom,Hatom)), assert_noun(Atom, Rest).
assert_noun(Atom,[]).

parse_relation([R|Rest], L):- parse_relation2(Rest,L, R).
parse_relation2([H2|L2],[H1|L1], R):- assert(relation(R,H1,H2)), assert(relation(R,H2,H1)), assert_noun(H1,L1), assert_noun(H2,L2).
%assert_relation(Atom, [Type|Rest]):-
%    assert(relation(Atom(Type)), assert_relation(Atom,[Rest]).
%assert_relation(Atom,[]).


convert_stringList_atomList(L,R) :- accConv(L,R).
accConv([],[]).
accConv([H|L1], [H2|L2]) :-  accConv(L1,L2), trim(H,[Htrim|X]), atom_string(H2,Htrim).

get_first([L|X],L):-
    L.
value_of_var(Var):-Var.

trim(X,L):-
    split_string(X, "", "\s\t\n", L).



process_game():-
    relation(connect,X, Y) -> (assert(currentRoom(X)), format("You are in ~w\n", [X]),repl()); format("Please add rooms to the game\n.").

repl():-
    read_string(user_input,"\n", "\t",  End, Input), split_string(Input, " ", " ", Line),
    convert_stringList_atomList(Line,AtomLine),
    process_repl(AtomLine),
    repl().

process_repl(Input):-
    nth0(0, Input, Command),
    switch(Command,[
               help: display_help(),
               look: look(),
               inventory: inventory(),
               move: (nth0(1, Input, Param), move(Param)),
               pick_up: (nth0(1,Input,Param), pick_up(Param)),
               place: (nth0(1,Input,Param), place(Param)),
               Command: (nth0(1,Input,Param),generic_action(Command,Param))
           ]).




%various actions
%move, help, pick_up, put, inventory, look

%actions gets all the potential actions from a group
actions(L):- findall(X, group(_,X),L).
%if help is called display all actions
display_help():- format("help: displays commands\n
move: moves the player. Eg: move room1.\n
pick_up: picks up an object. Eg: pick_up chair1.\n
place: places and object down. Eg: place chair1.\n
look: lists the ‘objects’ present in a room.\n
inventory: displays the inventory of the player. Eg: inventory.\n"), actions(L), write_list('~w:\n',L).

write_list(Str, [H|Rest]):-
    format(Str, H), write_list(Str,Rest).
write_list(Str,[]). %base case.

%parse repl  X is a string.  Out is a
%parse_repl(X, Out):-.

%move checks if the current room is connected to the desired room. it reasserts the current room
move(Y):-
    currentRoom(X),relation(connect,X, Y) ->
        (retract(currentRoom(X)),assert(currentRoom(Y)), format("You are now in ~w\n",[Y]));
    format("~w is not connected to ~w\n", [X,Y]).

%adds an element to the inventory
pick_up(X):-
    noun(X,pickable)->(currentRoom(CurRoom),retract(relation(in,X,CurRoom)),assert(inventory(X)),format("You picked up ~w\n",[X])); format("~w is not pickable\n", [X]).

%removes an element from the inventory
place(X):-
    inventory(X) ->
        (retract(inventory(X)), currentRoom(CurRoom), assert(relation(in,X,CurRoom)),format("You placed ~w\n",[X]));
    format("~w is not in your inventory\n",[X]).

inventory():-
    setof(X,inventory(X),L)-> write_list('~w:~n',L); format("Your inventory is empty.\n").

look():- (currentRoom(X),setof(Y, relation(in,Y,X), L))->write_list('You see a ~w ~n',L); format("You don't see anything.\n").

generic_action(Command, Param):-
    (group(Type,Command),
    noun(Param,Type))->
    format("You ~w the ~w.~n",[Command,Param]);
    format("Not a valid command or valid parameter\n").


connect(X,Y):- relation(connect, X,Y); relation(connect, Y,X).


%todo for seth
%add text output for move, pickup, place
%add generic action output
%write repl
%when evaluating
%you can compare the first word the action, against all actions.  if it is in there, do the generic case
%otherwise try to call the specific ones
%
