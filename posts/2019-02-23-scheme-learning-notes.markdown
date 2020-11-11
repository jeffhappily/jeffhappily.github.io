---
title: "Scheme Learning Notes"
date: 2018-12-03 18:19:45 +0800
categories: programming
draft: true
---

Scheme is a programming language, and it's a dialect of a programming language called Lisp. Lisp is one of the two oldest programming languages that is still widely used today.

## Expression

Scheme is composed of expression, which is a construct that returns a value.

### Primitive Expression

Primitive is just a set of values of different data types. For example:

```scheme
; Number
1       ; integer
2.0     ; real
3/4     ; rational

; Symbol
x
abc

; Boolean
#t      ; true
true    ; true
#f      ; false
false   ; false

; String
"hello"

; Character
#\c     ; character 'c'
#\A     ; character 'A'
```

### Combination

Expressions can be combined with operators to form a combination. A combination is surrounded by brackets, and it's also known as `s-expression`.

The most common combination is a call expression, which includes an operator and followed by 0 or more operands. Nesting and line breaks are allowed in call expressions.

```scheme
(+ (* 3
      (+ (* 2 4)
         (+ 3 5)))
   (+ (- 10 7)
      6))           ; 57
(quotient 10 2)     ; 5
(not #t)            ; #f
```

## Special Forms

A special form is a combination that is not a call expression, it has the same syntax but comes with special rules.

### Comparison Operator

```scheme
(>= 3 2)                ; #f
(< 5 12)                ; #t
```

### If expression

If expression are expressed in following form:

```scheme
(if <predicate> <consequent> <alternative>)
```

The interpreter starts by evaluating the **\<predicate\>** part, if it evaluates to a **true** value, **\<consequent\>** will be evaluated, otherwise **\<alternative\>** will be evaluated and the resulting value will be returned.

### Boolean Operator

```scheme
(and <e1> ... <en>)
```

Short circuiting is supported in Scheme, which means expression **\<e\>**'s will be evaluated from left to right. If any **\<e\>** evaluates to **false**, **false** value is returned and the rest of the **\<e\>**'s will not be evaluated. If no **false** value is found, the value of the last element is returned.

```scheme
(or <e1> ... <en>)
```

`Or` operator is similar to `and` operator, the interpreter evaluates the **\<e\>'s** from left to right. The difference is that once an **\<e\>** evaluates to **true**, the value is returned and the rest of the **\<e\>**'s will not be evaluated. If no **true** value is found, a **false** value is returned.

```scheme
(not <e>)
```

`Not` expression evaluates to **true** when the expression **\<e\>** evaluates to **false**, and **false** otherwise.

### Definition

A definition binds a value to a symbol.

```scheme
(define a 1)
(* a 2)       ; 2
```

Procedures can also be defined using define, in a slightly different form.

```scheme
(define (<name> <formal parameters>) <body>)
```

For example, a square procedure can be defined as following

```scheme
(define (square x) (* x x))
(square 12)     ; 144
```

### Lambda Expression

Lambda is a special kind of procedure. It behaves exactly like a procedure that is created using **define**, except that it has no name.

```scheme
(lambda (<formal parameters>) <body>)
```

Lambda expression can be used for procedure definition, the following expressions are equivalent.

```scheme
(define (square x) (* x x))
(define square (lambda (x) (* x x)))
```

Lambda expression can also be used as the operator in a call expression.

```scheme
((lambda (x) (* x x)) 6)      ; 36
```

## Pair and Lists
