; ICM on Scheme
; main.ss
; Author : Chill

; Load

(load "load.ss")

(init-stringformat)

(import (prefix (ToStringFormat) ToStringFormat.))

(p #t)

; Main

;(println (expr-eval gfunc `(Console.p (? T 5 6))))

;(define ConvertTypeMap (HashTable.new))

;(Convert.!-> ConvertTypeMap `String `Number string->number)
;(Convert.!-> ConvertTypeMap `Number `String number->string)
;(p ((Convert.-> ConvertTypeMap `Number `String) 5))

;(import (prefix (ToStringFormat) ToStringFormat.))

;(println (ToStringFormat.to-string (vector 1 2 3)))


(print (vector 5 6 7))
(p "sssS")


(define ahash (make-eq-hashtable))
(hashtable-set! ahash 0 "a")
(hashtable-set! ahash 1 "b")
(hashtable-set! ahash 2 "c")
(println (ToStringFormat.to-string ahash))

;(p (hashtable-values ConvertTypeMap))

;(p (type `(1 . 2)))

;(p (string ))


;(p (for-each display `(1 2 3)))
