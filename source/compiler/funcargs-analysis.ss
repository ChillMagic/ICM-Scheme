;; ICM on Scheme
;; funcargs-analysis.ss
;; Author : Chill

(load-relative "../basic.ss")
(load-relative "../common/analysisbase.ss")

;; FuncParaTable

(library (FuncParaTable)
  (export new insert over-record)
  (import (rnrs)
          (prefix (Stack) Stack.))

  (define (new)
    (Stack.new))
  (define (insert fat ident type multi)
    (Stack.push fat (vector ident type multi)))
  (define (over-record fat)
    (list->vector (reverse (Stack.get-dat fat))))
  )

;; Function Parameters:
;; [<{(i <: Type <...>>)|i}>*]

(library (FuncPara-Analysis)
  (export eval)
  (import (rnrs)
          (ICM-AnalysisBase)
          (prefix (FuncParaTable) FPT.))
  
  ;; para-code -> argstable
  (define (eval para-code)
    (assert (list? para-code))
    (let ((paratable (FPT.new)))
      (let loop ((lst para-code))
        (if (null? lst)
            (FPT.over-record paratable)
            (begin
              (eval-base (car lst) paratable)
              (loop (cdr lst)))))))

  (define (eval-base item paratable)
    (cond ((list? item)
           (let ((p (pattern item)))
             (cond ((equal? p '(ident)))
                   ((equal? p '(ident : ident)))
                   ((equal? p '(ident : ident ...)))
                   (else (errors)))))
          ((symbol? item)
           (FPT.insert paratable item 'Vary #f))
          (else (make-error))))

  (define (errors)
    (error #f "Function parameter syntax error."))
  )
