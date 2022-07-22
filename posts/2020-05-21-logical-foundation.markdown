---
title: Logical Foundation
draft: true
---

I've been reading the book [Logical Foundation](https://softwarefoundations.cis.upenn.edu/lf-current/) and I'm writing this post to summarize what I've learned and to keep track of my learning progress.

Logical Foundation is an introductory book to the Logic and Mathematics behind Computer Science, and the whole book uses Coq, the proof assistant to convey its idea. A proof assistant is essentially a programming language with extra tools to help you state and prove your logical assertions.

# Datatype

Let's start with the programming language part of Coq, Coq includes a functional programming language called _Gallina_. It provides the familiar building blocks simliar to other functional programming language such as _algebraic data type_ and _pattern matching_.

You can use the `Inductive` keyword to define a simple inductive type, if you don't know what an inductive type is, it's an one-of type, think of it as a sum type, a tagged union or an enum.

Here's an simple example taken from _Logical Fondation_, it defines an inductive type called `day` representing all of the days in a week.

<!-- TODO fix this, supposed to be coq -->

```haskell
Inductive day : Type :=
  | monday
  | tuesday
  | wednesday
  | thursday
  | friday
  | saturday
  | sunday.
```

To operate on this newly defined data type, we can define a function using the `Definition` keyword.

```haskell
Definition next_weekday (d:day) : day :=
  match d with
  | monday => tuesday
  | tuesday => wednesday
  | wednesday => thursday
  | thursday => friday
  | friday => monday
  | saturday => monday
  | sunday => monday
  end.
```

This a simple function called `next_weekday` that takes in a `day` as an argument and returns a `day` type, what it does is simply pattern matches on the given `d` and returns the next weekday.

Note that in this example, the types are annotated properly although they are not required as Coq can do _type inference_ based on your definition. But in general, it's a good style to include your type in to help the compiler and to serve as a documentation.

We can evaluate the function by using `Compute`.

```haskell
Compute (next_weekday friday).
-- (* ==> monday : day *)
```

# Assertion and Proof

TODO
