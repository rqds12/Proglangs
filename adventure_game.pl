switch(X, [Val: Goal|Cases]) :-
    ( X=Val ->
      call(Goal)
    ;
      switch(X, Cases)
    ).

equal(X,Y):-
    X=Y.
read_in :-
    write('enter the game data'),
    read(user_input, "\n", "\t", End, Input), split_string(Input, ",", ",", Line),
    process(Line).

process([Head|Rest]):- process_first([Head],[Rest])
process_first([Format|L],[Rest]):-
    switch(Type, [
               equal(Format,"relation"): (convert,_stringList_atomList(Rest,AtomRest),(convert_stringList_atomList(L,AtomList),parse_relation(AtomRest, AtomList))),
               equal(Format, "group"): (convert_stringList_atomList(L,AtomList), parse_group(AtomList)) ,
               equal(Format, "noun"):, (convert_stringList_atomList(L,AtomList), parse_noun(AtomList)),
               equal(Format, "end"):  %change state to the repl
           ]).



%parse group
parse_group([Type|Rest]):- assert_groups(Type, [Rest]).
assert_groups(Type, [Htype|Rest]):-
    assert(group(Type,Htype)), assert_groups(Type, [Rest]).
assert_groups(Type, []).  %base case

%parse noun
parse_noun([Type|Rest]):- assert_noun(Type, [Rest]).
assert_noun(Atom, [Hatom|Rest]):-
    assert(Atom(Hatom)), assert_noun(Atom, [Rest]).
assert_noun(Atom,[]).

parse_relation([R|H2|L2],[H1|L1]):- assert(R(H1,H2)), assert_relation(H1,[L1]), assert_relation(H2,[L2]).
assert_relation(Atom, [Type|Rest]):-
    assert(Atom(Type)), assert_relation(Atom,[Rest]).
assert_relation(Atom,[]).


convert_stringList_atomList(L,R) :- accConv(L,R).
accConv([],[]).
accConv([H|L1], [atom_string(X,H),L2]) :-  accConv(L1,L2).


