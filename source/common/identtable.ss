;; ICM on Scheme
;; identtable.ss
;; Author : Chill

(load-relative "../basic.ss")
(load-relative "analysisbase.ss")

(library (IdentTable)
  (export new get-type get-name get-index get-table insert!)
  (import (rnrs)
          (prefix (Vector) Vector.)
          (prefix (HashTable) HashTable.))

  (define Iindex 0) ; Ident Index
  (define Itype  1) ; Ident Type
  (define Iname  2) ; Ident Name
  (define Itable 3) ; Ident Table

  (define (new index type name)
    (vector index type name (HashTable.new)))

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
          (display "' has been defined.")
          (newline))
        (let ((nit (new index type ident)))
          (HashTable.insert! (get-table identtable) ident nit)
          nit)))
)
