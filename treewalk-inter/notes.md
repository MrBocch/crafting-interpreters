### A TREE-WALK INTERPRETER

here we go

alot of concepts and jargon have to go thrue

> Programming language theory requires a level
> of mental rigor

> Implementing an interpreter uses a few
> architectural tricks and design patterns uncommon
> in other kinds of applications

haven't used any design patterns, dont even know
what patterns they are

lest go

so, how am i going to organize notes, and the code?
write everthing here? and code in a seperate folder?
fahk it

#### Scanning

> The first step in any compiler or interpreter is
> scanning

so, **scanning** or **lexing** was to take
source code, and take anything thats important
we only want **tokens**

```primary role is to transform a sequence of
characters into a sequence of tokens```

> tokens, These are the meaningful "words" and
> "punctuations" that make up the language's grammer

again, what is this **language's grammer**

> Scanning is a good starting point for us too because
> the code isn't very hard

an interpreter is like anyother program, starts
at main. it has to open a file, you've done that
before, read cli arguments, you've done that before

have not really programmed in java so, ill only
write the stuff i understand, all incrementally
instead of just copying and pasting

```
unreported exception IOException; must be caught or declared to be thrown
```

so some functions, and throw, is that how this
interpreter will handle, not being able to open file?

yuh,
```
Exception in thread "main" java.nio.file.NoSuchFileException: file
```

what about this byte business in, runFile()

it reads the file as if they were bytes

```
hello world

// as bytes, in ascii

h   e   l   l   o   [SPACE]  w   o   r   l   d   \n
104 101 108 108 111 32       119 111 114 108 100 10
```

atleast i think they are ascii, can i use emojis?

💀 hello world

is
                         h   e
[-16 -97 -110 -128 32] + 104 101 ...

i guess we are using bytes, because an ascii character uses
7 bits to represent a character, one byte

so if we wanted support for utf8, we would have to parse it
with, 4 bytes?, or go thrue each byte and detect if they are utf8?

what is this Charset thing?
could i set the file encoding thrue here?

Charset.defaultCharset() == UTF-8

i dont understand why you have to do this at ```runFile```

why not use the scanner object?

maybe because, this book is a little old, and the scanner class
was not a thing yet. he makes his Scanner class, ill call it lexer

i dont like how he is doing things, which he would go more incrementally,
have you write code, run it, test it, write more code, incrementally
and not just dump everything at first, importing this and that, not really
explaining much

### Error handling

so all we have done as of now is, very simple
not even really started with the lexor or tokenizer. only
opening file, and get string from repl and feeding it
to a tokenier which is not implemented yet

is tokenizer, lexer and scanner the same?

> But if you care about making a language that's actually
> *usable*, then handling errors gracefully is vital.

> it's up to us to give the user all the information
> they need to understand what went wrong and guide
> them gently back to where they are trying to go.

tthis is some very unix haters manual

```Error: Unexpected "," somewhere in your code. Good luck finding it!```

how is rust error reporting so good?

> We'll use this to ensure we don't try to execute code that
> has a known error.

what would happen if you did?

> Also, it lets us exit with a non-zero exit code
> like a cood command line citizen should.

yup yup

> The other reason I pulled the error reporting out here
> instead of stuffing it into the scanner and other phases
> where the error might occur is to remind you that it's
> **good engineering practice** to seperate the code that
> generates the errors from the code that *reports* them

never reported errors from my projects, no bueno

how do you report errors, to stderr, ide error window? do you just return the error code, and ide will handle it?

what is stdderr?

> Let's get more precise about what tokens are

were are officially starting

### Lexemes and Tokens

heres a line of lox code

```var language = "lox";```

so here

* var is a *keyword* declaring a variable, the three character sequence "v-a-r" means something

> but if we yank three letters from *language*, like "g-u-a", those don't mean anything on their own.

> That's what lexical analysis is about.

> Our job is to scan through the list of characters and
> group them together into the smallest sequences that
> still represent something

> each of these blobs is called a **lexeme**.

```var language = "lox";```

the **lexeme's here are

* var
* language
* =
* "lox"
* ;

so these are not tokens?

> lexemes are only the raw substrings of the source code

> When we take the lexeme and bundle it together
> with that other data, the result is a token

#### Token type

> Keywords are part of the shape of the language's grammar,
> so the parser often has code like, "If the next token is
> ```while``` then do..." That means the parser wants to know not just that it has a lexem for some identifier,
> but that it has a *reserved* word, and *which* keyword it
> is

not really following

tokentype, where is the token fora comment?

so we will compare the lexemes, and categorized them into what they are?

```var language = "lox";```

is

```
var: KEYWORD
language: IDENTIFIER
=: EQUAL
"lox": STRING
;: SEMICOLON
```

> at the point that we recognize a lexeme, we also
> remember which *kind* of lexeme it represents.

#### Literal value

> Since the scanner has to walk each character in the literal to correctly identify it

so like "lox"
         123 ?

>  it can also convert that textual representation of a value to the living runtime object that will be used by the interpreter later.

bro what? convert the lexeme into an object created in runtime?

#### Location information

so when you have an error in the source code, you can
point to a location and say, heres the error?

### Regular Languages and Experssions

> Now that we know what we're trying to produce

trying to make tokens out of source code right?

we want lexemes, and then we want to assign a token type
to them?

> The core of the scanner (in our case we will call it lexer) is a loop
> Starting at the the first character of the source code,
> the scanner figures out what lexeme the character belongs
> to, and consumes it, and any folling characters that are
> part of that lexeme. *When it reaches the end of that
> lexeme, it emits a token*

>  Then it loops back and does it again, starting from the
> very next character in the source code

does it have 2? why cant it go from the end of the lexeme?

*regex* pops up everywhere

> **The rules that determine how a particular language groups
> characters into lexemes are called its lexical grammer**

could you make a lexical grammer file, and feed it to
some compiler compiler?

lox grammer is so simple, its classified as a **regular language**

the same regular as regular expresion

were are skipping over alot of theory

**Chomsky hierarchy** and **finite-state machines**

have heard and used the latter?, reading the *Dragon book*
wont hurt

> Tools like **Lex** or **Flex** are designed expressly to
> let you do this, throw a hanful of regexes at them, and they give you a complete scanner back

wow

> Lex was created by Mike Lesk and Eric Schimdt. Yes, the
> same Eric Schmidt who was executive chairman of Google.

we will make our own scanner

in java ill call it lexer, so that it wont collide
with the scanner.input thing in Lox

### The Scanner Class

why the sigma

Lexer: error: cannot find symbol
 scanToken(); //yeah im defining it?, also cant find EOF

this is kinda annoying tbh, i wont quite doe,

also not a fun of all this, oop "clean code" type shit type shit
