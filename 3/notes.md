### The Lox Language

explaining what Lox is

i heard of this term before **language lawyer**
for c++

## Hello, Lox

```
// Your first Lox program!
print "Hello, world";
```

> Lox's syntax is a member of the C family

so // for comments and ';' @ the end of statements

what if i wanted something else at the end of a line? or nothing at all? what then?



> There are no parentheses around the string
> because print is a built-in statement, and not
> a library function

interesting

> Dennis Ritchie had this idea called "declaration
> reflects use", where variable declarations
> mirror the operations you would have to
> perform on the variable to get to a value
> of the base type

what does the last part mean, "to get a value of the base type" ???

> Lox doesn't have static types, so we avoid that

types are not known at compile time?

### A High-Level Language

meaning, we wont do any memory manegment in
Lox?

small but usefull high-level "scripting" languages

* js (urhmmm?)
* Scheme
* Lua

> Lox looks most like js, mainly because most C-syntax languages do

> Lox's approach to scoping hews closely to Scheme

what does this mean?

> The C flavor of Lox we'll biuld in Part 3 is heavily indebted to Lua's clean, efficient implementation.

also using lua to implement lox?

### Dynamic typing

> variables can store values of any type

any language could do that

> a single variable can even store values of different types at different times

> If you try to perform an operation on values of
> the wrong type, say dividing a number by a
> string, then the error is detected and reported
> at runtime

i can get if you could only catch it at runtime
if you are using tree walk interpreter, could
the bytecode compiler not catch it? no bc it
does not know its type?

### Automatic memory management

> They are two main techniques for managing memory
> **reference counting** and **tracing garbage collection** usually just called **garbage collection** or **GC**

perl, php and python started out with reference counting but, reference counting has its limitations

> All of those languages eventually ended up adding a full tracing GC, or at least enough
> of one to clean up object cycles

I'v always programmed in high level languages to build anything, so managing memory seems kinda scary

**A Unified Theory of Garbage Collection**, dead link, make an issue on github?, i wont im too shy

THIS GUY ALSO MADE THE DART PROGRAMMING LANG? WOW

> Tracing garbage collection has a fearsome reputation. It is a little harrowing working at
> the level of raw memory.

debugging a GC is scary

### Data Types

what built-in data types does Lox have?

**Booleans**

you know, true or false.

Thank you George Boole, we stand on shoulder of giants, before computers were ever made

can expressions be converted to booleans?

(5 > 10) == true ?

**Numbers**

> Lox has only one kind of number: double-precision floating point

you can even represent integers?

i guess it makes it easier to do arithmetic all on the same data type

**Strings**

heap allocated? or on the stack?

no implicit conversions?

> As we'll see when we get to implementing them,
> there is quite a lot of complexity hiding in
> that innocuous sequnce of characters

oh yeah, is it only asci ? rust strings are
what utf-8? if it supports utf8 can you save
variables as emojis?

> error: identifiers cannot contain emoji 😃 lol

i remember seeing a language that does allow you
to use emojis as identifiers

so only switf allow it

**Nil**

represents, *no value*

> There are good arguments for not having null
> value in a language since null pointer
> errors are the scourge of our industry

it would be worth not having one in a statically typed language, but not dynamically?

### Expressions

> If biult-in data types and their literals are
> atoms, then **expression** must be the molecules.

so expressions, are a collection of atoms that
will be evaluated?

#### Arithmetic

all the basic operators

** +, -, \*, / **

i guess we will follow pemdas

**infix operators**, are they harder to parse?
than prefix **operators?**

> The subexpressiosn on either side of the operator are **operands**. Because there are
> two of them, these are called binary operators

are **postfix operators** for stackbased languages?

some operators have more than two operands
like the ternary operator ```cond ? then : else```

**mixfix operator**

the ```-``` operator is both infix and prefix,
you could use to negate a number

```-nagateMe;```

they only work on numbers but you could also
add strings together to concat them

```
"hello " + "world"
```

what if you wanted to do numbers?

```
age = 22

print "im " + age + " years old"
```

i guess the **age** would have to be converted to a string

#### Comparison and equality

a few more operators

the comparison operators

```
<, >, <=, >=, ==, !=
```

can also compare values of different types,
they wont return error, but will always return false, no implicit conversions

#### Logical operators

so the **not** prefix operator

``` !true == false ```

and **and, or**

#### Precedence and grouping

> All of these operators have the same
> precedence and associativy that you'd
> expect coming from C.

will go more into detail when parsing

but you can use () to group stuff

```
10 + 2 * 3
// or
(10 + 2) * 3
```

no **bitwise**, **shift**, **modulo**
or **conditional operators**

> Those are the expression forms

forms in lisp were not functions but their
own special thing, like (if) and other things

i uderstand why a highlevel language would not
have bitwise or bit shifting, but modulo is genuinely useful

### Statements

> Where an expression's main job is to produce
> **a value**

> A statement's job is to produce an effect

> Since by definition, statements don't evaluate to a value, to be useful they have to otherwise
> *change the world in some way*

```
print "hello world"
```

> Baking *print* into the language instead of just making
> it a core library function is a hack

> But it's a useful hack for us it means our in-progress
> interpreter can start producing output before we've
> implemented all of the machinery required to define
> functions, look them up by name, and call them

wow never thought of that.

**expression statement**

You can pack a series of statements where a single one is
expected using, the {} just like in rust

### Variables

Initialize variables with **var**

```
var a = "hi"
var b;
```

so thats why not having nil is annoying.

you could access the variable and also reasignet a different value with out the var thing

but what if you did? i guess it would be the same shit right?

### Control Flow

So scheme has no buil-in looping constructs, dont remember
using any loops in SICP. Was not so freaked out from this coming from learning some haskell, functional languages do everything thrue recursion

but this is very interesting

> Smalltalk has no built-in branching constructs, and relies
> on dynamic dispatch for selectively executing code

i cant imagine a language **with out** branching constructs

pretty much the same syntax from C
if/else, while(true), for(loops)

why cant you have a for x in y loops?

Theres alot of things i love from other languages, but they
dont seemed to be implemented in lox, could i add them?

> This is a concession I made because of how the implementation is split across chapters. A for-in loop needs some sort of **dynamic dispatch in the iterator protocol to handle different kinds of sequences**, but we don’t get that until after we’re done with control flow. We could circle back and add for-in loops later, but I didn’t think doing so would teach you anything super interesting.

uhh *what?*, is it saying, you would need to do different
things incase its a, string or array?

are they even list in lox?

### Functions

unlike in ruby, or print you have to () the params

```fun hi() {print "hi";}```

if i wanted the no "()" like in ruby, would i have to
change the parser?

yeah i have been confused with this

> Now's a good time to clarify some terminology. Some people
> throw around "parameter" and "argument" like they are
> interchangeable and, to many, they are. We're going to
> spend a lot of time splitting the finest of downy hairs

> An **argument** is an actual value you pass to a function
> when you call it. So a function *call* has an **argument**
> list. Sometimes you hear *actual parameter* used for these.

> A **parameter** is a variable that holds the value of the
> argument inside the body of the function. Thus, a function
> declaration has a *paramter* list. Others call these
> *formarl parameters* or simply *formals*

so, they are **arguments** when you call a function

and **parameter** when you define or declare function

define'ing and declare'ing functions in C are different you because, its statically typed,

> A declaration binds the function's type to its name so
> that calls can be type-checked but does not provide a body

lox is dynamically typed, so it checks at runtime, no need to declare it

functions can return things

if you dont return anything, then the function will return
nil

### Closures

closures are anon functions? -> NO

> Functions are first class in Lox

they are treated as if they were anything else.

> Since function declarations are statements, you can
> declare local functions inside another function

alot of stuff comes from lisp

here it explains what a closure is

```
fun returnFunction() {
    var outside = "outside";

    fun inner(){
        print outside;
    }

    return inner;
}

var fn = returnFunction()
fn();
}
```

> Here, *inner()* accesses a local variable declared outside
> its body in the surrounding function. Is this kosher? Now
> that lots of languages have borrewed this from Lisp, you
> probably know the answer is yes.

> For that to work inner() has to "hold on" to references to any surrounding
> variables that it uses so that they stay around even
> after the outer function has returned.

> We call functions that do this **closures**

thank you **Peter J. Landin**

> he invented damn near half the terms in programming
> languages. Most of them came out of one incredible paper,
> **"The Next 700 Programming Languages"**

how do you programm this?

### Classes

Lox is about halfway to being functional, but it will
also be halfway object oriented

#### Why might any language want to be object oriented?

from what i understand, back then OOP was sold as
the solution for everything, the silver bullet

they can be very handy to group things together

> If we can also hang methods off of those, then we
> avoid the need to prefix all of our functions with
> the name of the data type they operate on to
> avoid **colliding** with similar functions for different
> types

> In say Racket, you end up having to name your functions like
> ````hash-copy``` and ```vector-copy``` so that they dont
> step on each other

very annoying isse

can you even have objects in a functional language?

#### Why is Lox object oriented?

every other language has support of oop

#### Classes or prototypes

i have heard of this before, Lua has prototype based objects?

> When it comes to objects, there are actually two
> approaches to them, **classes** and **prototypes**

> In class-based languages, there are two core concepts
> **instances** and **classes**

> **Instances** store the state for each object and have
> a reference to the instance class

> **Classes** contain the methods and inheritance chain.

so a class is the blue print, and a instance is the thing?
atleast from what i understand when using a oop lang

> To call a method on an instance, there is always a level
> of indirection. You look up the instance's class and
> then you find the method there

> **Prototype-based** languages merge these two concepts

> they are only objects, no classes, and each individual
> object may contain state and methods

> Objects can directly inherit from each other (or "delegate to") in prototypal lingo

a little confussing, so the class also has state?

> Do you know what people generally do with all the power
> and flexibilty of prototypes? ... They use them to
> reinvent classes.

i dont get what makes prototypes so differnt

people tend to prefer the class-based approach

> Prototypes are simpler in the language

> Larry Wall, Perl's inventor/prophet calls this the
> "waterbed theory". Some complexity is essential and
> cannot be eliminated. If you push it down in one place
> it swells up in another

hmm

yeah, when i tried to use oop in lua, you either install
a library or, (I got stuck trying to understand how to
use metatables)

#### Classes in Lox

```
class Breakfast {
  cook() {
    print "Eggs a-frying";
  }

  serve(who){
    print "Enjoy your breakfast, " +who+ ".";
  }
}

interesting that you dont have to call use ```fun```
for methods

```
methods, what about attributes?

> classes are first class in Lox

how does that work?

```
// store it in variables
var somevar = Breakfast;
// pass it to functions
somefunction(Breakfast);
```

but you are not initializing it here? why would you want to do this?

instanciate a class
```
var breakfast = Breakfast();
```

> The idea behind object-oriented programming is encapsulating
> behavior *and state* together

> you can freely add properties onto objects
```
breakfast.meat = "sausage"
```
> assigning to a **field** creates it if it doesn't already
> exist

you can access a filed or method on a current object
within the object with ```this```, just like ```self```

the initializer method

```
class Breakfast {
  init(meat, bread){
      this.meat = meat;
      this.bread = bread;
  }
  // ...
}

var morning = Breakfast("bacon", "toast");
```

what if you did not pass in the things?
init boilerplate yuh

#### Inheritance

never liked inheritance

you can inherit methods from multiple classes using
```<``` just like in ruby

> If you konw type thoery

i dont, should I?

```
class Brunch < Breakfast {
  drink() {
      print("gulp")
  }
}
```

watchout because the Brunch also inherits the init
method from Breakfast. What if you made your own init
for Brunch??

> Lox is not a **pure** object oriented language.
> In a true OOP language every object is an instance
> of a class, even primitive values like numbers and Booleans

thats why i like ruby so much

Lox primitive types have no methods or properties

### The Standard Library

thats about it, whats left is the **core** or **standard lib**

> the set of functionality that is implemented directly in the interpreter and that all user-defined behavior is
> built on top of

Lox will just about have no std lib

> If you wanted to turn Lox into an actual useful language,
> the very first thing you hsould do is flesh this out

* String manipulation
* trigonometric functions
* file I/O
* networking
* reading input from the user

what is a programming language without its std lib?

what about doing advent of code in Lox language?

### Challenges

```
1. Write some sample Lox programs and run them
Try to come up with edge case behavior I didn't specify here.
Does it do what you expect? Why or why not?
```

making the things was a little difficult.

First you have to install dart, luckily his machine was also
a mac, so maybe thats why i had so little hickups, anyways i
had to install the correct dart after installing a newer version
that did not support something

```
The lower bound of "sdk: '>2.11.0 <3.0.0'" must be 2.12.0'
or higher to enable null safety.

The current Dart SDK (3.4.1) only supports null safety.
```

brew made things preetty simple

```
brew install dart@2.12

# now i had to unlink the previously installed version

brew unlink dart@3.4 && brew unlink dart@2.12 && brew link dart@2.12
```

lucky me the dart documentation on installing dart is very good

also, making the binary and then moving them over here
caused an issue, atleast with jlox

```
Error: Could not find or load main class com.craftinginterpreters.lox.Lox
Caused by: java.lang.ClassNotFoundException: com.craftinginterpreters.lox.Lox
```

its not a one file binary like clox is,

o wow, jlox is a shell script

ill just use clox

yeah, i was having all kinds of hichups when writing this
bmi calculator lol, also writing with no syntax highlighting
makes me feel like a wizard, could i write my own syntax highlighter?, you could use the C one, they hvae the same syntax

there was a lot of stuff i took for granted like
string interpolation and, the implicit conversion between
numbers to string when print "your bmi: " user.bmi()

```
2. This informal introduction leaves a lot unspecified.
List several open questions you have about the language's
syntax and semantics. What do you think the answers should be?
```

if the language is so small, how easy would it be to go in
there and change things? like, instead of comments being '//'
could i change it to '#' ?

what about other datastructures like list, hashmaps?

i dont like how its inconsistent with how you declare
a function and how you declare a method

the ```fun``` is ommited when declaring a method, dont like it

```
3. Lox is a pretty tiny language. What eatures do you think
it is missing that would make it annoying to use for
real programs? (aside from std lib)
```

again string interpolation, no code editor support for lox

also how do you convert *strings to numbers*, and
*numbers to strings*? i guess this would have to be handled
by the standard library

wow this is alot of fun, i cant wait to make up my own language

### DESIGN NOTE: EXPRESSIONS AND STATEMENTS
