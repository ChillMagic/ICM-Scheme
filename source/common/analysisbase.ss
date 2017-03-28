; ICM on Scheme
; analysisbase.ss
; Author : Chill

(load "basic.ss")

(library (ICM-AnalysisBase)
  (export do-eval)
  (import (rnrs))
  (define (do-eval sfmap-func code env)
    (if (list? code)
        (let ((f (car code)))
          (if (symbol? f)
              ((sfmap-func f) (cdr code) env)
              (begin (display "Syntax Error for ")
                     (display code)
                     (display ".\n")))) code)))
