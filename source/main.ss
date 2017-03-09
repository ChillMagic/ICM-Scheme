; ICM on Scheme
; main.ss
; Author : Chill

; Load

(load "basic.ss")
(load "library.ss")
(load "globalfunc.ss")
(load "icm.ss")

; Main

(import (ICM) (GlobalFunc) (Basic))

(gfunc-init)

(p (call `(Number.+ 5 6)))
