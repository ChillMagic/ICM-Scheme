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

(p (expr-eval `(? T (? T 5 6) 3)))

(p (expr-eval `(do 5 6)))
