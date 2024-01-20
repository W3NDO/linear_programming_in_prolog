:- module( [is_sentence/2] ).
:- use_module(library(clpfd)).

article --> [a].
article --> [an].
article --> [the].
% variable_name --> [X], { atom(X) }.
variable_name --> [b]. % we do not use the letter a as a variable because it appears as an article as well.
variable_name --> [c].
variable_name --> [d].
variable_name --> [e].
variable_name --> [f].
variable_name --> [g].
variable_name --> [h].
variable_name --> [i].
variable_name --> [j].
variable_name --> [k].
variable_name --> [l].
variable_name --> [m].
variable_name --> [n].
variable_name --> [o].
variable_name --> [p].
variable_name --> [q].
variable_name --> [r].
variable_name --> [s].
variable_name --> [t].
variable_name --> [u].
variable_name --> [v].
variable_name --> [w].
variable_name --> [x].
variable_name --> [y].
variable_name --> [z].
number --> [X], {integer(X), X >= 0}.
number --> [X], {integer(X), X < 0}.
variable_specifier --> [variable].
variable_specifier --> [variables].
subtraction --> [-].
subtraction --> [minus].
division --> [divided,by].
division --> [/].
multiplication --> [multiplied,by].
multiplication --> [times].
multiplication --> [*].
addition --> [plus].
addition --> [+].
operator --> addition.
operator --> subtraction.
operator --> division.
operator --> multiplication.
linking_verb --> [is].
linking_verb --> [are].
gt --> [>].
gt --> linking_verb,[greater,than].
lt --> [<].
lt --> linking_verb,[less,than].
gte --> [>,=].
gte --> linking_verb,[greater,than,or,equal,to].
lte --> [<,=].
lte --> linking_verb,[less,than,or,equal,to].
equals --> [=].
equals --> [equals].
equals --> [is].
equals --> linking_verb,[equal,to].
equality --> gt.
equality --> gte.
equality --> lt.
equality --> lte.
equality --> equals.
reference_tag --> [it].
reference_tag --> [all,these].
reference_tag --> [all,the].
range(Start,End) --> [varies,from,Start,to,End].
range(Start,End) --> [lies,between,Start,and,End].
range(Start,End) --> linking_verb,[in,the,range,Start,to,End].
operand --> number.
operand --> variable_name.
expression --> operand.
expression --> operand,operator,operand.
expression --> operand,operator,expression.
expression --> article,[quotient,of],expression,[and],expression.
expression --> article,[product,of],expression,[and],expression.
fullstop --> [fullstop].
fullstop --> [.].
sentence --> article,variable_specifier,variable_name,range(X,Y), fullstop.
sentence --> variable_specifier,variable_name,range(X,Y), fullstop.
sentence --> variable_specifier,variable_name,equality,operand,fullstop.
sentence --> reference_tag,equality,expression, fullstop.
sentence --> reference_tag,variable_specifier,equality,expression, fullstop.
sentence --> variable_name,equality,expression, fullstop.
sentence --> variable_specifier,variable_name,equality,expression, fullstop.

:- begin_tests(valid_variable_names).

test(valid_variable_name) :-
    phrase(variable_name, [c], []).

test(invalid_variable_name) :-
    \+ phrase(variable_name, [a], []).
    

:- end_tests(valid_variable_names).

:- begin_tests(valid_number).

test(valid_number) :-
    phrase(number, [10], []).

test(valid_number) :-
    phrase(number, [-10], []).

test(valid_number) :-
    phrase(number, [0], []).

:- end_tests(valid_number).

:- begin_tests(valid_operator).

test(valid_operator) :-
    phrase(operator, [+], []).

test(valid_operator) :-
    phrase(operator, [plus], []).

test(valid_operator) :-
    phrase(operator, [minus], []).

test(valid_operator) :-
    phrase(operator, [divided,by], []).

test(valid_operator) :-
    phrase(operator, [multiplied,by], []).

test(valid_operator) :-
    phrase(operator, [times], []).

:- end_tests(valid_operator).

:- begin_tests(valid_ranges).

test(valid_range) :-
    phrase(range(10,12), [varies,from,X,to,Y], []),
    _X = 10,
    _Y = 12.

test(valid_range) :-
    phrase(range(10,30), [lies,between,X,and,Y], []),
    _X = 10,
    _Y = 30.

test(valid_range) :-
    phrase(range(-100, 100), [is,in,the,range,X,to,Y], []),
    _X = -100,
    _Y = 100.

:- end_tests(valid_ranges).

:- begin_tests(valid_expressions).

test(valid_expressions) :-
    phrase(expression, [x], []).

test(valid_expression) :-
    phrase(expression, [100], []).

test(valid_expression) :-
    phrase(expression, [x,divided,by,10], []).

test(valid_expression) :-
    phrase(expression, [x,minus,10,plus,36], []).

test(valid_expression) :-
    phrase(expression, [the,quotient,of,x,and,10], []).

test(valid_expression) :-
    phrase(expression, [the,product,of,x,and,10], []).

:- end_tests(valid_expressions).

% sentence --> article,variable_specifier,variable_name,range(X,Y), fullstop.
% sentence --> variable_specifier,variable_name,range(X,Y), fullstop.
% sentence --> variable_specifier,variable_name,equality,operand,fullstop.
% sentence --> reference_tag,equality,expression, fullstop.
% sentence --> reference_tag,variable_specifier,equality,expression, fullstop.
% sentence --> variable_name,equality,expression, fullstop.
% sentence --> variable_specifier,variable_name,equality,expression, fullstop.

:- begin_tests(valid_sentences).

test(valid_sentence) :-
    phrase(sentence, [the,variable,x,lies,between,0,and,10,.], []).

test(valid_sentence) :-
    phrase(sentence, [variable,y,varies,from,10,to,-10,.], []).

test(valid_sentence) :-
    phrase(sentence, [a,variable,z,is,in,the,range,0,to,15,.], []).

test(valid_sentence) :-
    phrase(sentence, [it,equals,x,plus,y,.], []).

test(valid_sentence) :-
    phrase(sentence, [all,these,variables,are,greater,than,-20,.], []).

test(valid_sentence) :-
    phrase(sentence, [y,is,less,than,5,+,2,*,x,.], []).

test(valid_sentence) :-
    phrase(sentence, [x,is,greater,than,y,times,2,.], []).

test(valid_sentence) :-
    phrase(sentence, [variable,y,is,greater,than,or,equal,to,the,quotient,of,z,and,4,.], []).

:- end_tests(valid_sentences).