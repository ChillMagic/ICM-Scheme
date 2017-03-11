; ICM on Scheme
; basic.ss
; Author : Chill

(library (Basic)
    (export T F nil print println p do-list)
    (import (rnrs))
    (define T `T)
    (define F `F)
    (define nil `nil)
    (define print display)
    (define (println x)
        (begin (display x) (newline)))
    (define p println)
    (define (do-list lst func)
      (let loop ((lst lst))
        (if (not (null? lst))
          (begin
            (func (car lst))
            (loop (cdr lst)))))))
