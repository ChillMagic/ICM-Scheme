; ICM on Scheme
; identtable.ss
; Author : Chill

(load-relative "../basic.ss")
(load-relative "analysisbase.ss")

; Module : (module Name ...)
; Struct : (struct ...) / (defsturct Name ...)
; Func   : (function ...) / (defunc Name ...)
; Data   : (define Name ...)
; DyVarb : (let Name ...)
; StVarb : (dim Name ...)

(library (IdentTable)
  (export new get-type get-name get-index get-table)
  (import (rnrs)
          (prefix (Vector) Vector.)
          (prefix (HashTable) HashTable.))

  (define IIdentIndex 0)
  (define IIdentType 1)
  (define IIdentName 2)
  (define IIdentTable 3)

  (define (new type name)
    (vector
     (getCurrentIdentIndex)
     type
     name
     (cond ((symbol=? type 'Module) (HashTable.new))
           ((symbol=? type 'Struct) (vector))
           ((symbol=? type 'Func)   (vector))
           (else '()))))

  (define (get-index identtable)
    (Vector.get identtable IIdentIndex))

  (define (get-type identtable)
    (Vector.get identtable IIdentType))

  (define (get-name identtable)
    (Vector.get identtable IIdentName))

  (define (get-table identtable)
    (Vector.get identtable IIdentTable))

  (define IdentTableData (make-vector (expt 2 16)))
  (define (IdentTableData.get index)
    (Vector.get IdentTableData index))

  (define CurrentIdentIndex 0)
  (define (getCurrentIdentIndex)
    (let ((index CurrentIdentIndex))
      (set! CurrentIdentIndex (+ CurrentIdentIndex 1))
      index))
)
