; ICM on Scheme
; core.ss
; Author : Chill

(load "basic.ss")
(load "library.ss")

(library (ICM-Core)
  (export expr-eval if-expr expr-? expr-if)
  (import (rnrs) (Basic) (Symbol)
    (prefix (Basic) Basic.)
    (prefix (List) List.))

  (define-syntax if-expr
      (syntax-rules ()
        ((_ b-expr f-expr l-expr e-expr)
          (let ((b-value b-expr))
          (cond ((symbol=? b-value `T) f-expr)
                ((symbol=? b-value `F) l-expr)
                (else e-expr))))))

  (define (errors) (display "Error Occur.\n") `nil)

  ; eval
  (define (expr-eval code)
    (let ((f (car code)))
      (cond ((=? f `do)    (expr-do    code))
            ((=? f `?)     (expr-?     code))
            ((=? f `if)    (expr-if    code))
            ((=? f `for)   (expr-for   code))
            ((=? f `while) (expr-while code))
            (else          (expr-fcall code))
      )
    )
  )

  ; (fexpr
  ;    <sexpr ...>
  ; )
  (define (expr-fcall code)
    code
  )

  ; (do
  ;    <sexpr ...>
  ; )
  (define (expr-do code)
    (do-list (cdr code) expr-eval)
  )

  ; (? bexpr sexpr1 sexpr2)
  (define (expr-? code)
    (let ((ccdr (cdr code)))
         (if-expr (List.first  ccdr)
                  (List.second ccdr)
                  (List.third  ccdr)
                  (errors))))

  ; (if bexpr0
  ;    sexpr0 ...
  ;  <elsif bexprk
  ;    sexprk ...>*
  ;  <else
  ;    sexprn ...>
  ; )
  (define (expr-if code)
    code
  )

  ; (for V in rexpr
  ;    sexpr ...
  ; )
  (define (expr-for code)
    code
  )

  ; (loop
  ;    sexpr ...
  ; )
  (define (expr-loop code)
    code
  )

  ; (while bexpr
  ;    sexpr ...
  ; )
  (define (expr-while code)
    code
  )
)
