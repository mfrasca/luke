Nonterminals query domain fieldname expression bterm bfactor valuelist field aggregate operator terms value.
Terminals oid number '+' '-' '*' '/' '(' ')'.
Rootsymbol query.

query -> domain '.' fieldname operator value
query -> domain '=' value
query -> query '|' DEPEND
query -> terms
query -> OR terms
query -> domain WHERE expression
domain -> WORD
fieldname -> WORD
expression -> bterm
expression -> expression OR bterm
bterm -> bfactor
bterm -> bterm AND bfactor
bfactor -> NOT bfactor
bfactor -> '(' expression ')' : '$2'.
bfactor -> FALSE : false
bfactor -> TRUE : true
bfactor -> field operator value
bfactor -> aggregate '(' field ')' operator value
valuelist -> value : [ '$1' ].
valuelist -> value valuelist : [ '$1' | '$2' ].
bfactor -> field IN '[' valuelist ']'
bfactor -> field NOT IN '[' valuelist ']'
bfactor -> field BETWEEN value AND value
field -> fieldname
field -> field DOT fieldname
aggregate -> COUNT
aggregate -> SUM
operator -> LIKE
operator -> CONTAINS
operator -> EQ
operator -> NE
operator -> LT
operator -> LE
operator -> GT
operator -> GE
terms -> value
terms -> value terms : [ '$1' | '$2' ].
value -> INTEGER
value -> WORD
value -> QUOTED
value -> SQUOTED
value -> AND
value -> OR
value -> NOT
value -> SUM
value -> COUNT
