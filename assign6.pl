male(abraham).
male(issac).
male(jacob).
male(judah).
male(reuben).
male(simeon).
male(levi).
male(issachar).
male(dan).
male(naphtali).
male(gad).
male(asher).
male(zebulun).
male(joseph).
male(benjamin).
male(perez).
male(zerah).
male(hezron).
male(ram).
male(amminadab).
male(nahshon).
male(salmon).
male(boaz).
male(obed).
male(jesse).
male(david).
male(solomon).
male(rehoboam).
male(abijah).
male(assa).
male(jehoshaphat).
male(joram).
male(uzziah).
male(jotham).
male(ahaz).
male(hezekiah).
male(manasseh).
male(amon).
male(josiah).
male(jeconiah).
male(jeconiah_brothers).
male(shealtiel).
male(zerubbabel).
male(abiud).
male(eliakim).
male(azor).
male(zadok).
male(achim).
male(eliud).
male(eleazar).
male(matthan).
male(jacob_son_of_matthan).
male(joseph_father_of_jesus).
male(jesus).

female(tamar).
female(rahab).
female(ruth).
female(bathsheba).
female(mary).
female(leah).
female(rachel).
female(zilpah).
female(dinah).
female(bilhah).
female(sarah).

parent(abraham,issac).
parent(sarah,issac).
parent(issac,jacob).
parent(jacob,judah).
parent(jacob,reuben).
parent(jacob,simeon).
parent(jacob,levi).
parent(jacob,issachar).
parent(jacob,dan).
parent(jacob,naphtali).
parent(jacob,gad).
parent(jacob,asher).
parent(jacob,zebulun).
parent(jacob,joseph).
parent(jacob,benjamin).
parent(leah,reuben).
parent(leah,simeon).
parent(leah,levi).
parent(leah,judah).
parent(leah,issachar).
parent(leah,zebulun).
parent(leah,dinah).
parent(rachel, joseph).
parent(rachel, benjamin).
parent(bilhah, dan).
parent(bilhah, naphtali).


parent(judah,perez).
parent(judah,zerah).
parent(tamar,perez).
parent(tamar,zerah).
parent(perez,hezron).
parent(hezron,ram).
parent(ram,amminadab).
parent(amminadab,nahshon).
parent(nahshon,salmon).
parent(salmon,boaz).
parent(rahab,boaz).
parent(boaz,obed).
parent(ruth,obed).
parent(obed,jesse).
parent(jesse,david).
parent(david,solomon).
parent(bathsheba,solomon).
parent(solomon,rehoboam).
parent(rehoboam,abijah).
parent(abijah,assa).
parent(asa,jehoshaphat).
parent(jehoshaphat,joram).
parent(joram,uzziah).
parent(uzziah,jotham).
parent(jotham,ahaz).
parent(ahaz,hezekiah).
parent(jezekiah,manasseh).
parent(manasseh,amon).
parent(amon,josiah).
parent(josiah,jeconiah).
parent(josiah,jeconiah_brothers).
parent(jeconiah,shealtiel).
parent(shealtiel,zerubbabel).
parent(zerubbabel,abiud).
parent(abiud,eliakim).
parent(eliakim,azor).
parent(azor,zadok).
parent(zadok,achim).
parent(achim,eliud).
parent(eliud,eleazar).
parent(eleazar,matthan).
parent(matthan,jacob_son_of_matthan).
parent(jacob_son_of_matthan, joseph_father_of_jesus).
parent(joseph_father_of_jesus,jesus).
parent(mary,jesus).

%father relation
find_father(X,Y):-
    (parent(X,Y),male(X)).

%find the father of a person w/ pretty print
father(Y):-
    find_father(X,Y),  format("~w is the father of ~w",[X,Y]).

%find the mother of a person w/ pretty print
mother(Y):-
    (parent(X,Y),female(X)) , format("~w is the mother of ~w",[X,Y]).

%find the sons of a person w/ pretty print
sons(Y):-
    (parent(Y,X),male(X)),
    format("~w is the son of ~w~n", [X,Y]).

%find a person's grandfather w/ pretty print
grandfather(Y):-
    (find_father(X,Z),find_father(Z,Y)),
    format("~w is the grandfather of ~w~N",[X,Y]).

%use this to query information about sibilings w/ pretty print
sibilings(X,Y):-
    (find_father(Z,X), find_father(W,Y)),
    (Z==W, X \== Y, X @< Y),  %makes sure that the children aren't the same, the fathers are the same, and puts in lexigographical
                              %order to remove duplicates
      format("~w is the sibiling of ~w~N",[X,Y]).

%check if the person is a man.  allows pretty printing
man(X):-
    male(X), format("~w is a male~N",[X]).

%check if the person is a woman.  allows pretty printing
woman(X):-
    female(X), format("~w is a female~N",[X]).


