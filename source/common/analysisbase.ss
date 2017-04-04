; ICM on Scheme
; analysisbase.ss
; Author : Chill

(library (ICM-AnalysisBase)
  (export do-eval pattern)
  (import (rnrs))
  (define (do-eval sfmap-func code env)
    (if (list? code)
        (let ((f (car code)))
          (if (symbol? f)
              ((sfmap-func f) (cdr code) env)
              (begin (display "Syntax Error for ")
                     (display code)
                     (display ".\n")))) code))
  (define (pattern code)
    (cond ((symbol? code)
           (cond ((symbol=? code 'list) 'list)
                 ((symbol=? code ':) ':)
                 ((symbol=? code '...) '...)
                 (else 'ident)))
          ((list? code)
           (let ((r '()))
             (for-each
              (lambda (e)
                (set! r (append r (list (pattern e))))) code) r))
          (else 'data))))
