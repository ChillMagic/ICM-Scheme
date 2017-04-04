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
    (Stack.push! fat (vector ident type multi)))
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
    (let ((p (pattern item)))
      (cond ((equal? p 'ident)
             (FPT.insert paratable item 'Vary #f))
            ((equal? p '(ident))
             (FPT.insert paratable (car item) 'Vary #f))
            ((equal? p '(ident : ident))
             (FPT.insert paratable (car item) (caddr item) #f))
            ((equal? p '(ident : ident ...))
             (FPT.insert paratable (car item) (caddr item) #t))
            (else (errors)))))
  
  (define (errors)
    (error #f "Function parameter syntax error."))
  )

(import (prefix (FuncPara-Analysis) FuncPara-Analysis.))
(p (FuncPara-Analysis.eval '((a : Int ...) x y)))
