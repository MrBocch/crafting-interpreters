## A Map of the Territory

I loved LOTR, where is this quote from?

> Much of this book is about a language's implementation,
> which is distinct from the language itself in some
> soft of Platonic ideal form.

what is this Plato stuff about?
im an uneducated swine

will he talk about Lox's language specification?

### The Parts of a Language

the way of building computer languages has not
changed much since they first built computers

the picture of the mountain

beggining mountain, we have the raw source code,
literally a string of characters

so at the peak of mountain, we see what
their code *means*

at the other side of mountain, how to make
the CPU actually execute

src code -> scanning -> tokens -> parsing -> syntax tree it splits of here

syntax tree -> transpiling -> high-level language

syntax tree -> analysis -> optimizing (INTERMEDIATE REPRESENTATION(S)) -> code generation

code generation -> transpiling -> high-level language

code generation -> bytecode -> virtual machine

code generation -> machine code

we will go from the very beggining

### Scanning

> The first step is scanning, also known as lexing or if trying to impress
> someone **lexical analysis**

> "Lexical" comes from the Greek root "lex" meaning "word"

oh kool

> A lexer takes in the linear stream of characters and chunks them together
> into a series of something more akin to "words"

> In programming languages, each of these words is called **tokens**

They are all kinds of tokens

* ')'
* 'var'
* '='

the point is to take something like this

```
// variable average
var average = (min + max) / 2;
```

and only take the things we care about, so no white spaces or comments

* var
* average
* =
* (
* min
* +
* max
* )
* /
* 2
* ;

### Parsing

> The next step is **parsing**. This is hwere our syntax gets a **grammer**
> the ability to compose larger expressions and statements out of smaller parts

hmm

> A **parser** takes a flat sequence of tokens and builds a tree structure that
> mirros the nested nature of the grammer.

> These trees have a couple of different names **parser tree** or
> **abstract syntax tree** depending on how close to the bare syntactic structure of the source language they are.

I have heard of **AST** when i was learning about lisp

look at the tree. its saying

**Stmt.Var average**, is equal to **Expre.Binary /**, **Expr.Literal 2** and **Expr.Binary +** **Expr.Variable min max**

How do you evaluate this tree?

Do you start by evaluating the very bottom up? what about lazy evaluation?
Do you evaluate tree untill the very last moment when its needed?

> Parsing has a long, rich history in computer science that is closely tied
> to the artificial intelligence community. Many of the techniques used today
> to parse programming languages wer originally conceived to parse *human* languages by AI reserachers who were trying to get computers to talk to us.

oh wow, very interesting. Something i dont understand is why was LISP the language for AI at MIT?

> The parser's job also includes letting us know when we do by reporting
> syntax errors.

rust parser must be very big compared to something like C.

### Static analysis

So the first 2 steps are very similar for every language

> At this point, we know the syntactic structure of the code
> Things like which expressions are nested in which, but we don't know
> much more than that

hmm

> In an expression like ```a + b``` we know we are adding **a** and **b**, but
> we don't know what those names refer to. Are they local variables? Global?
> Where are they defiend?

o wow. very interesting

isint **+** also not defined?

> The first bit of analysis that most languages do is called **binding** or
> **resolution**. For each **identifier**, we find out where that name is
> **defined** and wire the two together.

> This is where **scope** comes into play, the region of source code where a
> certain name can be used to refer to a certain declaration.

so what datastructure is used to keep track of all the variables defined?

a stack?

> If the language is statically typed, this is when we type check. Once
> we know where **a** and **b** are declared, we can also figure out their
> types. THen if those types don't support being added to each other, we report
> a **type error**

this is so much fun

> Lox is dynamically typed, so it will do its type checking later, at runtime.

so after all of this, we reached the peak of the mountain?

> All this semantic insight that is visible to us from analysis needs to be
> stored somewhere. There are a few places we can squirrel it away

> it gets stored right back as **attributes** on the syntax tree itself
> extra fields in the nodes that aren't initialized during parsing but get
> filled in later

> we may store data in a lookup table of to the side. Typically, the keys
> to this table are identifiers, names of variables and declarations. In that
> case, we call it a **symbol tree** and the values it associates with each
> key tell us what the identifier refers to.

so its saying you could use a hashmap?

so a

```
let a = 10
```

is turned to?

```
variables[name_token] = value_token
```

or you could transform the tree into another entirely new data structure that
more directly expresses the semantics of the code??

very interesting

> Everything up to this point is considered the **front end** of the
> implementation.

the **back end** is not necesarily the next part, back then yes but not anymore
they are new techniques invented

so what is **LLVM** ?

**LLVM** is a back end compiler, you can make a frontend compiler, feed it
into llvm and it would generate the binary for you? how neat

they are several languages that use LLVM

### Intermediate representations

> the compiler as a pipeline where each stage's job is to organize the
> data representing the user's code in a way that makes the next takes simpler
> to implement

> The front end of the pipeline is specific to the source language the
> program is written in

> The back end is concerned with the final architecture where the program will
> run

so the front end prepares the code so that it could be feed into the backend

the backend prepares the code so that it could be ran on any architecture?

> In the middle, the code may be stored in some **intermediate representation**
> or **(IR)** that isn't tightly tied to either the source code or destination
> forms (hence 'intermediate'). Instead, the IR acts as an interface between
> these two languages

Is the **IR** another form of a programming language?

*C--* i s an intermediate language?

oh this makes alot of sense

> This lets you support multiple source languages and target platforms with
> less effort.

> Say you want to implement Pascal, C, and Fortran compilers, and you
> want to target x86, ARM, ... SPARC. Normally that means you're signing up to
> write nine full compilers

so what would it be

```
Front end + Back end

C -> x86
C -> ARM
C -> SPARC

Pascal -> x86
Pascal -> ARM
Pascal -> SPARC

Fortran -> x86
Fortran -> ARM
Fortran -> SPARC
```

> A shared intermediate representation reduces that dramatically. You write
> *one* front end for each source language that produces the IR. Then
> *one* back end for each target architecture

yeah so now it would be like this

```
Front end

C       -> IR
Pascal  -> IR
Fortran -> IR
```

```
Back end

IR -> [target architecture]
```

what if i made Lox frontend to use llvm backend?

> They are few well-established styles of IR's
> look for "control flow graph", "static sing-assignment", "continuation-passing style", and "three-address code"

This is how **GCC** supports so many crazy languages and architectures

> Language front ends target on of a handful of IR's, mainly
> **GIMPLE** and **RTL**. Target back ends like the one for 68k then
> takes those IR's and produce native code.

but **also**

> There's another big reason we might want to transform the code into a
> form that makes the semantics more apparent...

is jvm bytecode a form of IR?

could i make my own language front end that targets jvm IR?

### Optimization
