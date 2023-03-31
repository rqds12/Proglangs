:- dynamic(relation/3).
:- dynamic(group/2).
:- dynamic(noun/2).



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
accConv([H|L1], [atom_string(X,H),L2]) :-  accConv(L1,[X|L2]).


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
inventory: displays the inventory of the player. Eg: inventory.\n"), write_list(actions()).

write_list([H|Rest]):-
    format('~w:~n', [H]), write_list(Rest).
write_list([]). %base case.


