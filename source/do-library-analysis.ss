;; ICM on Scheme
;; do-library-analysis.ss
;; Author : Chill

(load-relative "library-analysis.ss")
(load-relative "read.ss")

(import (Output) (ICM-LibraryAnalysis)
        (prefix (HashTable) HashTable.)
        (prefix (List) List.)
        (prefix (Vector) Vector.))

(define (load-library-file path filelist)
  (for-each
   (lambda (f)
     (.library-analysis
      (read
       (load-port-file
        (open-input-file (string-append path f) ))) 'global))
   filelist))

(define (.display-list lst port)
  (List.for-each-with-inter
   lst
   (lambda (e) (.display e port))
   (lambda () (display " " port))))

(define (.display e port)
  (if (list? e)
      (if (and (symbol? (car e)) (symbol=? (car e) 'list))
          (begin
            (display "[" port)
            (.display-list (cdr e) port)
            (display "]" port))
          (begin
            (display "(" port)
            (.display-list e port)
            (display ")" port)))
      (display e port)))

(define (.do-declare library ident in-args out port)
  (display "### " port) (display ident port) (newline port)
  (display "[" port)
  (for-each-with-inter (cdr in-args) (lambda (e) (.display e port)) (lambda () (display " " port)))
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

;;(let ((path "../library/Core/"))
;;  (load-libaray-file path (directory-list path)))

(load-library-file "../library/Core/" '("Boolean.chl"))

(load-relative "common/identanalysis.ss")
(import (prefix (IdentTable) IdentTable.))

(define btable (HashTable.get GlobalIdentTable 'Boolean))

(println "-------------------")
;(p btable)


(Vector.for-each (HashTable.keys btable) (lambda (k) (print k " => ") (p (HashTable.get btable k))))

(exit)

(p (HashTable.get GlobalIdentTable 'Boolean))

(HashTable.for-each-with-inter
 (HashTable.get GlobalIdentTable 'Boolean)
 p
 (newline)
 )
;;(IdentTable.print-table GlobalIdentTable)
;;(output-library-markdown GlobalIdentTable (.open-output-file "../library.md"))
;;(output-library-markdown GlobalIdentTable (current-output-port))
