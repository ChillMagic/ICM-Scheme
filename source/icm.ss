; ICM on Scheme
; icm.ss
; Author : Chill

(load "globalfunc.ss")

(library (ICM)
  (export)
  (import (rnrs) (Basic)
    (prefix (GlobalFunc) GlobalFunc.))

  (define (calc code)
      (cond ((null? code) `nil)
            ((list? code) `())
            ((number? code) code))
  )

  (define (icm code) code)
)
