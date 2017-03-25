; ICM on Scheme
; basic.ss
; Author : Chill

(define-syntax ifndef
  (syntax-rules ()
    ((_ ident expr ...)
      (guard (ex (expr ...)) ident))))

(ifndef LOADED_BASIC
  (load "common/library.ss")
  (load "common/stringformat.ss")
  (init-stringformat)
)

(import (Output))

(define LOADED_BASIC)
