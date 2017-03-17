; ICM on Scheme
; icm.ss
; Author : Chill

(load "globalfunc.ss")

(library (ICM)
  (export)
  (import (rnrs)
    (prefix (GlobalFunc) GlobalFunc.))

  (define (calc code)
      (cond ((null? code) `nil)
            ((list? code) `())
            ((number? code) code))
  )

  (define (icm code) code)
)
