; ICM on Scheme
; core.ss
; Author : Chill

(library (ICM-Core)
  (export expr-?)
  (import (rnrs))
  (define (expr-bt? exp)
    (symbol=? exp `T)
  )
  (define (expr-? code)
    (let ((ccdr (cdr code)))
      (let ((b-expr (car ccdr))
            (f-expr (car (cdr ccdr)))
            (l-expr (car (cdr (cdr ccdr)))))
           (if (expr-bt? b-expr) f-expr l-expr)
      )
    )
  )
  (define (expr-if code)
    code
  )
  (define (expr-for code)
    code
  )
  (define (expr-loop code)
    code
  )

)
