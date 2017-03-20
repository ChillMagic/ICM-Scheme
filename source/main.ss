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

(define ahash (make-eq-hashtable))
(hashtable-set! ahash 0 "a")
(hashtable-set! ahash 1 "b")
(hashtable-set! ahash 2 "c")
(println (ToStringFormat.to-string ahash))

;(p (hashtable-values ConvertTypeMap))

;(p (type `(1 . 2)))

;(p (string ))


;(p (for-each display `(1 2 3)))
