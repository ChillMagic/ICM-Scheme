;; ICM on Scheme
;; core.ss
;; Author : Chill

(load-relative "basic.ss")
(load-relative "common/analysisbase.ss")

(library (ICM-Core)
  (export expr-eval if-expr)
  (import (rnrs) (Output) (ICM-AnalysisBase)
          (prefix (Symbol) Symbol.)
          (prefix (HashTable) HashTable.)
          (prefix (GlobalFunc) GlobalFunc.)
          (prefix (List) List.))

  (define-syntax if-expr
    (syntax-rules ()
      ((_ env b-expr f-expr l-expr e-expr)
       (let ((b-value (expr-evalf b-expr env)))
         (cond ((Symbol.=? b-value 'T) (expr-evalf f-expr env))
               ((Symbol.=? b-value 'F) (expr-evalf l-expr env))
               (else e-expr))))))

  (define (errors) (display "Error Occur.\n") `nil)

  ;; eval
  (define (expr-eval code env)
    (when (not (procedure? expr-evalf))
          (init-eval-func (make-eq-hashtable)))
    (expr-evalf code env))
  
  (define expr-evalf)

  (define (init-eval-func efm) ; efm : Eval Func Map
    (HashTable.insert! efm 'do        expr-do       )
    (HashTable.insert! efm '?         expr-?        )
    (HashTable.insert! efm 'if        expr-if       )
    (HashTable.insert! efm 'loop      expr-loop     )
    (HashTable.insert! efm 'while     expr-while    )
    (HashTable.insert! efm 'for       expr-for      )
    (HashTable.insert! efm 'let       expr-let      )
    (HashTable.insert! efm 'set       expr-set      )
    (HashTable.insert! efm 'cpy       expr-cpy      )
    (HashTable.insert! efm 'ref       expr-ref      )
    (HashTable.insert! efm 'dim       expr-dim      )
    (HashTable.insert! efm 'restrict  expr-restrict )
    (HashTable.insert! efm 'define    expr-define   )
    (HashTable.insert! efm 'defunc    expr-defunc   )
    (HashTable.insert! efm 'defstruct expr-defstruct)
    (HashTable.insert! efm 'function  expr-function )
    (HashTable.insert! efm 'struct    expr-struct   )
    (set! expr-evalf
          (lambda (code env)
            (do-execute
             (lambda (sym)
               (HashTable.get
                efm
                sym
                (lambda (code env) (expr-fcall sym code env))))
             code env))))

  (define (expr-evals code env)
    (let loop ((lst code) (rlist `()))
      (if (null? lst)
          rlist
          (loop (cdr lst) (List.push-back rlist (expr-evalf (car lst) env))))))

  ;; (fexpr <sexpr ...>)
  (define (expr-fcall fexpr code env)
    (GlobalFunc.call
     env
     (expr-evalf fexpr env)
     (expr-evals code env)
     (lambda (s)
       (display "Error to find Identifer '")
       (display s)
       (display "'.\n")
       'nil)))

  ;; (do
  ;;    <sexpr ...>
  ;; )
  (define (expr-do code env)
    (let loop ((lst code) (last `nil))
      (if (null? lst)
          last
          (loop (cdr lst) (expr-evalf (car lst) env)))))

  ;; (? bexpr sexpr1 <sexpr2>)
  (define (expr-? code env)
    (if-expr env (car code) (cadr code) (caddr code) (errors)))

  ;; (if bexpr0
  ;;    sexpr0 ...
  ;;  <elsif bexprk
  ;;    sexprk ...>*
  ;;  <else
  ;;    sexprn ...>
  ;; )
  (define (expr-if code env)
    code
    )

  ;; (loop
  ;;    sexpr ...
  ;; )
  (define (expr-loop code env)
    code
    )

  ;; (while bexpr
  ;;    sexpr ...
  ;; )
  (define (expr-while code env)
    code
    )

  ;; (for I in rexpr
  ;;    sexpr ...
  ;; )
  (define (expr-for code env)
    code
    )

  ;; (let I vexpr)
  (define (expr-let code env)
    code
    )

  ;; (set I vexpr)
  (define (expr-set code env)
    code
    )

  ;; (cpy <I> vexpr)
  (define (expr-cpy code env)
    code
    )

  ;; (ref I I2)
  (define (expr-ref code env)
    code
    )

  ;; (dim I texpr)
  (define (expr-dim code env)
    code
    )

  ;; (restrict I texpr)
  (define (expr-restrict code env)
    code
    )

  ;; (define I cexpr)
  (define (expr-define code env)
    code
    )

  ;; (defunc ident [<(ident : texpr)|ident>* <(ident : texpr ...)|(... : texpr)|...>] <-> texpr>
  ;;   sexpr ...
  ;; )
  (define (expr-defunc code env)
    code
    )

  ;; (function <I> [<(I <: Type>)>*] <-> Type>
  ;;    sexpr ...
  ;; )
  (define (expr-function code env)
    code
    )

  ;; (defstruct I
  ;;    <[(I <: Type>)]>*
  ;; )
  (define (expr-defstruct code env)
    code
    )

  ;; (struct <I>
  ;;    <[(I <: Type>)]>*
  ;; )
  (define (expr-struct code env)
    code
    )
  )
