; ICM on Scheme
; library-analysis.ss
; Author : Chill

(load-relative "basic.ss")

(define (for-each-with-inter lst elt-func int-func)
  (import (prefix (List) List.))
  (List.for-each-with-inter lst elt-func int-func))

(define GlobalIdentTable (make-eq-hashtable))

(define (.record-module IdentTable ident)
  (hashtable-set! IdentTable ident (make-eq-hashtable)))

(define (.record-declare IdentTable library ident in-args out)
  (hashtable-set! (hashtable-ref IdentTable library 'err) ident (vector 'function in-args out)))

(define (.symbol=? a b)
  (and (symbol? a) (symbol? b) (symbol=? a b)))

(define (.is-args? expr)
  (if (and (list? expr) (.symbol=? (car expr) 'list)) #t #f))

(define (.library-analysis expr env)
  (let ((f (car expr)))
    (cond ((symbol=? f 'module)  (.module expr env))
          ((symbol=? f 'declare) (.declare expr env)))))

(define (.module expr env)
  (let ((ident (cadr expr)))
    (if (symbol? ident)
        (begin
        (.record-module GlobalIdentTable ident)
        (let loop ((exp (cddr expr)))
          (when (not (null? exp))
            (.library-analysis (car exp) ident)
            (loop (cdr exp))))) 'err)))

(define (.declare expr env)
  (if (= (length expr) 5)
      (let ((ident (list-ref expr 1)) (in-args (list-ref expr 2))
            (-> (list-ref expr 3)) (out (list-ref expr 4)))
        (if (and (symbol? ident) (.is-args? in-args) (.symbol=? -> '->) (symbol? out))
            (.record-declare GlobalIdentTable env ident in-args out)
            'err)) 'err))
