; ICM on Scheme
; basic.ss
; Author : Chill

; Load Macro
(load-relative "basic/macro.ss")

; Load Basic
(ifndef LOADED_BASIC
  (.define LOADED_BASIC)

  ; Load Library
  (load-relative "basic/library.ss")
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
  (load-relative "basic/stringformat.ss")
  (init-stringformat)
)
