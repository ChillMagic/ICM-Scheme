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
  (define (pattern-type e)
    (cond ((symbol? e)
           (cond ((symbol=? e 'list) 'list)
                 ((symbol=? e ':) ':)
                 ((symbol=? e '...) '...)
                 (else 'ident)))
          ((list? e) (pattern e))
          (else 'data)))
  (define (pattern code)
    (let ((r '()))
      (for-each
       (lambda (e)
         (set! r (append r (list (pattern-type e))))) code) r)))
