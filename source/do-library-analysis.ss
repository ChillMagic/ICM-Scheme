; ICM on Scheme
; do-library-analysis.ss
; Author : Chill

(load "library-analysis.ss")
(load "load.ss")

(define (load-libaray-file path filelist)
  (for-each
    (lambda (f)
      (.library-analysis
        (read
          (load-port-file
            (open-input-file (string-append path f) ))) 'global))
    filelist))

(load-libaray-file "../library/Core/" (directory-list "../library/Core/"))

(import
  (Output)
  (prefix (HashTable) HashTable.)
  (prefix (Vector) Vector.))


(define (.do-declare library ident in-args out port)
  (display "### " port) (display ident port) (newline port)
  (display "[" port)
  (for-each-with-inter (cdr in-args) (lambda (e) (display e port)) (lambda () (display " " port)))
  (display "] -> " port)
  (display out port)
  (display "\n" port))

(define (output-library-markdown identtable port)
  (display "# Library" port)
  (newline port)
  (HashTable.for-sort-each
    identtable
    Vector.symbol-sort
    (lambda (library v)
      (display "## " port)
      (display library port)
      (newline port)
      (newline port)
      (HashTable.for-sort-each
        v
        Vector.symbol-sort
        (lambda (k v)
          (.do-declare library k (vector-ref v 1) (vector-ref v 2) port)
          (newline port))))))

(define (.open-output-file f)
  (when (file-exists? f)
    (delete-file f))
  (open-output-file f))

(define port (.open-output-file "../library.md"))
(output-library-markdown GlobalIdentTable port)
