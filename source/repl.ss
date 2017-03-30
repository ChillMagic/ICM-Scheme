; ICM on Scheme
; repl.ss
; Author : Chill

; Load

(load-relative "load.ss")

; Main
(println "ICM on Scheme 0.1")
(println "Chill Ver.0.3")
(println "")

(define (repl)
  (let loop ()
    (print "> ")
    (let ((code (read-eval-all gfunc (load-port-line))))
      (print "=> ")
      (p code)
      (println "")
      (loop))))

(repl)
