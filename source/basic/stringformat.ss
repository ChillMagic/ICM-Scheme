; ICM on Scheme
; stringformat.ss
; Author : Chill

(define (init-stringformat)
  (import (ToStringFormat))

  (HashTable.insert! SystemToStringFormatTable
    'boolean
    (vector
      (lambda (e) (if e "T" "F"))
      (lambda (e) (if e "T" "F"))))

  (HashTable.insert! SystemToStringFormatTable
    'number
    (vector
      number->string
      number->string))

  (HashTable.insert! SystemToStringFormatTable
    'symbol
    (vector
      symbol->string
      (lambda (e) (String.+ ":" (symbol->string e)))))

  (HashTable.insert! SystemToStringFormatTable
    'string
    (vector
      (lambda (e) e)
      (lambda (e) (String.+ "\"" e "\""))))

  (HashTable.insert! SystemToStringFormatTable
    'char
    (vector
      string
      (lambda (e) (String.+ "'" (string e) "'"))))

  (HashTable.insert! SystemToStringFormatTable
    'eof
    (vector
      (lambda (e) "#eof")
      (lambda (e) "#eof")))

  (HashTable.insert! SystemToStringFormatTable
    'procedure
    (vector
      display-to-string
      display-to-string))


  (let ((to-format-with-container (lambda (container for-each-with-inter func prefix suffix middle)
    (let ((result prefix))
      (for-each-with-inter container
        (lambda (x . y) (set! result (String.+ result (apply func (append (list x) y)))))
        (lambda ()  (set! result (String.+ result middle))))
      (String.+ result suffix)))))


  (HashTable.insert! SystemToStringFormatTable
    'list
    (vector
      (lambda (e)
        (to-format-with-container e List.for-each-with-inter to-string "" "" ""))
      (lambda (e)
        (to-format-with-container e List.for-each-with-inter to-pformat "(" ")" " "))))

  (HashTable.insert! SystemToStringFormatTable
    'vector
    (vector
      (lambda (e)
        (to-format-with-container e Vector.for-each-with-inter to-string "" "" ""))
      (lambda (e)
        (to-format-with-container e Vector.for-each-with-inter to-pformat "[" "]" " "))))

  (HashTable.insert! SystemToStringFormatTable
    'hashtable
    (let ((to-format-hashtable
      (lambda (hashtable)

        (if (= (HashTable.size hashtable) 0)
          "{}"
          (to-format-with-container
            hashtable
            HashTable.for-each-with-inter
            (lambda (k v) (String.+ (to-pformat k) " => " (to-pformat v)))
            "{(" ")}" ") (")))))
      (vector
        to-format-hashtable
        to-format-hashtable))))
  'nil)
