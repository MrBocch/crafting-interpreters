# Crafting Interpreters

## Lexemes and Tokens

> The lexemes are only the raw substrings of the source code.

``` "var" "language" "=" "'lox'" ";" ```

> in the process of grouping characters sequences into lexemes,
> we also stumble upon some other useful information. When we take
> the lexeme and bundle it together with that other data,

> the result is a token.

It includes things like

* Token type

## Representing Code

> How do you write down a grammer that contains
> an infinite number of valid strings?

let <name> = <value>
they are infinite number of names for variable names,
and an infinite number of expresions that evaluate to
a value, how do i formulate ......

The begining of full of very formal/linguistic stuff

> we need a way to write down these production rules.

a production is a rule on (how to generate strings?)

> John Backus and company needed a notation
> for specifying ALGOL 58 and came up with
> Backus-Naur form (BNF)

i wonder what these other flavors of BNF do. why
would one need a variation?

this is so funny

> Yes, we need to define a syntax to use for the
> rules that define our syntax

The breakfast example is confusing tbh

Looking at [Lua's BNF](http://parrot.github.io/parrot-docs0/0.4.7/html/languages/lua/doc/lua51.bnf.html)
there are somethings i dont understand
but other things that i do

```
binop ::= `+´  |  `-´  |  `*´  |  `/´  |  `^´  |  `%´  |  `..´  |
                 `<´  |  `<=´  |  `>´  |  `>=´  |  `==´  |  `~=´  |
                 and  |  or

unop ::= `-´  |  not  |  `#´
```

binop is a function that takes in two arguments
i guess its implicit that they are all infix

what would be the BNF for a language like brainf*ck?

[BNF for C](https://cs.wmich.edu/~gupta/teaching/cs4850/sumII06/The%20syntax%20of%20C%20in%20Backus-Naur%20form.htm)
this BNF is actually found in the
K&R book
just looked at it, not quite a BNF

Looking at lua's BNF
there is alot more rules than
i had expected AND Lua is a simple
language with a simple syntax

Everyother grammer example i found
were for a simple arithmetic calculator

```
expression     → literal
               | unary
               | binary
               | grouping ;

literal        → NUMBER | STRING | "true" | "false" | "nil" ;
grouping       → "(" expression ")" ;
unary          → ( "-" | "!" ) expression ;
binary         → expression operator expression ;
operator       → "==" | "!=" | "<" | "<=" | ">" | ">="
               | "+"  | "-"  | "*" | "/" ;
```

so for example
``` 1 + / 3? ```
is not a string that can be produced because

binary -> expresion op expresion
<1 = literal> <+ = operator> </ = operator>
its doing
literal op op, so its not valid
it does not fit in grammer

you can note BNF in BNF

syntax diagram alternative to BNF?
syntax diagrams reminds me of automatons

bnf does not note how arithmetic
is evaluated

the code bits

he will define a class for each
type of (rule?)

so its very tedius to write this out
in java he resorts to writing a
helper wich would write the code
for him.

idk if it makes sense to do so in crystal
its not so verbose

so what exactly is going to be
doing the evaluation of expresions

*expression problem*

the visitor pattern, i wonder if he
mentions this in his other book
Game Programming Patterns

> The Visitor pattern is really
> about approximating the functional
> style within an OOP language.

this is very confusing,
i think i rather have to rewrite
everything when adding a new type
or function

i really dont like this style
or java
