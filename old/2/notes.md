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

each is a token?

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

> Once we understand what the user's program means, we are free to swap it
> out with a different program that has the
> same *semantics* but implements them more
> efficiently, we can **optimize** it

what does it mean by semantics

one example of optimizing is **constant folding**

> if some expression always evaluates to the
> exact same value, we can do the evaluation
> at compile time and replace the code for
> the expression with its result

```
pennyArea = 3.13159 * (0.75 /2) * (0.75 /2);
```

this would be optimized into

```
pennyArea = 0.441...
```

how much of a difference is this doing?

> Optimization is a huge part of the programming
> lanugage business.

this is an easy example, but how do you know
you are not breaking what the user intended?

> Many successful languages have suprisingly
> few compile-time optimizations. For example,
> Lua and CPython generate relatively unoptimized code
> and focus most of their performance effort on
> the runtime

premature optimization is "the root of all evil"

what does this even mean

* constant propagation
* common subexpression elimination
* loop invariant code motion
* global value numbering
* strength reduction
* scalar replacement of aggregates
* dead code elimination
* loop unrolling

### Code generation

> The last step is converting it to a form
> the machine can actually run.

**generating code** like binary?

> where "code" here usually refers to the kind
> of primitive assembly-like instructions a CPU
> runs and not the kind of "source code" a
> human might want to read

we are in the back end part

> We have a decision to make

> Do we generate instructions for a real CPU
> or a virtual one?

if you generate native machine code,
its really fast but, its really complex
and only works for that architecture and os?

> Today's architectures have piles of
> instructions, complex pipelines

> your compiler is tied to a specific architecture

> ducring the Cambrian explosion of computer
> architectures, that lack of portability was
> a real obstacle

what is this Cambrian explosion ??

so, if you want to build a computer language,
you dont necesarily nead to know assembly for
the architecture?

could you really build a computer language just
by converting source code to asm?

I need to actually learn ASM one of these days

* Martin Richards, BCPL
* Niklaus Wirth, Pascal fame

> they made their compilers produce virtual
> machine code. Instead of instructions for
> some real chip, they produce code for a
> hypothetical, idealized machine. Wirth
> called this **p-code** for portable, but
> today we generally call it **bytecode**

> because each instruction is often a single
> byte long

so is **bytecode** a form of IR?

> These synthetic instructions are designed
> to map a little more closely to the
> language's semantics, and not be so tied
> to the peculiarities of any one computer
> architecture

how is this different from a vm?

### Virtual machine

cpu cant understand the bytecode so what now?

> You can write a little mini-compiler for each
> target architecture that converts the bytecode
> to native coe for that machine

how is this different from a vm?

> You are basically using your bytecode as an
> intermediate representation

you would still have to write a compiler for
each architecture, but again as in IR you
share alot of the front end stuff?

> The basic principle here is that the
> farther down the pipeline you push the
> architecture-specific work, the more
> of the earlier phases you can share across
> architectures

> Or you can write a **virtual machine (VM)**

> a program that emulates a hypothetical chip supporting your
> virtual architecture at runtime.

> RUnning bytecode in a VM is slower than translating to native code
> ahead of time because in a VM is slower than translating it to
> native code ahead of time because every instruction must be simulated
> at runtime each time it executes. In return you get simplicity and
> portability

> Implement your VM in, say C and you can run your language on any
> platform that has a C compiler

this is wahat we do with out second interpreter

Is it really as easy as that? Different architectures wont affect the vm?

*No because the vm is simulating a hypothetical chip.*

### Runtime

now we need to start up the VM and feed it the bytecode

so **javac** takes source code and returns **bytecode**

and **java** is the vm that takes in **bytecode**

you can use ```javap -c javaprogram``` to look at the bytecode
generated

> for all but the basest of low-level languages, we usually
> need some service that our language provides while the program
> is running

> if the language automatically manages memory, we need a **garbage collector**

> if our language supports "instance of" test so you can see what kind
> of object you have, then we need some representation to keep track of the type
> of each object during execution

what about staticaly typed languages, they dont have to check right?

> All this stuff is going at runtime, so its called, appropriately **runtime**

o wow look at this

> In a fully compiled language, the code implementing the runtime gets
> inesrted directly into the resulting executable.

> In say **Go**, each compiled application has its own copy of
> Go's runtime directly embedded in it.

so in each go binary, there is the code of the program, but also its
garbage collector?

> If the language is run inside an interpreter or VM, then the runtime
> lives there

kinda confused on what an interpreter is now.

### Shortcuts and Alternate Routes

they are other ways of doing things

#### Single-pass compilers

back when computers were very limited in memory
they would produce output code directly in the parser, without
ever allocating any syntax trees or other IR's

> You have no intermediate data structures to store global information
> about the program

> as soon as you see some expression, you need to know enough to
> correctly compile it.

* Pascal
* C

i think it goes on to say, thats why in C you needed to write
function prototypes

it does not say that actually pay attention

> in C you can't call a function above the code that defines it
> unless you have an explicit forward declaration

so its saying you cant

```
int x = add(4, 10);

int x(int a, int b){ return a + b}
```

no bueno, it does not know what add() is untill the next line, its going
line by line, not parsing everything and going back to read the code?

**Syntax-directed translation**, what is this?

#### Tree-walk interpreters

> Some programming languages executing code right after parsing it
> to an AST (..). To run the program, the interpreter traverses the
> syntax tree one branch and leaf at a time, evaluating each node
> as it goes.

this seems like fun

> common for student projects and little languages

tends to be slow

> Some people use "interpreter" to mean only these kinds of implementations,
> but others define that word more generally.

> Our first interpreter rolls this way.

neat

Early versions of ruby wer tree walkers

at ruby 1.9, they switched to YARV (Yet Another Ruby VM). YARV is a
bytecode virtual machine

so when you run any ruby programm. it generates the bytecode first then
it begins running the bytecode thrue the vm?

why in java you have to use javac, but in ruby theres no rubyc?

#### Transpilers

> Writing a complete back end for a language can be alot of work.

> If you hae some existing IR to target, you could bolt your front end
> onto that

> What if you treated some other *source language* as if it were an
> intermediate representation?

So you would write the frontend for your language, then in
the backend you would target another higher level language and use
their back end.

> They used to call this a **source to source compiler** or a
> **transcompiler** or **transpiler**

very popular because they wanted to, compile their language
into javascript to run on the browser

i have run into several transpilers like,

Fennel https://fennel-lang.org/ | https://fennel-lang.org/see

they target the lua vm?

The first transpiler was written by Gary Kildall,
very interesting fella. 8080asm to 8086asm,
sea captain, business owner, licensed pilot and motorcyclist
TV host, mysterious death

> After the *viral* spread of UNIX to mahcines various
> and sundry, there began a long tradition of compilers
> that produced C as their output language.

did not knew that

they did this because C compilers were available everywhere

and now the *new C* is javascript because everybody uses a browser

> so these days it seems almost every language out there has a compiler
> that targets JS since that's the main way to get your code running in
> in a browser

js is not the only way anymore **WebAssembly**

programming languages target **webassembly** so that they can run
in browser

#### Just-in-time compilation

**JIT**

so you would have a jvm or runtime, an analyzer would look
at the code, and decide to compile it some of it to native code for the architecture of the computer

### Compilers and Interpreters

back when first starting i thought

compilers, took code and made an executable for your computer

interpreters, is an executble that takes codes and runs it

its correct but its not always so cut and dry

what about a compiler that takes source and turns it to bytecode,
and this bytecode is then feed into a vm? (like CPython?)

From the user's perspective CPython is interpreted, but there is
definitely some compiling going on.

it can be both

compilers

* javac
* gcc
* rust
* clang

interpreter

* MRI (Ruby)
* jlox
* php3

both

* C#
* Haskell
* CPython
* Lua
* Go
* Scala

i guess they are not many languages that are purely interpreted because
it must be very slow?

and *Go* is even weirder

```go build``` compiles Go source code to machine code

```go run``` it still compiles it but it runs it immediatly after only apearing
to be interpreted

So we will compile to bytecode and make a virtual machine for it?

### Our Journey

> Don't worry. This isn't the chapter where you're expected to *understand*
> all of these pieces and parts

### Challenges

1. boring

2. what reasons are there to not JIT?

its complex, security concerns, and hard to predict performance?

3. Most lisp implementations that compile to C also contain an interpreter
that lets them execute lisp code on the fly as well. Why?

My guess is so that they can use a REPL
