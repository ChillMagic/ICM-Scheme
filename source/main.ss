;; ICM on Scheme
;; main.ss
;; Author : Chill

;; Load

(load-relative "load.ss")
(load-relative "common/identanalysis.ss")

(import (prefix (ToStringFormat) ToStringFormat.))

;; Main
(p (expr-eval '(Console.println (? T 5 6)) gfunc))

(exit)

;;(define ConvertTypeMap (HashTable.new))

;;(Convert.!-> ConvertTypeMap `String `Number string->number)
;;(Convert.!-> ConvertTypeMap `Number `String number->string)
;;(p ((Convert.-> ConvertTypeMap `Number `String) 5))


(define GTable (HashTable.new))

(define (get-gtable s)
  (HashTable.get! GTable s HashTable.new))
(define (insert-gtable! s k v)
  (HashTable.insert! (get-gtable s) k v))


(insert-gtable! 'Number '+ Number.+)
(insert-gtable! 'Number '- Number.-)
(insert-gtable! 'Number '* Number.*)
(insert-gtable! 'Number '/ Number./)
(insert-gtable! 'Number '= Number.=?)
(insert-gtable! 'String '+ String.+)
(insert-gtable! 'String '= String.=?)
(insert-gtable! 'Console 'print print)
(insert-gtable! 'Console 'println println)
(insert-gtable! 'Console 'p p)

;;(p GTable)

(define (print-gtable)
  (println "{")
  (HashTable.for-each
   GTable
   (lambda (k v)
     (println
      "  "
      (ToStringFormat.to-pformat k)
      " => "
      (ToStringFormat.to-pformat v))))
  (println "}"))

(print-gtable)

(import (prefix (ICM-IdentAnalysis) ICM-IdentAnalysis.)
        (prefix (IdentTable) IdentTable.)
        (prefix (ICM-IdentEnvironment) ICM-IdentEnvironment.))

(ICM-IdentAnalysis.init-eval-func)
(define gienv (ICM-IdentEnvironment.new))

(define testcode
  '(do (define a)
       (defunc b)
     (module A (define a) (defunc b))
     (defstruct B (dim a) (dim b) (define c))
     (dim c)))

(ICM-IdentAnalysis.eval testcode gienv)

(IdentTable.print (ICM-IdentEnvironment.get-cit gienv))
