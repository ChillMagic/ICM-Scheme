; ICM on Scheme
; read.ss
; Author : Chill

(define (load-port port fjudge)
  (let ((command ""))
    (let loop ()
      (let ((c (read-char port)))
        (if (fjudge c)
          (open-string-input-port command)
          (begin
            (cond ((char=? #\[ c)
                    (set! command (string-append command "(list ")))
                  ((char=? #\] c)
                    (set! command (string-append command ")")))
                  (else
                    (set! command (string-append command (string c)))))
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

(define (read-eval port eval)
  (let loop ((last `nil))
    (let ((v (read port)))
      (if (eof-object? v)
        last
        (loop (eval v))))))
