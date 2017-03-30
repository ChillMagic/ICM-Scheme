; ICM on Scheme
; globalfunc.ss
; Author : Chill

(load-relative "basic.ss")

(library (GlobalFunc)
  (export init call)
  (import (rnrs)
    (prefix (ToStringFormat) ToStringFormat.)
    (prefix (HashTable) HashTable.)
    (prefix (Output) Output.)
    (prefix (Symbol) Symbol.)
    (prefix (Number) Number.)
    (prefix (String) String.))

  (define (init gfunc)
    (HashTable.insert! gfunc `Number.+ Number.+)
    (HashTable.insert! gfunc `Number.- Number.-)
    (HashTable.insert! gfunc `Number.* Number.*)
    (HashTable.insert! gfunc `Number./ Number./)
    (HashTable.insert! gfunc `Number.= Number.=?)
    (HashTable.insert! gfunc `String.+ String.+)
    (HashTable.insert! gfunc `String.= String.=?)
    (HashTable.insert! gfunc `Console.p Output.p)
    (HashTable.insert! gfunc `Console.print Output.print)
    (HashTable.insert! gfunc `Console.println Output.println)
  )

  (define (call gfunc fsym args fx)
    (let ((f (HashTable.get gfunc fsym)))
      (if (Symbol.is? f)
        (fx fsym)
        (apply f args)))))
