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

(import (ICM) (GlobalFunc) (Basic) (ICM-Core)
  (prefix (Symbol) Symbol.)
  (prefix (List) List.)
)

(gfunc-init)

(p (expr-eval `(? T 2 3)))
