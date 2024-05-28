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

> Baking *print* into the language
