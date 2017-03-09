; ICM on Scheme
; globalfunc.ss
; Author : Chill

(load "basic.ss")

(library (GlobalFunc)
    (export gfunc gfunc-init)
    (import (rnrs) (HashTable)
            (prefix (Number) Number.)
            (prefix (String) String.))

    (define gfunc (new))

    (define (gfunc-init)
        (insert gfunc `Number.+ Number.f+)
        (insert gfunc `Number.- Number.f-)
        (insert gfunc `Number.* Number.f*)
        (insert gfunc `Number./ Number.f/)
        (insert gfunc `Number.= Number.f=)
        (insert gfunc `String.+ Number.f+)
        (insert gfunc `String.= Number.f=)))
