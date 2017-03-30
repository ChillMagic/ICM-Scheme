; ICM on Scheme
; loadrelative.ss
; Author : Chill

(define (string->path spath)
  (let loop ((lst (string->list spath)) (field (list)) (plst (list)))
    (if (null? lst)
        (if (null? field) plst (append plst (list (list->string field))))
        (let ((f (car lst)))
          (if (or (char=? f #\\) (char=? f #\/))
              (loop (cdr lst) (list) (append plst (list (list->string field))))
              (loop (cdr lst) (append field (list f)) plst))))))

(define (path->string path)
  (let loop ((lst path) (srst ""))
    (if (null? lst)
        srst
        (loop (cdr lst) (string-append srst (car lst) "/")))))

(define (get-filepath filespath)
  (let ((i 0) (rec 0) (plst (list)))
    (for-each
     (lambda (c)
       (when (or (char=? c #\\) (char=? c #\/))
         (set! plst (append plst (list (substring filespath rec i))))
         (set! rec (+ i 1)))
       (set! i (+ i 1)))
     (string->list filespath))
    plst))

(define load-path (string->path (current-directory)))

(define (set-load-path spath)
  (set! load-path spath))

(define (load-relative filename)
  (let ((filespath (string-append (path->string load-path) filename)))
    (if (file-exists? filespath)
        (begin
          (let ((recordpath load-path))
            (set-load-path (get-filepath filespath))
            (load filespath)
            (set-load-path recordpath)))
        (begin
          (display "Error in open file '")
          (display filespath)
          (display "'.")
          (newline)))))
