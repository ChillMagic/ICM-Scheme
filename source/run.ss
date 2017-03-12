; ICM on Scheme
; run.ss
; Author : Chill

; Load

(load "main.ss")

; Main

(define port (open-input-file "../run.chl"))
(read-eval-all (load-port-file port))
