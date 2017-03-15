; ICM on Scheme
; run.ss
; Author : Chill

; Load

(load "load.ss")

; Main

(define port (open-input-file "../run.chl"))
(read-eval-all gfunc (load-port-file port))
