Definitions.

AND     = and
OR      = or
NOT     = not

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

{AND} : {token, {boolean_mult, TokenLine}}.
{OR} : {token, {boolean_add, TokenLine}}.
{NOT} : {token, {boolean_negate, TokenLine}}.

%% white space
[\s\n\r\t]+           : skip_token.

Erlang code.
oid(Oid) ->
    S = tl(lists:droplast(Oid)),
    L = string:split(S, ".", all),
    lists:map(fun list_to_integer/1, L).