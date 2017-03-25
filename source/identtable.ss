; ICM on Scheme
; identtable.ss
; Author : Chill

(load "basic.ss")

; Module : (module Name ...)
; Struct : (struct ...) / (defsturct Name ...)
; Func   : (function ...) / (defunc Name ...)
; Data   : (define Name ...)
; DyVarb : (let Name ...)
; StVarb : (dim Name ...)
(library (IdentTable)
  (export new get-type get-name get-index get-table)
  (import (rnrs)
	  (prefix (Vector) Vector.))

  (define ITID-IdentIndex 0)
  (define ITID-IdentType 1)
  (define ITID-IdentName 2)
  (define ITID-IdentTable 3)

  (define (new type name)
    (vector
     (getCurrentIdentIndex)
     type
     name
     (cond ((symbol=? type 'Module) (vector))
	   ((symbol=? type 'Struct) (vector))
	   ((symbol=? type 'Func)   (vector))
	   (else '()))))

  (define (get-index identtable)
    (Vector.get identtable ITID-IdentIndex))

  (define (get-type identtable)
    (Vector.get identtable ITID-IdentType))

  (define (get-name identtable)
    (Vector.get identtable ITID-IdentName))

  (define (get-table identtable)
    (Vector.get identtable ITID-IdentTable))

  (define IdentTableData (make-vector (expt 2 16)))
  (define (IdentTableData.get index)
    (Vector.get IdentTableData index))

  (define CurrentIdentIndex 0)
  (define (getCurrentIdentIndex)
    (let ((index CurrentIdentIndex))
      (set! CurrentIdentIndex (+ CurrentIdentIndex 1))
      index))
)

(import (prefix (IdentTable) IdentTable.))

(define GlobalIdentTable (IdentTable.new 'Module '%root))

GlobalIdentTable

(define testcode
  '((define a)
    (defunc b)
    (module A (define a) (defunc b))
    (defstruct B (dim a) (dim b) (define c))
    (dim c)
    ))

(display testcode)
(display '(5 6 8))
