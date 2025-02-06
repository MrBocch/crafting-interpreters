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
