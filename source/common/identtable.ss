;; ICM on Scheme
;; identtable.ss
;; Author : Chill

(load-relative "../basic.ss")
(load-relative "analysisbase.ss")

;; Module : (module Name ...)
;; Struct : (struct ...) / (defsturct Name ...)
;; Func   : (function ...) / (defunc Name ...)
;; Data   : (define Name ...)
;; DyVarb : (let Name ...)
;; StVarb : (dim Name ...)

(library (IdentTable)
  (export new get-type get-name get-index get-table)
  (import (rnrs)
          (prefix (Vector) Vector.)
          (prefix (HashTable) HashTable.))

  (define Iindex 0) ; Ident Index
  (define Itype  1) ; Ident Type
  (define Iname  2) ; Ident Name
  (define Itable 3) ; Ident Table

  (define (new index type name)
    (vector
     index
     type
     name
     (cond ((symbol=? type 'Module) (HashTable.new))
           ((symbol=? type 'Struct) (HashTable.new))
           ((symbol=? type 'Func)   (HashTable.new))
           (else '()))))

  (define (get-index identtable)
    (Vector.get identtable Iindex))

  (define (get-type identtable)
    (Vector.get identtable Itype))

  (define (get-name identtable)
    (Vector.get identtable Iname))

  (define (get-table identtable)
    (Vector.get identtable Itable))

  ;;(define IdentTableData (make-vector (expt 2 16)))
  ;;(define (IdentTableData.get index)
  ;;  (Vector.get IdentTableData index))

)
