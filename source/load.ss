; ICM on Scheme
; load.ss
; Author : Chill

; Load

(load-relative "basic.ss")
(load-relative "globalfunc.ss")
(load-relative "core.ss")
(load-relative "icm.ss")
(load-relative "read.ss")

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
