; ICM on Scheme
; basic.ss
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

(ifndef LOADED_BASIC
  (.define LOADED_BASIC)

  ; Load Library
  (load "common/library.ss")
  (.import
    (Output)
    (prefix (Symbol) Symbol.)
    (prefix (String) String.)
    (prefix (List) List.)
    (prefix (Vector) Vector.)
    (prefix (Convert) Convert.)
    (prefix (HashTable) HashTable.)
  )

  ; Config StringFormat
  (load "common/stringformat.ss")
  (init-stringformat)
)
