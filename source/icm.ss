; ICM on Scheme
; icm.ss
; Author : Chill

(library (ICM)
    (export call)
    (import (rnrs) (Basic) (GlobalFunc)
            (prefix (HashTable) HashTable.)
            )
    
    (define (call code)
        (apply (HashTable.get gfunc (car code)) (cdr code)))
    
    (define (calc code)
        (cond ((null? code) nil)
              ((list? code) `())
              ((number? code) code))
    )
    
    (define (icm code) code)
)
