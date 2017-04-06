;; ICM on Scheme
;; precompile.ss
;; Author : Chill

(load-relative "../basic.ss")
(load-relative "../common/analysisbase.ss")

(library (ICM-Compiler-Precompile)
  (export execute)
  (import (rnrs)
          (ICM-AnalysisBase))
  (define (execute code env)
    (vector code env))
  )

(import (prefix (ICM-Compiler-Precompile) ICP.))

(p (ICP.execute '(+ 5 6) '%root))
