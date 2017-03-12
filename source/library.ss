; ICM on Scheme
; library.ss
; Author : Chill

(load "basic.ss")

(library (Number)
         (export f+ f- f* f/ =?)
         (import (rnrs))
         (define f+ +)
         (define f- -)
         (define f* *)
         (define f/ /)
         (define =? =))

(library (String)
         (export f+ =?)
         (import (rnrs))
         (define f+ string-append)
         (define =? string=?))

(library (Symbol)
         (export is? =?)
         (import (rnrs))
         (define is? symbol?)
         (define =? symbol=?))

(library (HashTable)
         (export new is? insert get)
         (import (rnrs) (Basic))
         (define new make-eq-hashtable)
         (define is? hashtable?)
         (define insert hashtable-set!)
         (define (get hashtable key) (hashtable-ref hashtable key nil)))

(library (List)
         (export is? first second third)
         (import (rnrs))
         (define is? list?)
         (define (first lst)  (car lst))
         (define (second lst) (car (cdr lst)))
         (define (third lst)  (car (cdr (cdr lst)))))

(library (Vector)
         (export new is? size get set)
         (import (rnrs))
         (define new make-vector)
         (define is? vector?)
         (define size vector-length)
         (define get vector-ref)
         (define set vector-set!))
