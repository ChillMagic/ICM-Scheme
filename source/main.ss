; ICM on Scheme
; main.ss
; Author : Chill

; Load

(load "load.ss")

; Main

(import (prefix (Convert) Convert.))

(println (expr-eval gfunc `(Console.p (? T 5 6))))

(define ConvertTypeMap (HashTable.new))

(Convert.!-> ConvertTypeMap `String `Number string->number)
(Convert.!-> ConvertTypeMap `Number `String number->string)
(p ((Convert.-> ConvertTypeMap `Number `String) 5))
