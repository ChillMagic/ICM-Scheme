; ICM on Scheme
; basic.ss
; Author : Chill

; Load Macro
(load "basic/macro.ss")

(ifndef LOADED_BASIC
  (.define LOADED_BASIC)

  ; Load Library
  (load "basic/library.ss")
  (.import
    (Output)
    (prefix (Symbol) Symbol.)
    (prefix (String) String.)
    (prefix (List) List.)
    (prefix (Vector) Vector.)
    (prefix (Convert) Convert.)
    (prefix (HashTable) HashTable.)
  )

  ; Config StringFormat
  (load "basic/stringformat.ss")
  (init-stringformat)
)
