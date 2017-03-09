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

(import (ICM) (GlobalFunc) (Basic) (ICM-Core))

(gfunc-init)

(p (call `(Number.+ 5 6)))
(p (expr-? `(? T 5 6)))
