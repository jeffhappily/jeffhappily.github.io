---
title: Writing correct software is hard
draft: true
---

It's known in the industry that writing correct software is hard, if you don't feel the same way, you might be doing it wrong. Correctness has a [formal definition](https://en.wikipedia.org/wiki/Correctness_(computer_science)), but you can also see it as doing things as *expected*. One reason why it's hard to write correct software is often that our expectations are rather vague and informal, without having clear expectations, it's hard to define what does it mean to be *correct*.

Let's start by defining an trivial expection for the code we're going to write. We want a function that takes in a number and returns xxx, in JavaScript, we can simply define it like this
```js
function f(n) {
  // do something
}

// some test cases
expect(f(1)).toBe(2)
expect(f(2)).toBe(3)
expect(f(5)).toBe(6)
```
So does it meet our expectation? Even though everything seems alright and we have some test cases as well, but it's actually not correct because it allows *undefined behavior*, for example we can pass in a string to the function and it will crash, not quite what we expected isn't it?

```js
f("hello");
// Crashes when called
```

## Static Type System to the resque
One simple way to resolve this is to introduce type system, let's switch to TypeScript!
```ts
function f(n: number) {
  // do something
}
```
With that, when we try to call our function with a string and it won't compile. It stops us from even trying to using it in a wrong way!
```ts
f("hello");
// Won't compile
```
People always have this misconception that the type system gets into your way when you're writing programs, but that's just not true, type system is there to help you better describe what you expect from the program and eliminate some of the *undefined behavior*s.
