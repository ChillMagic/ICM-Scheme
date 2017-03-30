; ICM on Scheme
; identtable.ss
; Author : Chill

(load-relative "../basic.ss")
(load-relative "analysisbase.ss")
(load-relative "identtable.ss")

(library (ICM-IdentEnvironment)
  (export new)
  (import (rnrs)
          (prefix (IdentTable) IdentTable.))
  (define (new)
    0)
)

(import (prefix (IdentTable) IdentTable.)
        (prefix (ICM-IdentEnvironment) ICM-IdentEnvironment.))

(library (ICM-IdentAnalysis)
  (export eval init-eval-func)
  (import (rnrs) (ICM-AnalysisBase)
          (prefix (HashTable) HashTable.)
          (prefix (List) List.))

  (define (eval code env)
    (do-eval get-eval-func code env))

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
  (define eval-func-map (make-eq-hashtable))
  (define (get-eval-func sym)
    (HashTable.get
     eval-func-map
     sym
     (lambda (code env)
       (display "Can't find ident '")
       (display sym)
       (display "'.\n"))))
  (define (init-eval-func)
    (HashTable.insert! eval-func-map 'do (lambda (code env)
                                 (List.for-each
                                  code
                                  (lambda (x) (do-eval get-eval-func x env)))))
    (HashTable.insert! eval-func-map 'define    .define)
    (HashTable.insert! eval-func-map 'defunc    .defunc)
    (HashTable.insert! eval-func-map 'module    .module)
    (HashTable.insert! eval-func-map 'dim       .dim)
    (HashTable.insert! eval-func-map 'defstruct .defstruct)
    (HashTable.insert! eval-func-map 'restrict  .restrict))

)

(import (prefix (ICM-IdentAnalysis) ICM-IdentAnalysis.))
(ICM-IdentAnalysis.init-eval-func)

(define GlobalIdentTable (IdentTable.new 'Module '%root))

(p GlobalIdentTable)

(define testcode
  '(do (define a)
    (defunc b)
    (module A (define a) (defunc b))
    (defstruct B (dim a) (dim b) (define c))
    (dim c)))

(define genv (ICM-IdentEnvironment.new))

(ICM-IdentAnalysis.eval testcode GlobalIdentTable)
