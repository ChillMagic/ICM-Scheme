; ICM on Scheme
; main.ss
; Author : Chill

; Load

(load "load.ss")

(import (prefix (ToStringFormat) ToStringFormat.))

; Main
(println (expr-eval gfunc `(Console.p "ss")))

;(define ConvertTypeMap (HashTable.new))

;(Convert.!-> ConvertTypeMap `String `Number string->number)
;(Convert.!-> ConvertTypeMap `Number `String number->string)
;(p ((Convert.-> ConvertTypeMap `Number `String) 5))

;(import (prefix (ToStringFormat) ToStringFormat.))

;(println (ToStringFormat.to-string (vector 1 2 3)))

(define GTable (HashTable.new))

(define (get-gtable s)
  (HashTable.get! GTable s HashTable.new))
(define (insert-gtable! s k v)
  (HashTable.insert! (get-gtable s) k v))

(import (prefix (Number) Number.)
(prefix (String) String.)
(prefix (Output) Output.))

(insert-gtable! 'Number '+ Number.+)
(insert-gtable! 'Number '- Number.-)
(insert-gtable! 'Number '* Number.*)
(insert-gtable! 'Number '/ Number./)
(insert-gtable! 'Number '= Number.=?)
(insert-gtable! 'String '+ String.+)
(insert-gtable! 'String '= String.=?)
(insert-gtable! 'Console 'print Output.print)
(insert-gtable! 'Console 'println Output.println)
(insert-gtable! 'Console 'p Output.p)

;(p GTable)

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

;(p (cons 5 b (list 5 6)))

(display (append (list 5 6) 5))

;(p (hashtable-values ConvertTypeMap))

;(p (type `(1 . 2)))

;(p (string ))


;(p (for-each display `(1 2 3)))
