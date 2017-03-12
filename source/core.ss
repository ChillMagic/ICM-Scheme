; ICM on Scheme
; core.ss
; Author : Chill

(load "basic.ss")
(load "library.ss")

(library (ICM-Core)
  (export expr-eval if-expr)
  (import (rnrs) (Basic) (Symbol)
    (prefix (GlobalFunc) GlobalFunc.)
    (prefix (Basic) Basic.)
    (prefix (List) List.))

  (define-syntax if-expr
      (syntax-rules ()
        ((_ gfunc b-expr f-expr l-expr e-expr)
          (let ((b-value (expr-eval gfunc b-expr)))
          (cond ((=? b-value `T) (expr-eval gfunc f-expr))
                ((=? b-value `F) (expr-eval gfunc l-expr))
                (else e-expr))))))

  (define (errors) (display "Error Occur.\n") `nil)

  ; eval
  (define (expr-eval gfunc code)
    (if (list? code)
      (let ((f (car code)))
        (cond ((=? f `do)        (expr-do        gfunc code))
              ((=? f `?)         (expr-?         gfunc code))
              ((=? f `if)        (expr-if        gfunc code))
              ((=? f `loop)      (expr-loop      gfunc code))
              ((=? f `while)     (expr-while     gfunc code))
              ((=? f `for)       (expr-for       gfunc code))
              ((=? f `let)       (expr-let       gfunc code))
              ((=? f `set)       (expr-set       gfunc code))
              ((=? f `cpy)       (expr-cpy       gfunc code))
              ((=? f `ref)       (expr-ref       gfunc code))
              ((=? f `dim)       (expr-dim       gfunc code))
              ((=? f `restrict)  (expr-restrict  gfunc code))
              ((=? f `define)    (expr-define    gfunc code))
              ((=? f `defunc)    (expr-defunc    gfunc code))
              ((=? f `defstruct) (expr-defstruct gfunc code))
              ((=? f `function)  (expr-function  gfunc code))
              ((=? f `struct)    (expr-struct    gfunc code))
              (else              (expr-fcall     gfunc code))))
      code))

  ; (fexpr <sexpr ...>)
  (define (expr-fcall gfunc code)
    (GlobalFunc.call gfunc (car code) (cdr code)))

  ; (do
  ;    <sexpr ...>
  ; )
  (define (expr-do gfunc code)
    (let loop ((lst (cdr code)) (last `nil))
      (if (null? lst)
	      last
	      (loop (cdr lst) (expr-eval gfunc (car lst))))))

  ; (? bexpr sexpr1 <sexpr2>)
  (define (expr-? gfunc code)
    (let ((ccdr (cdr code)))
         (if-expr gfunc
                  (List.first  ccdr)
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
  (define (expr-if gfunc code)
    code
  )

  ; (loop
  ;    sexpr ...
  ; )
  (define (expr-loop gfunc code)
    code
  )

  ; (while bexpr
  ;    sexpr ...
  ; )
  (define (expr-while gfunc code)
    code
  )

  ; (for V in rexpr
  ;    sexpr ...
  ; )
  (define (expr-for gfunc code)
    code
  )

  ; (let V vexpr)
  (define (expr-let gfunc code)
    code
  )

  ; (set V vexpr)
  (define (expr-set gfunc code)
    code
  )

  ; (cpy <V> vexpr)
  (define (expr-cpy gfunc code)
    code
  )

  ; (ref V V2)
  (define (expr-ref gfunc code)
    code
  )

  ; (dim V texpr)
  (define (expr-dim gfunc code)
    code
  )

  ; (restrict V texpr)
  (define (expr-restrict gfunc code)
    code
  )

  ; (define I cexpr)
  (define (expr-define gfunc code)
    code
  )

  ; (defunc I [<(V <: Type>)>*] <-> Type>
  ;   sexpr ...
  ; )
  (define (expr-defunc gfunc code)
    code
  )

  ; (function <I> [<V <: Type>>*] <-> Type>
  ;    sexpr ...
  ; )
  (define (expr-function gfunc code)
    code
  )

  ; (defstruct I
  ;    <[(I <: Type>)]>*
  ; )
  (define (expr-defstruct gfunc code)
    code
  )

  ; (struct <I>
  ;    <[(I <: Type>)]>*
  ; )
  (define (expr-struct gfunc code)
    code
  )
)
