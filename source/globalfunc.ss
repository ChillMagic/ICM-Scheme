; ICM on Scheme
; globalfunc.ss
; Author : Chill

(load "basic.ss")
(load "library.ss")

(library (GlobalFunc)
  (export init call)
  (import (rnrs) (HashTable)
    (prefix (Basic) Basic.)
    (prefix (Symbol) Symbol.)
    (prefix (Number) Number.)
    (prefix (String) String.))

  (define (init gfunc)
    (insert gfunc `Number.+ Number.f+)
    (insert gfunc `Number.- Number.f-)
    (insert gfunc `Number.* Number.f*)
    (insert gfunc `Number./ Number.f/)
    (insert gfunc `Number.= Number.=?)
    (insert gfunc `String.+ String.f+)
    (insert gfunc `String.= String.=?)
    (insert gfunc `Console.p Basic.p)
    (insert gfunc `Console.print Basic.print)
    (insert gfunc `Console.println Basic.println)
  )

  (define (call gfunc fsym args)
    (let ((f (get gfunc fsym)))
      (if (Symbol.is? f)
        `nil
        (apply f args)))))
