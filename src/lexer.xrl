Definitions.
Rules.

%% a number
[0-9]+ : {token, {number, TokenLine, list_to_integer(TokenChars)}}.

%% an OID
\[[0-9]+(\.[0-9]+)*\] : {token, {oid, TokenLine, oid(TokenChars)}}.

%% open/close parens
\( : {token, {'(', TokenLine}}.
\) : {token, {')', TokenLine}}.

%% arithmetic operators
\+ : {token, {'+', TokenLine}}.
\- : {token, {'-', TokenLine}}.
\* : {token, {'*', TokenLine}}.
\/ : {token, {'/', TokenLine}}.

%% white space
[\s\n\r\t]+           : skip_token.

Erlang code.
oid(Oid) ->
    S = tl(lists:droplast(Oid)),
    L = string:split(S, ".", all),
    lists:map(fun list_to_integer/1, L).