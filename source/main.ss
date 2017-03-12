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

(p (vector? '#(1 2 3)))

(define-namedstruct Point (x ...)
  (export)
  (import
    (prefix (Vector) Vector.))
)

(import (prefix (Point) Point.))
(import (prefix (Vector) Vector.))
(import (prefix (Symbol) Symbol.))

(p (Point.new 5 6))
(p (Point.is? (Point.new 5 6)))
