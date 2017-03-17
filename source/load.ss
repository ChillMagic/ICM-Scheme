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

(define (load-port port jfunc)
  (let ((command ""))
    (let loop ()
      (let ((c (read-char port)))
        (if (jfunc c)
          (open-string-input-port command)
          (begin
            (cond ((char=? #\[ c)
                    (set! command (String.+ command "(list ")))
                  ((char=? #\] c)
                    (set! command (String.+ command ")")))
                  (else
                    (set! command (String.+ command (string c)))))
            (loop)))))))

(define-syntax load-port-line
  (syntax-rules ()
    ((_ port) (load-port port
      (lambda (c) (or (eof-object? c) (and (char? c) (char=? #\newline c))))))
    ((_) (load-port-line (current-input-port)))))

(define-syntax load-port-file
  (syntax-rules ()
    ((_ port) (load-port port eof-object?))
    ((_) (load-port-file (current-input-port)))))

(define (read-eval-all gfunc port)
  (let loop ((last `nil))
    (let ((v (read port)))
      (if (eof-object? v)
        last
        (loop (expr-eval gfunc v))))))

(define gfunc (HashTable.new))

(init-stringformat)
(GlobalFunc.init gfunc)
