; ICM on Scheme
; core.ss
; Author : Chill

(load "library.ss")

(library (ICM-Core)
  (export if-expr expr-?)
  (import (rnrs)
    (prefix (List) List.))

  (define-syntax if-expr
      (syntax-rules ()
        ((_ b-expr f-expr l-expr e-expr)
          (let ((b-value b-expr))
          (cond ((symbol=? b-value `T) f-expr)
                ((symbol=? b-value `F) l-expr)
                (else e-expr))))))

  (define (errors) (display "Error Occur.\n") `nil)
  (define (expr-? code)
    (let ((ccdr (cdr code)))
      (let ((b-expr (List.first  ccdr))
            (f-expr (List.second ccdr))
            (l-expr (List.third  ccdr)))
           (if-expr b-expr f-expr l-expr (errors))
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
