Definitions.

WORD    = [a-z][a-z0-9_]*

Rules.

%% a number
[0-9]+ : {token, {number, TokenLine, list_to_integer(TokenChars)}}.

%% comparison operators
= : {token, {operator, TokenLine, cmp_eq}}.
!= : {token, {operator, TokenLine, cmp_ne}}.
< : {token, {operator, TokenLine, cmp_lt}}.
> : {token, {operator, TokenLine, cmp_gt}}.
<= : {token, {operator, TokenLine, cmp_le}}.
>= : {token, {operator, TokenLine, cmp_ge}}.
like     : {token, {operator, TokenLine, cmp_like}}.
contains : {token, {operator, TokenLine, cmp_contains}}.

%% aggregate functions
count : {token, {aggregate, TokenLine, f_count}}.
add : {token, {aggregate, TokenLine, f_add}}.

%% open/close parens
\( : {token, {'(', TokenLine}}.
\) : {token, {')', TokenLine}}.
\[ : {token, {'[', TokenLine}}.
\] : {token, {']', TokenLine}}.

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