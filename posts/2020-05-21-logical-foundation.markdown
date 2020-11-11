---
title: Logical Foundation
draft: true
---

I've been reading the book [Logical Foundation](https://softwarefoundations.cis.upenn.edu/lf-current/) and I'm writing this post to summarize what I've learned and to keep track of my learning progress.

Logical Foundation is an introductory book to the Logic and Mathematics behind Computer Science, and the whole book uses Coq, the proof assistant to convey its idea. A proof assistant is essentially a programming language with extra tools to help you state and prove your logical assertions.

# Intro to Coq

## Datatype
Let's start with defining some data type in Coq, since it's the most basic construct of a programming language.

You can use the `Inductive` keyword to define a simple inductive type, if you don't know what an inductive type is, think of it as a sum type, a tagged union or an enum.

Here's an inductive type called `day` representing all the days in a week.
<!-- TODO fix this, supposed to be coq -->
``` haskell 
Inductive day : Type :=
  | monday
  | tuesday
  | wednesday
  | thursday
  | friday
  | saturday
  | sunday.
```
