; ICM on Scheme
; basic.ss
; Author : Chill

(library (Basic)
    (export T F nil print println p do-list)
    (import (rnrs))
    (define T `T)
    (define F `F)
    (define nil `nil)
    (define print display)
    (define (println x)
        (begin (display x) (newline)))
    (define p println)
    (define (do-list lst func)
      (let loop ((lst lst))
        (if (not (null? lst))
          (begin
            (func (car lst))
            (loop (cdr lst)))))))

(define-syntax import-prefix
  (syntax-rules ()
    ((_ name suffix)
      (import (prefix (name) suffix)))))

(define-syntax define-struct
  (syntax-rules (export import)
    ((_ name (export expt ...) (import impt ...) exprs ...)
      (eval (quote
        (library (name)
          ; Export & Import
          (export new is? expt ...)
          (import (rnrs) impt ...)
          ; new
          (define (new . args)
           (vector 'Point (apply init args)))
          ; is?
          (define (is? object)
            (let ((f (vector-ref object 0)))
              (and (symbol? f)
                   (symbol=? f 'name))))
          ; exprs
          exprs ...))))
    ((_ name (import impt ...) (export expt ...) exprs ...)
      (define-struct name (export expt ...) (import impt ...) exprs ...))
    ((_ name (import impt ...) exprs ...)
      (define-struct name (export) (import impt ...) exprs ...))
    ((_ name (export expt ...) exprs ...)
      (define-struct name (export expt ...) (import) exprs ...))
    ((_ name exprs ...)
      (define-struct name (export) (import) exprs ...))))

(define-syntax define-namedstruct
  (syntax-rules (export import)
  ((_ name (v ...) (export expt ...) (import impt ...) exprs ...)
    (define-struct name
      ; Export & Import
      (export expt ...)
      (import impt ...)
      ; init
      (define (init v ...) (vector v ...))
      ; exprs
      exprs ...))
  ((_ name (v ...) (import impt ...) (export expt ...) exprs ...)
    (define-namedstruct name (v ...) (export expt ...) (import impt ...) exprs ...))
  ((_ name (v ...) (export expt ...) exprs ...)
    (define-namedstruct name (v ...) (export expt ...) (import) exprs ...))
  ((_ name (v ...) (import impt ...) exprs ...)
    (define-namedstruct name (v ...) (export) (import impt ...) exprs ...))
  ((_ name (v ...) exprs ...)
    (define-namedstruct name (v ...) (export) (import) exprs ...))))
