;; ICM on Scheme
;; core.ss
;; Author : Chill

(load-relative "basic.ss")
(load-relative "common/analysisbase.ss")

(library (ICM-Core)
  (export expr-eval if-expr init-eval-func)
  (import (rnrs) (Symbol) (Output) (ICM-AnalysisBase)
          (prefix (HashTable) HashTable.)
          (prefix (GlobalFunc) GlobalFunc.)
          (prefix (List) List.))

  (define-syntax if-expr
    (syntax-rules ()
      ((_ gfunc b-expr f-expr l-expr e-expr)
       (let ((b-value (expr-eval b-expr gfunc)))
         (cond ((=? b-value `T) (expr-eval f-expr gfunc))
               ((=? b-value `F) (expr-eval l-expr gfunc))
               (else e-expr))))))

  (define (errors) (display "Error Occur.\n") `nil)

  ;; eval
  (define (expr-eval code env)
    (do-eval get-eval-func code env))

  (define eval-func-map)
  (define (get-eval-func sym)
    (HashTable.get eval-func-map sym (lambda (code env) (expr-fcall (append (list sym) code) env))))
  (define (init-eval-func)
    (set! eval-func-map (make-eq-hashtable))
    (HashTable.insert! eval-func-map 'do        expr-do       )
	(HashTable.insert! eval-func-map '?         expr-?        )
	(HashTable.insert! eval-func-map 'if        expr-if       )
	(HashTable.insert! eval-func-map 'loop      expr-loop     )
	(HashTable.insert! eval-func-map 'while     expr-while    )
	(HashTable.insert! eval-func-map 'for       expr-for      )
	(HashTable.insert! eval-func-map 'let       expr-let      )
	(HashTable.insert! eval-func-map 'set       expr-set      )
	(HashTable.insert! eval-func-map 'cpy       expr-cpy      )
	(HashTable.insert! eval-func-map 'ref       expr-ref      )
	(HashTable.insert! eval-func-map 'dim       expr-dim      )
	(HashTable.insert! eval-func-map 'restrict  expr-restrict )
	(HashTable.insert! eval-func-map 'define    expr-define   )
	(HashTable.insert! eval-func-map 'defunc    expr-defunc   )
	(HashTable.insert! eval-func-map 'defstruct expr-defstruct)
	(HashTable.insert! eval-func-map 'function  expr-function )
	(HashTable.insert! eval-func-map 'struct    expr-struct   ))

  (define (expr-evals code gfunc)
    (let loop ((lst code) (rlist `()))
      (if (null? lst)
          rlist
          (loop (cdr lst) (List.push-back rlist (expr-eval (car lst) gfunc))))))

  ;; (fexpr <sexpr ...>)
  (define (expr-fcall code gfunc)
    (GlobalFunc.call gfunc (expr-eval (car code) gfunc) (expr-evals (cdr code) gfunc)
                     (lambda (s)
                       (display "Error to find Identifer '")
                       (display s)
                       (display "'.\n")
                       'nil)))

  ;; (do
  ;;    <sexpr ...>
  ;; )
  (define (expr-do code gfunc)
    (let loop ((lst code) (last `nil))
      (if (null? lst)
          last
          (loop (cdr lst) (expr-eval (car lst) gfunc)))))

  ;; (? bexpr sexpr1 <sexpr2>)
  (define (expr-? code gfunc)
    (if-expr gfunc (car code) (cadr code) (caddr code) (errors)))

  ;; (if bexpr0
  ;;    sexpr0 ...
  ;;  <elsif bexprk
  ;;    sexprk ...>*
  ;;  <else
  ;;    sexprn ...>
  ;; )
  (define (expr-if code gfunc)
    code
    )

  ;; (loop
  ;;    sexpr ...
  ;; )
  (define (expr-loop code gfunc)
    code
    )

  ;; (while bexpr
  ;;    sexpr ...
  ;; )
  (define (expr-while code gfunc)
    code
    )

  ;; (for I in rexpr
  ;;    sexpr ...
  ;; )
  (define (expr-for code gfunc)
    code
    )

  ;; (let I vexpr)
  (define (expr-let code gfunc)
    code
    )

  ;; (set I vexpr)
  (define (expr-set code gfunc)
    code
    )

  ;; (cpy <I> vexpr)
  (define (expr-cpy code gfunc)
    code
    )

  ;; (ref I I2)
  (define (expr-ref code gfunc)
    code
    )

  ;; (dim I texpr)
  (define (expr-dim code gfunc)
    code
    )

  ;; (restrict I texpr)
  (define (expr-restrict code gfunc)
    code
    )

  ;; (define I cexpr)
  (define (expr-define code gfunc)
    code
    )

  ;; (defunc I [<(I <: Type>)>*] <-> Type>
  ;;   sexpr ...
  ;; )
  (define (expr-defunc code gfunc)
    code
    )

  ;; (function <I> [<(I <: Type>)>*] <-> Type>
  ;;    sexpr ...
  ;; )
  (define (expr-function code gfunc)
    code
    )

  ;; (defstruct I
  ;;    <[(I <: Type>)]>*
  ;; )
  (define (expr-defstruct code gfunc)
    code
    )

  ;; (struct <I>
  ;;    <[(I <: Type>)]>*
  ;; )
  (define (expr-struct code gfunc)
    code
    )
  )
