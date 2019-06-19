Nonterminals query domain fieldname expression bterm bfactor valuelist field aggregate operator terms value.
Terminals number '(' ')' '.' '[' ']' where word or and not false true in integer quoted squoted.
Rootsymbol query.

%query -> domain '.' fieldname operator value
%query -> domain '=' value
%query -> query '|' DEPEND
%query -> terms
%query -> OR terms
query -> domain where expression : {where, '$1', '$3'}.
domain -> word : {domain, extract_token('$1')}.
fieldname -> word : extract_token('$1').
expression -> bterm : {'$1'}.
expression -> expression or bterm : {atom_or, '$1', '$3'}.
bterm -> bfactor : {'$1'}.
bterm -> bterm and bfactor : {atom_and, '$1', '$3'}.
bfactor -> not bfactor : {atom_not, '$2'}.
bfactor -> '(' expression ')' : '$2'.
bfactor -> false : false.
bfactor -> true : true.
%bfactor -> field operator value
%bfactor -> aggregate '(' field ')' operator value
valuelist -> value : [ '$1' ].
valuelist -> value valuelist : [ '$1' | '$2' ].
bfactor -> field in '[' valuelist ']' : {in, '$1', '$4'}.
%bfactor -> field NOT IN '[' valuelist ']'
%bfactor -> field BETWEEN value AND value
field -> fieldname : [ '$1' ].
field -> fieldname '.' field : [ '$1' | '$2' ].
%aggregate -> COUNT
%aggregate -> SUM
%operator -> LIKE
%operator -> CONTAINS
%operator -> EQ
%operator -> NE
%operator -> LT
%operator -> LE
%operator -> GT
%operator -> GE
terms -> value : [ '$1' ].
terms -> value terms : [ '$1' | '$2' ].
value -> integer : extract_token('$1').
value -> quoted : unquote('$1').
value -> squoted : unquote('$1').

%

Erlang code.

-import(string,[len/1, sub_string/3]). 

extract_token({_Token, _Line, Value}) -> Value.
unquote({_Token, _Line, Value}) -> sub_string(Value, 2, len(Value)-2).
