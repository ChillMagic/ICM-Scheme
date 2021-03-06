;; ICM on Scheme
;; analysisbase.ss
;; Author : Chill

(library (ICM-AnalysisBase)
  (export do-eval do-execute pattern pattern-once)
  (import (rnrs))
  ;; Do Execute
  (define (do-execute sfmap-func code env)
    (if (list? code)
        (let ((f (car code)))
          (if (symbol? f)
              ((sfmap-func f) (cdr code) env)
              (begin (display "Syntax Error for ")
                     (display code)
                     (display ".\n")))) code))
  (define do-eval do-execute) ; Will be deleted.
  
  ;; Pattern
  (define (pattern code)
    (pattern-base pattern code))
  (define (pattern-once code)
    (pattern-base pattern-base2 code))
  (define (pattern-symbol code)
    (cond ((symbol=? code 'list) 'list)
          ((symbol=? code ':) ':)
          ((symbol=? code '...) '...)
          (else 'ident)))
  (define (pattern-list fpattern code)
    (let ((r '()))
      (for-each
       (lambda (e)
         (set! r (append r (list (fpattern e))))) code) r))
  (define (pattern-base fpattern code)
    (cond ((symbol? code) (pattern-symbol code))
          ((list? code) (pattern-list fpattern code))
          (else 'data)))
  (define (pattern-base2 code)
    (cond ((symbol? code) (pattern-symbol code))
          ((list? code) 'expr)
          (else 'data)))
  )
