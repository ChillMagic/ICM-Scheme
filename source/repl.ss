; ICM on Scheme
; repl.ss
; Author : Chill

; Load

(load "main.ss")

; Main

(println "ICM on Scheme 0.1")
(println "Chill Ver.0.3")
(println "")

(let loop ()
  (print "> ")
  (let ((code (read-eval-all (load-port-line))))
    (print "=> ")
    (println code)
    (println "")
    (loop)))
