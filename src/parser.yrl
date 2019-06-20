Nonterminals query domain fieldname expression bterm bfactor valuelist field terms value.
Terminals number '(' ')' '.' '[' ']' where word or boolean_add boolean_mult not false true cmp_in quoted operator aggregate .
Rootsymbol query.

%query -> domain '.' fieldname operator value
%query -> domain '=' value
%query -> query '|' DEPEND
query -> terms : {terms, '$1'}.
query -> or terms : {terms, atom_or, '$2'}.
query -> domain where expression : {where, '$1', '$3'}.
%query -> domain where expression : {from, [context: Elixir, import: Ecto.Query], [{in, [context: Elixir, import: Kernel], [{c, [], Elixir}, {__aliases__, [alias: false], ['$1']}]}, [where: '$3']]}.
domain -> word : {domain, extract_value('$1')}.
expression -> bterm : '$1'.
expression -> expression boolean_add bterm : {'or', [{context, 'Elixir'}, {import, 'Kernel'}], '$1', '$3'}.
bterm -> bfactor : '$1'.
bterm -> bterm boolean_mult bfactor : {'and', [{context, 'Elixir'}, {import, 'Kernel'}], '$1', '$3'}.
bfactor -> not bfactor : {atom_not, '$2'}.
bfactor -> '(' expression ')' : '$2'.
bfactor -> false : false.
bfactor -> true : true.
bfactor -> field operator value : {remove_line('$2'), '$1', '$3'}.
bfactor -> aggregate '(' field ')' operator value : {remove_line('$5'), remove_line('$1'), '$3', '$6'}.
valuelist -> value : [ '$1' ].
valuelist -> value valuelist : [ '$1' | '$2' ].
bfactor -> field cmp_in '[' valuelist ']' : {in, '$1', '$4'}.
%bfactor -> field not in '[' valuelist ']'
%bfactor -> field BETWEEN value AND value
fieldname -> word : extract_value('$1').
field -> fieldname : [ '$1' ].
field -> fieldname '.' field : [ '$1' | '$3' ].
terms -> value : [ '$1' ].
terms -> value terms : [ '$1' | '$2' ].
terms -> aggregate terms : [ extract_value('$1') | '$2' ].
terms -> operator terms : [ extract_value('$1') | '$2' ].
value -> number : extract_value('$1').
value -> quoted : unquote('$1').

%

Erlang code.

-import(string,[len/1, sub_string/3]). 

extract_value({_Token, _Line, Value}) -> Value.
remove_line({Token, _Line, Value}) -> {Token, Value}.
unquote({_Token, _Line, Value}) -> sub_string(Value, 2, len(Value)-1).
