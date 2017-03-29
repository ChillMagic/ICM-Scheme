; ICM on Scheme
; macro.ss
; Author : Chill

(define-syntax ifndef
  (syntax-rules ()
    ((_ ident expr ...)
      (guard (ex (expr ...)) ident))))

(define-syntax .define
  (syntax-rules ()
    ((_ expr ...)
      (eval (quote (define expr ...))))))

(define-syntax .import
  (syntax-rules ()
    ((_ expr ...)
      (eval (quote (import expr ...))))))
