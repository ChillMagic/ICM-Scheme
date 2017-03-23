; ICM on Scheme
; load.ss
; Author : Chill

; Load

(load "basic.ss")
(load "library.ss")
(load "globalfunc.ss")
(load "core.ss")
(load "icm.ss")
(load "stringformat.ss")

; Import

(import (ICM) (Output) (ICM-Core)
  (prefix (HashTable) HashTable.)
  (prefix (GlobalFunc) GlobalFunc.)
  (prefix (Symbol) Symbol.)
  (prefix (List) List.)
  (prefix (Vector) Vector.)
  (prefix (String) String.)
  (prefix (Convert) Convert.)
)

; Load Config

; Functions

(load "read.ss")

(define (read-eval-all gfunc port)
  (read-eval port (lambda (v) (expr-eval gfunc v))))

(define gfunc (HashTable.new))

(init-stringformat)
(GlobalFunc.init gfunc)
