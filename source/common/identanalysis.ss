;; ICM on Scheme
;; identtable.ss
;; Author : Chill

(load-relative "../basic.ss")
(load-relative "analysisbase.ss")
(load-relative "identtable.ss")

(library (ICM-IdentEnvironment)
  (export new Icid Icit Iitdat)
  (import (rnrs)
          (prefix (Vector) Vector.)
          (prefix (Stack) Stack.)
          (prefix (IdentTable) IdentTable.))

  (define Icid   0) ; cid   : Current Insert Index
  (define Icit   1) ; cit   : Current IdentTable
  (define Iitdat 2) ; itdat : IdentTable Data
  
  (define (new)
    (let ((git (IdentTable.new 0 'Module '%root)))
      (vector 0 (Stack.push (Stack.new) git) git)))

  (define (get ienv prop) (Vector.get ienv prop))
  (define (set ienv prop inc) (Vector.set ienv prop inc))

  (define (insert-cid ienv)
    (let ((id (+ (get ienv Icid) 1)))
      (set ienv Icid id) id))
  )


(import (prefix (IdentTable) IdentTable.)
        (prefix (ICM-IdentEnvironment) ICM-IdentEnvironment.))

(p (ICM-IdentEnvironment.new))

(library (ICM-IdentAnalysis)
  (export eval init-eval-func)
  (import (rnrs) (ICM-AnalysisBase)
          (prefix (HashTable) HashTable.)
          (prefix (List) List.))

  (define (eval code env)
    (do-eval get-eval-func code env))

  (define (.do code env)
    (List.for-each code (lambda (x) (do-eval get-eval-func x env))))
  (define (.define code env)
    code)
  (define (.defunc code env)
    code)
  (define (.module code env)
    code)
  (define (.dim code env)
    code)
  (define (.restrict code env)
    code)
  (define (.defstruct code env)
    code)
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
    (HashTable.insert! eval-func-map 'defstruct .defstruct)
    (HashTable.insert! eval-func-map 'restrict  .restrict))

  )

(import (prefix (ICM-IdentAnalysis) ICM-IdentAnalysis.))
(ICM-IdentAnalysis.init-eval-func)

(define testcode
  '(do (define a)
       (defunc b)
     (module A (define a) (defunc b))
     (defstruct B (dim a) (dim b) (define c))
     (dim c)))

(define genv (ICM-IdentEnvironment.new))

(p (ICM-IdentAnalysis.eval testcode genv))
