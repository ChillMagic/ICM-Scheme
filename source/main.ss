; ICM on Scheme
; main.ss
; Author : Chill

; Load

(load "basic.ss")
(load "library.ss")
(load "globalfunc.ss")
(load "core.ss")
(load "icm.ss")

; Main

(import (ICM) (Basic) (ICM-Core)
  (prefix (HashTable) HashTable.)
  (prefix (GlobalFunc) GlobalFunc.)
  (prefix (Symbol) Symbol.)
  (prefix (List) List.)
  (prefix (Vector) Vector.)
  (prefix (String) String.)
)

(define gfunc (HashTable.new))

(GlobalFunc.init gfunc)

(define (load-port port jfunc)
  (let ((command ""))
    (let loop ()
      (let ((c (read-char port)))
        (if (jfunc c)
          (open-input-string command)
          (begin
            (cond ((char=? #\[ c) (set! command (String.f+ command (string #\() "list")))
                  ((char=? #\] c) (set! command (String.f+ command (string #\)))))
                  (else (set! command (String.f+ command (string c)))))
            (loop)))))))

(define-syntax load-port-line
  (syntax-rules ()
    ((_ port) (load-port port (lambda (c) (or (eof-object? c) (and (char? c) (char=? #\newline c))))))
    ((_) (load-port-line (current-input-port)))))

(define-syntax load-port-file
  (syntax-rules ()
    ((_ port) (load-port port eof-object?))
    ((_) (load-port-file (current-input-port)))))

(define (read-eval-all port)
  (let loop ((last `nil))
    (let ((v (read port)))
      (if (eof-object? v)
        last
        (loop (expr-eval gfunc v))))))
