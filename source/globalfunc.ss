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
    (insert gfunc `String.+ Number.f+)
    (insert gfunc `String.= Number.=?)
    (insert gfunc `Console.p (lambda (x) (Basic.p x) x))
    (insert gfunc `Console.print (lambda (x) (Basic.print x) x))
    (insert gfunc `Console.println (lambda (x) (Basic.println x) x))
  )

  (define (call gfunc fsym args)
    (let ((f (get gfunc fsym)))
      (if (Symbol.is? f)
        `nil
        (apply f args)
      )
      ))
    )
