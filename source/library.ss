; ICM on Scheme
; library.ss
; Author : Chill

(load "basic.ss")

(library (Number)
         (export f+ f- f* f/ f=)
         (import (rnrs))
         (define f+ +)
         (define f- -)
         (define f* *)
         (define f/ /)
         (define f= =))

(library (String)
         (export f+ f=)
         (import (rnrs))
         (define f+ string-append)
         (define f= string=?))

(library (HashTable)
         (export new insert get)
         (import (rnrs) (Basic))
         (define new make-eq-hashtable)
         (define insert hashtable-set!)
         (define (get hashtable key) (hashtable-ref hashtable key nil)))
