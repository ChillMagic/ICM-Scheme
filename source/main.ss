; ICM on Scheme
; main.ss
; Author : Chill

; Load

(load "load.ss")

; Main

(import (prefix (Convert) Convert.))

(p (expr-eval gfunc `(Console.p (? T 5 6))))

(define ConvertTypeMap (HashTable.new))

(Convert.!-> ConvertTypeMap `String `Number string->number)
(p ((Convert.-> ConvertTypeMap `String `Number) "5"))
