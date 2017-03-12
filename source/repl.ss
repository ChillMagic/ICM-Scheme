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
  (let ((code (read)))
    (print "=> ")
    (println (expr-eval gfunc code))
    (println "")
  )
(loop))
