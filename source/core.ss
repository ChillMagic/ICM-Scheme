; ICM on Scheme
; core.ss
; Author : Chill

(load "basic.ss")
(load "library.ss")

(library (ICM-Core)
  (export expr-eval if-expr)
  (import (rnrs) (Basic) (Symbol)
    (prefix (Basic) Basic.)
    (prefix (List) List.))

  (define-syntax if-expr
      (syntax-rules ()
        ((_ b-expr f-expr l-expr e-expr)
          (let ((b-value (expr-eval b-expr)))
          (cond ((=? b-value `T) (expr-eval f-expr))
                ((=? b-value `F) (expr-eval l-expr))
                (else e-expr))))))

  (define (errors) (display "Error Occur.\n") `nil)

  ; eval
  (define (expr-eval code)
    (if (list? code)
      (let ((f (car code)))
        (cond ((=? f `do)        (expr-do        code))
              ((=? f `?)         (expr-?         code))
              ((=? f `if)        (expr-if        code))
              ((=? f `loop)      (expr-loop      code))
              ((=? f `while)     (expr-while     code))
              ((=? f `for)       (expr-for       code))
              ((=? f `let)       (expr-let       code))
              ((=? f `set)       (expr-set       code))
              ((=? f `cpy)       (expr-cpy       code))
              ((=? f `ref)       (expr-ref       code))
              ((=? f `dim)       (expr-dim       code))
              ((=? f `restrict)  (expr-restrict  code))
              ((=? f `define)    (expr-define    code))
              ((=? f `defunc)    (expr-defunc    code))
              ((=? f `defstruct) (expr-defstruct code))
              ((=? f `function)  (expr-function  code))
              ((=? f `struct)    (expr-struct    code))
              (else              (expr-fcall     code))
        )
      )
      code
    )
  )

  ; (fexpr <sexpr ...>)
  (define (expr-fcall code)
    code
  )

  ; (do
  ;    <sexpr ...>
  ; )
  (define (expr-do code)
    (let loop ((lst (cdr code)) (last `nil))
      (if (null? lst)
	      last
	      (loop (cdr lst) (expr-eval (car lst))))))

  ; (? bexpr sexpr1 <sexpr2>)
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

  ; (for V in rexpr
  ;    sexpr ...
  ; )
  (define (expr-for code)
    code
  )

  ; (let V vexpr)
  (define (expr-let code)
    code
  )

  ; (set V vexpr)
  (define (expr-set code)
    code
  )

  ; (cpy <V> vexpr)
  (define (expr-cpy code)
    code
  )

  ; (ref V V2)
  (define (expr-ref code)
    code
  )

  ; (dim V texpr)
  (define (expr-dim code)
    code
  )

  ; (restrict V texpr)
  (define (expr-restrict code)
    code
  )

  ; (define I cexpr)
  (define (expr-define code)
    code
  )

  ; (defunc I [<(V <: Type>)>*] <-> Type>
  ;   sexpr ...
  ; )
  (define (expr-defunc code)
    code
  )

  ; (function <I> [<V <: Type>>*] <-> Type>
  ;    sexpr ...
  ; )
  (define (expr-function code)
    code
  )

  ; (defstruct I
  ;    <[(I <: Type>)]>*
  ; )
  (define (expr-defstruct code)
    code
  )

  ; (struct <I>
  ;    <[(I <: Type>)]>*
  ; )
  (define (expr-struct code)
    code
  )
)
