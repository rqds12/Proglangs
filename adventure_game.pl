:- dynamic(relation/3).
:- dynamic(group/2).
:- dynamic(noun/2).
:- dynamic(currentRoom/1).
:- dynamic(inventory/1).


switch(X, [Val: Goal|Cases]) :-
    ( X=Val ->
      call(Goal)
    ;
      switch(X, Cases)
    ).

equal(X,Y):-
    X=Y.
read_in :-
    write('enter the game data\n'),
    read_string(user_input, "\n", "\t", End, Input), split_string(Input, ",", ",", Line),
    process(Line).

process([Head|Rest]):- split_string(Head, " ", " ", Head_split),process_first(Head_split,Rest).
process_first([Format| L],Rest):-
    switch(Format, [
               "relation": (convert_stringList_atomList(Rest,AtomRest),(convert_stringList_atomList(L,AtomList),parse_relation(AtomRest, AtomList))),
               "group": (convert_stringList_atomList(L,AtomList), parse_group(AtomList)) ,
               "noun": (convert_stringList_atomList(L,AtomList), parse_noun(AtomList)),
               "end": write("test") %change state to the repl
           ]).



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
parse_relation2([H2|L2],[H1|L1], R):- assert(relation(R,H1,H2)), assert_noun(H1,L1), assert_noun(H2,L2).
%assert_relation(Atom, [Type|Rest]):-
%    assert(relation(Atom(Type)), assert_relation(Atom,[Rest]).
%assert_relation(Atom,[]).


convert_stringList_atomList(L,R) :- accConv(L,R).
accConv([],[]).
accConv([H|L1], [H2|L2]) :-  accConv(L1,L2), atom_string(H2,H).


value_of_var(Var):-Var.

trim(X,L):-
    split_string(X, "", "\s\t\n", L).
%various actions
%move, help, pick_up, put, inventory, look

%actions gets all the potential actions from a group
actions():- findll(X, group(_,X),L).
%if help is called display all actions
display_help():- format("help: displays commands\n
move: moves the player. Eg: move room1.\n
pick_up: picks up an object. Eg: pick_up chair1.\n
place: places and object down. Eg: place chair1.\n
look: lists the ‘objects’ present in a room.\n
inventory: displays the inventory of the player. Eg: inventory.\n"), write_list('~w:~n',actions()).

write_list(Str, [H|Rest]):-
    format(Str, [H]), write_list(Rest).
write_list([]). %base case.

%parse repl  X is a string.  Out is a
%parse_repl(X, Out):-.

%move checks if the current room is connected to the desired room. it reasserts the current room
move(Y):-
    relation(connected, currentRoom(X), Y) ->
        (retract(currentRoom(X)),assert(currentRoom(Y))).

%adds an element to the inventory
pick_up(X):-
    assert(inventory(X)).

%removes an element from the inventory
place(X):-
    inventory(X) ->
        retract(inventory(X)).

inventory():-
    setof(X,inventory(X),L), write_list('~w:~n',L).

look():- setof(X, noun(X,_), L), write_list('You see a ~w ~n',L).



%todo for seth
%add text output for move, pickup, place
%add generic action output
%write repl
%when evaluating
%you can compare the first word the action, against all actions.  if it is in there, do the generic case
%otherwise try to call the specific ones
%
