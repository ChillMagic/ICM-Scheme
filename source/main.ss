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

(import (ICM) (Basic) (ICM-Core)
  (prefix (HashTable) HashTable.)
  (prefix (GlobalFunc) GlobalFunc.)
  (prefix (Symbol) Symbol.)
  (prefix (List) List.)
  (prefix (Vector) Vector.)
  (prefix (String) String.)
)

(define gfunc (HashTable.new))

(GlobalFunc.init gfunc)
