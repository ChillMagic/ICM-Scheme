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

(library (ICM-Environment)
  (export new)
  (import (rnrs)
	  (prefix (IdentTable) IdentTable.))
  (define (new)
    0)
)

(import (prefix (IdentTable) IdentTable.)
	(prefix (ICM-Environment) ICM-Environment.))

(define (.define code env)
  code)

(define (.defunc code env)
  code)
(define (.module code env)
  code)
(define (.dim code env)
  code)
(define (.restrict code env)
  code)
(define (.defstruct code env)
  code)


(define eval-func-map (make-eq-hashtable))
(define (get-eval-func sym)
  (HashTable.get
     eval-func-map
     sym
     (lambda (code env)
       (display "Can't find ident '")
       (display sym)
       (display "'.\n"))))
(define (init-eval-func)
  (import (HashTable)
	  (prefix (rnrs) rnrs:))
  (insert! eval-func-map 'do (lambda (code env)
			       (rnrs:for-each (lambda (x) (.eval x env)) code)))
  (insert! eval-func-map 'define .define)
  (insert! eval-func-map 'defunc .defunc)
  (insert! eval-func-map 'module .module)
  (insert! eval-func-map 'dim .dim)
  (insert! eval-func-map 'defstruct .defstruct)
  (insert! eval-func-map 'restrict .restrict))

(init-eval-func)

(define (.eval code env)
  (if (list? code)
      (let ((f (car code)))
	(if (symbol? f)
	    (begin ((get-eval-func f) (cdr code) env))
	    (begin (display "Syntax Error for ")
		   (display code)
		   (display ".\n"))))
      code))


(define GlobalIdentTable (IdentTable.new 'Module '%root))

(p GlobalIdentTable)

(define testcode
  '(do (define a)
    (defunc b)
    (module A (define a) (defunc b))
    (defstruct B (dim a) (dim b) (define c))
    (dim c)))

(define genv (ICM-Environment.new))

(.eval testcode GlobalIdentTable)
