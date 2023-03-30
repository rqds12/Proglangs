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
    read(user_input, "\n", "\t", End, Input), split_string(Input, " ", " ", Line),
    process(Line).

process(Type|Line):-
    switch(Type, [
               equal(Type,"relation"): (convert_stringLIst_atomList(Line,AtomList),parse_relation(AtomList)),
               equal(Tdype, "group"):  ,
               equal(Type, "noun"):,
               equal(Type, "end"):  %change state to the repl
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


%relation dcg
relation --> b,g.
b --> [T].
g --> [c], g.
g --> [c]

parse_relation(Atom|Line):-
    


convert_stringList_atomList(L,R) :- accConv(L,R).
accConv([],[]).
accConv([H|L1], [atom_string(X,H),L2]) :-  accConv(L1,L2).
