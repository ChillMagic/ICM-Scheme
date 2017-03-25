; ICM on Scheme
; load.ss
; Author : Chill

; Load

(load "basic.ss")
(load "globalfunc.ss")
(load "core.ss")
(load "icm.ss")
(load "read.ss")

; Import

(import (ICM) (ICM-Core)
  (prefix (GlobalFunc) GlobalFunc.))

; Functions

(define (read-eval-all gfunc port)
  (read-eval port (lambda (v) (expr-eval gfunc v))))

; Load

(ifndef LOADED_LOAD
  (.define LOADED_LOAD)
  (.define gfunc (HashTable.new))
  (GlobalFunc.init gfunc)
)
