Definitions.

WORD    = [a-z][a-z0-9_]*

Rules.

%% a number
[0-9]+ : {token, {number, TokenLine, list_to_integer(TokenChars)}}.

%% open/close parens
\( : {token, {'(', TokenLine}}.
\) : {token, {')', TokenLine}}.

%% arithmetic operators
\. : {token, {'.', TokenLine}}.

and     : {token, {boolean_mult, TokenLine}}.
or      : {token, {boolean_add, TokenLine}}.
not     : {token, {boolean_negate, TokenLine}}.
where   : {token, {where, TokenLine}}.
true    : {token, {true, TokenLine}}.
false   : {token, {false, TokenLine}}.
between : {token, {between, TokenLine}}.
{WORD}  : {token, {word, TokenLine, TokenChars}}.


%% white space
[\s\n\r\t]+           : skip_token.

Erlang code.
oid(Oid) ->
    S = tl(lists:droplast(Oid)),
    L = string:split(S, ".", all),
    lists:map(fun list_to_integer/1, L).