; ICM on Scheme
; identtable.ss
; Author : Chill

(load "library.ss")

; Module : (module Name ...)
; Struct : (struct ...) / (defsturct Name ...)
; Func   : (function ...) / (defunc Name ...)
; Data   : (define Name ...)
; DyVarb : (let Name ...)
; StVarb : (dim Name ...)

(define ITID-IdentIndex 0)
(define ITID-IdentType 1)
(define ITID-IdentName 2)
(define ITID-IdentTable 3)

(define IdentTableData (make-vector (expt 2 16)))
(define (IdentTableData.get index)
  (Vector.get IdentTableData index))

(define CurrentIdentIndex 0)
(define (getCurrentIdentIndex)
  (let ((index CurrentIdentIndex))
    (set! CurrentIdentIndex (+ CurrentIdentIndex 1))
    index))

(define (IdentTable.new type name)
  (vector
    (getCurrentIdentIndex)
    type
    name
    (cond ((symbol=? type 'Module) (vector))
          ((symbol=? type 'Struct) (vector))
          ((symbol=? type 'Func)   (vector))
          (else '()))))

(define (IdentTable.get-index identtable)
  (Vector.get identtable ITID-IdentIndex))

(define (IdentTable.get-type identtable)
  (Vector.get identtable ITID-IdentType))

(define (IdentTable.get-name identtable)
  (Vector.get identtable ITID-IdentName))

(define (IdentTable.get-table identtable)
  (Vector.get identtable ITID-IdentTable))

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
