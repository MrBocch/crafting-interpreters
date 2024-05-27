## Introduction

> because they tell us that dragons
> can be beaten

i wonder if he mentions beating dragons, because of that compiler
book with a dragon on the cover.

> It's the book I wish I'd had
> when I first started getting
> into languages, and it's the
> book I've been writing in my
> head for nearly a decade.

Its the X i wish i had when i first started

i really love this way of thinking.

> this text is lighter on theory
> than others

> I will introduce the history and
> concepts behind it

PL researchers have fun?

if it were a heavy on theory book
than i would probably get filtered and drop it

> Static type systems in particular
> require rigorouse formal reasoning.
> Hacking on a type system has the same feel as proving a
> theorem in mathematics

probably not C type like system?

> the Curry-Howard isomorphism

proof theory, Coq, interesting

### Why Learn This Stuff??

> I don't think ornithology books
> worry about justifying their
> existence. They just assume the
> reader loves birds and start
> teaching.

making a succesfull language (general-purpose) is very dificult. I think its because people sort of huddle to whats popular and dont dare venture off into something else

im reading this because i want to learn. make my own fun

### Little languages are everywhere

Domain Specific Languages

niche languages tailor-built for
a very specific task

* scripting languages
* template engines
* markup formats
* configuration files

i ran into
- yaml
- json
- jinja
- html, css
- SQL

ok, cpp or asp.net are not little languages

things that go into a language

* documentation
* debuggers
* editor support
* syntax highlighting
* there is other stuff

makes no sense to "rolling your own"

### Languages are great exercise

> Implementing a language is a real test of
> programming skill. The code is complex
> and performance critical

You must master
* recursion
* dynamic arrays
* trees
* graphs
* hash tables

### One more reason

> language hackers were a different breed of human
> some sort of wizards granted privileged access to arcane
> arts

ikr

> And its practitioners don't hesitate to play up this image
> Two of the seminal text on programming languages feature
> a dragon and a wizard on their covers

"https://en.wikipedia.org/wiki/Compilers:_Principles,_Techniques,_and_Tools"
the dragon book and SICP

i have read some of SICP but then got filtered around the
part of making change with coins. i should not give up.

> It's just code, and the people who hack on languages are just people

### How the Book is Organized

1st orients you, teaches lingo, introduces the Lox

2nd code for interpreter, there will be 2 interpreters

### The code

> Every single line of code needed is included

compiler compilers?
tools created to ease the making of compilers

* Lex

* Yacc

is a tool that takes in a grammar file and produces a
source file for a compiler

* Bison

is tree sitter also one of these?

I have heard of Yacc from The Unix Haters Manual

> We will abstain from using them here

ok great, I will understand everything by the end

does not include build instructions or how to use IDE
so that book ages well, sounds good but what does
XO brandy mean? oh a its a drink

### Snippets

wow very neat,

### Asides

i think he is talking about the litthe sentences below
a paragraph

### Challenges

you dont have to do them but if you do try
you will learn about other languages, implementing features
 etc

### Design notes

so most programming language books solely care
about implementing the language not how to design one

you can have an entire carrer just implementing languages?

try making your own C compiler

> Hopefully your new language doesn't hardcode assumptions
> about the width of a punched card into its grammer

did FORTRAN 77 do this?

it must have because i have heard of punch hole programming in fortran

### The First Interpreter

first interpreter will be in java. so that we can focus
on the concepts

but they are also versions of this book
that implement Lox in other languages. [ https://github.com/munificent/craftinginterpreters/wiki/Lox-Implementations ] seems like a fun project, to implement Lox in a different language

what about implementing the Lox interpreter in Lox?

> A compiler reads files in one language, translates them, and outputs files in another language.
> You can implement a compiler in any language, including the same language it compiles, a process called self-hosting

first you write the compiler in a language you are comfortable with, once you have the compiler you can write
another compiler in the language, once you have the second compiler in the language you can discard the first compiler.

bootstrapping

self-hosting and bootstrapping are not the same thing

with java, we will have a slow but *correct* implementation

> However, we are only able to accomplish that by building on the Java virtual machine's own runtime facilities. We want to learn how Java itself implements those things

the only java experience i have is from my OOP class
in uni which sucked and it was basically an introductory
class to programming without any of the OO in OOP

### The Second Interpreter

The second interpreter in C. Hopefully i dont
get skilled-issued. Everybody must know C, you can do it

> C is the perfect language for understanding how an
> implementation really works, all the way down to the
> bytes in memory and the code flowing through the CPU

what is C particularly good at? My guess is its has so
little features that it wont get in the way like other
bigger languages do

may languages are implemented in C

* Lua
* CPython
* Ruby MRI

i have experience in all these languages lol. Dont understand what the ruby **MRI** thing means

> In our C interpreter, clos, we are forced to implement
> for ourselves all the things Java gave us for free.

very true, C has like nothing

> We'll write our own dynamic array and hash table
> We'll decide how objects are represented in memory, and build a garbage collector to reclaim them.

I will learn alot from doing these things

what is he talking about here?

> I pronounce the name like “sea-locks”, but you can say it “clocks” or even “cloch”, where you pronounce the “x” like the Greeks do if it makes you happy.

**java** for being correct

**C** for going fast

> Our C interpreter will contain a compiler that
> translates Lox to an efficient bytecode representation
> which it then executes. This is the same technique
> used by implementations of Lua, Python, Ruby, PHP,
> and many other successful languages

i have heard that Java, takes runs java bytecode
and that other languages run on the same jvm (java virtual machine) so i guess these languages also
convert to the same java byte code?

> It's a compiler book as well.

ok neat!

### Challenges

#### 1. There are at least six domain-specific languages used in the 'little system I cobbled together'

What are they?

the .gitignore

the make file

markdown

is he talking about the the languages used in the github repo?

#### 2. Get a 'Hello, world' program written and running in java.

i dont want to use IDE's or debuggers, i dont like them.
Ill prob have to use these in a job or something so just learn

#### 3. Do the same for C.

Define a double linked list of heap-allocated strings.
Write functions to insert, find, and delete items from it. Test them.

very difficult but you souldnt be afraid of data structures

### Design Note: What's in a name?

chosing a name is hard appeartly

* it cant be in use by someone else

* it's easy to pronounce

* its distinc enough to search for

so that people can easily google it

* It doesn't have negative connotations across a number of cultures

So appereantly the Nim programming language first
Nimrod but ending up renaming because Bugs Bunny used
Nimrod as an insult.

You would think a zoomer lang would not have known that lol

Its been so longed since i programmed in C
ruby and python have spoiled me. I have to
implement a doubly linked list or else im
not a real programmer
