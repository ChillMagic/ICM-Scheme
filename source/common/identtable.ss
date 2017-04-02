;; ICM on Scheme
;; identtable.ss
;; Author : Chill

(load-relative "../basic.ss")
(load-relative "analysisbase.ss")

(library (IdentTable)
  (export new get-type get-name get-index get-table insert! print print-table)
  (import (rnrs)
          (prefix (Vector) Vector.)
          (prefix (HashTable) HashTable.))

  (define Iname  0) ; Ident Name
  (define Iindex 1) ; Ident Index
  (define Itype  2) ; Ident Type
  (define Itable 3) ; Ident Table

  (define (new index type name)
    (vector name index type (HashTable.new)))

  (define (get-index identtable)
    (Vector.get identtable Iindex))

  (define (get-type identtable)
    (Vector.get identtable Itype))

  (define (get-name identtable)
    (Vector.get identtable Iname))

  (define (get-table identtable)
    (Vector.get identtable Itable))

  (define (insert! identtable ident type index)
    (if (HashTable.include? (get-table identtable) ident)
        (begin
          (display "Identifier '")
          (display ident)
          (display "' has been defined.\n"))
        (let ((nit (new index type ident)))
          (HashTable.insert! (get-table identtable) ident nit)
          nit)))
  (define (p-in-identtable e)
    (cond ((vector? e)
           (display "[")
           (Vector.for-each-with-inter
            e
            p-in-identtable
            (lambda () (display " ")))
           (display "]"))
          ((hashtable? e)
           (display "{")
           (HashTable.for-sort-each-with-inter
            e
            Vector.symbol-sort
            (lambda (k v) (p-in-identtable v))
            (lambda () (display " ")))
           (display "}"))
          (else (display e))))
  (define (print identtable)
    (print-table (get-table identtable)))
  (define (print-table identtable-table)
    (HashTable.for-sort-each-with-inter
     identtable-table
     Vector.symbol-sort
     (lambda (k v) (p-in-identtable v))
     newline))
)
