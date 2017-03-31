;; ICM on Scheme
;; identtable.ss
;; Author : Chill

(load-relative "../basic.ss")
(load-relative "analysisbase.ss")
(load-relative "identtable.ss")

(library (ICM-IdentEnvironment)
  (export new get-cit insert-cid change-cit recover-cit)
  (import (rnrs)
          (prefix (Vector) Vector.)
          (prefix (Stack) Stack.)
          (prefix (IdentTable) IdentTable.))

  (define Icid   0) ; cid   : Current Insert Index
  (define Iits   1) ; its   : IdentTable Stack
  (define Iitdat 2) ; itdat : IdentTable Data
  
  (define (new)
    (let ((git (IdentTable.new 0 'Module '%root)))
      (vector 0 (Stack.make git) git)))

  ;; cit : Curent IdentTable
  (define (get-cit ienv)
    (Stack.top (get ienv Iits)))

  (define (change-cit ienv cit)
    (Stack.push! (get ienv Iits) cit))
  (define (recover-cit ienv)
    (Stack.pop! (get ienv Iits)))

  (define (get ienv prop) (Vector.get ienv prop))
  (define (set ienv prop inc) (Vector.set ienv prop inc))

  (define (insert-cid ienv)
    (let ((id (+ (get ienv Icid) 1)))
      (set ienv Icid id) id))
)

;; Module : (module Name ...)
;; Struct : (struct ...) / (defsturct Name ...)
;; Func   : (function ...) / (defunc Name ...)
;; Data   : (define Name ...)
;; DyVarb : (let Name ...)
;; StVarb : (dim Name ...)

(library (ICM-IdentAnalysis)
  (export eval init-eval-func)
  (import (rnrs) (ICM-AnalysisBase) (Output)
          (prefix (ICM-IdentEnvironment) IEnv.)
          (prefix (IdentTable) ITab.)
          (prefix (HashTable) HashTable.)
          (prefix (List) List.))

  (define (eval code env)
    (do-eval get-eval-func code env))

  (define (.do code env)
    (List.for-each code (lambda (x) (do-eval get-eval-func x env))))
  (define (.insert ident env type)
    (ITab.insert! (cit env) ident type (IEnv.insert-cid env)))
  (define (.insert-change ident do-list env type)
    (IEnv.change-cit env (.insert ident env type))
    (.do do-list env)
    (IEnv.recover-cit env))
  
  (define (.define code env)
    (.insert (car code) env 'Data))
  (define (.defunc code env)
    (.insert (car code) env 'Func))
  (define (.module code env)
    (.insert-change (car code) (cdr code) env 'Module))
  (define (.dim code env)
    (.insert (car code) env 'StVarb))
  (define (.restrict code env)
    (.insert (car code) env 'DyVarb))
  (define (.defstruct code env)
    (.insert-change (car code) (cdr code) env 'Struct))

  ;; cit : Current IdentTable
  (define cit IEnv.get-cit)
  
  (define (get-eval-func sym)
    (HashTable.get
     eval-func-map
     sym
     (lambda (code env)
       (display "Can't find ident '")
       (display sym)
       (display "'.\n"))))
  (define eval-func-map)
  (define (init-eval-func)
    (set! eval-func-map (make-eq-hashtable))
    (HashTable.insert! eval-func-map 'do        .do)
    (HashTable.insert! eval-func-map 'define    .define)
    (HashTable.insert! eval-func-map 'defunc    .defunc)
    (HashTable.insert! eval-func-map 'module    .module)
    (HashTable.insert! eval-func-map 'dim       .dim)
    (HashTable.insert! eval-func-map 'restrict  .restrict)
    (HashTable.insert! eval-func-map 'defstruct .defstruct))
)
