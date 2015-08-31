#lang scribble/manual

@(require scribble/eval
          (for-label racket/base
                     racket/contract/base
                     data/leftist-tree))

@(define the-eval (make-base-eval))
@(the-eval '(require data/leftist-tree
                     data/enumerate/lib))

@title{Leftist Trees}
@author[@author+email["Jon Zeppieri" "zeppieri@gmail.com"]]

@defmodule[data/leftist-tree]

Leftist trees are immutable priority queues.

@defproc[(leftist-tree [<=? (-> any/c any/c any/c)]
                       [xs sequence? '()])
         leftist-tree?]{
 Makes a new tree containing the elements of @racket[xs], ordered by @racket[<=?].

@examples[#:eval the-eval
(define empty-tree-of-strings (leftist-tree string<=?))
(define non-empty-tree-of-strings (leftist-tree string<=? '("once" "upon" "a" "time")))
empty-tree-of-strings
non-empty-tree-of-strings
]}

@defproc[(leftist-tree? [x any/c])
         boolean?]{
 Returns @racket[#t] if @racket[x] is a leftist tree, @racket[#f] otherwise.

@examples[#:eval the-eval
(leftist-tree? (leftist-tree <=))
(leftist-tree? "I can haz treaz?")
]}

@defproc[(leftist-tree-empty? [t leftist-tree?])
         leftist-tree?]{
 Returns @racket[#t] if @racket[t] is empty, @racket[#f]
 otherwise.

@examples[#:eval the-eval
(define t (leftist-tree string<=?))
(leftist-tree-empty? t)
(leftist-tree-empty? (leftist-tree-add t "κατέβην χθὲς εἰς Πειραιᾶ μετὰ Γλαύκωνος τοῦ Ἀρίστωνος..."))
]}

@defproc[(leftist-tree-count [t leftist-tree?])
         exact-nonnegative-integer?]{
 Returns the number of elements in @racket[t].

@examples[#:eval the-eval
(define t (leftist-tree string<=?))
(leftist-tree-count t)
(leftist-tree-count (leftist-tree-add-all t (enum->list string/e 10)))
]}

@defproc[(leftist-tree-add [t leftist-tree?]
                           [x any/c])
         leftist-tree?]{
 Functionally extends @racket[t] by adding @racket[x] and
 returns the extended tree.

@examples[#:eval the-eval
(define empty (leftist-tree string<=?))
(define non-empty (leftist-tree-add empty "Hello world!"))
]}

@defproc[(leftist-tree-add-all [t leftist-tree?]
                               [xs sequence?])
         leftist-tree?]{
 Functionally extends @racket[t] by adding all elements of
 the sequence @racket[xs] and returns the extended tree.

@examples[#:eval the-eval
(define empty (leftist-tree string<=?))
(define words '("some pig!" "terrific" "radiant" "humble"))
(leftist-tree-add-all empty words)
]}

@defproc[(leftist-tree-min [t leftist-tree?])
         any/c]{
 Returns the least element in @racket[t] according to the
 tree's ordering. If the tree is empty, an exception is
 raised.

@examples[#:eval the-eval
(define empty (leftist-tree string<=?))
(define words '("some pig!" "terrific" "radiant" "humble"))
(leftist-tree-min (leftist-tree-add-all empty words))
]}

@defproc[(leftist-tree-remove-min [t leftist-tree?])
         leftist-tree?]{
 Functionally removes the least element in @racket[t]
 and returns the fresh tree.

@examples[#:eval the-eval
(define empty (leftist-tree string<=?))
(define words '("some pig!" "terrific" "radiant" "humble"))
(define full (leftist-tree-add-all empty words))
(leftist-tree-count full)
(leftist-tree-count (leftist-tree-remove-min full))
]}

@defproc[(leftist-tree->list [t leftist-tree?])
         (listof any/c)]{
 Returns an ordered list of the elements of @racket[t].

@examples[#:eval the-eval
(define empty (leftist-tree string<=?))
(define words '("some pig!" "terrific" "radiant" "humble"))
(define full (leftist-tree-add-all empty words))
(leftist-tree->list full)
]}

@defproc[(in-leftist-tree [t leftist-tree?])
         sequence?]{
 Returns a sequence that generates the elements of
 @racket[t] in order.

@examples[#:eval the-eval
(define empty (leftist-tree string<=?))
(define words '("some pig!" "terrific" "radiant" "humble"))
(define full (leftist-tree-add-all empty words))
(for ([word (in-leftist-tree full)])
  (displayln word))
]}
