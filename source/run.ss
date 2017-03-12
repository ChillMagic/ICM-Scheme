; ICM on Scheme
; run.ss
; Author : Chill

; Load

(load "main.ss")

; Main

(define port (open-input-file "../run.chl"))
(expr-eval gfunc (read port))
