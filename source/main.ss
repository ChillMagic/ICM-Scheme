; ICM on Scheme
; main.ss
; Author : Chill

; Load

(load "load.ss")

; Main

(println (expr-eval gfunc `(Console.p (? T 5 6))))

(define ConvertTypeMap (HashTable.new))

(Convert.!-> ConvertTypeMap `String `Number string->number)
(Convert.!-> ConvertTypeMap `Number `String number->string)
(p ((Convert.-> ConvertTypeMap `Number `String) 5))


(p (string->list "123456789"))

(define (type e)
  (cond ((boolean? e)    'boolean)
        ((pair? e)       'pair)
        ((symbol? e)     'symbol)
        ((number? e)     'number)
        ((char? e)       'char)
        ((string? e)     'string)
        ((vector? e)     'vector)
        ((procedure? e)  'procedure)
        ((list? e)       'list)
        ((eof-object? e) 'eof)
        ((hashtable? e)  'hashtable)
        (else            'unkonwn)
  )
)



(p ConvertTypeMap)

(p hashtable-keys)


(define ahash (make-eq-hashtable))
(hashtable-set! ahash 0 "a")
(hashtable-set! ahash 1 "b")
(p (let-values (((keys values) (hashtable-entries ahash)))
  values
))
(p (hashtable-values ConvertTypeMap))

(p (type `(1 . 2)))

(p (string ))
