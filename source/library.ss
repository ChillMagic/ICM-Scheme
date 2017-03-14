; ICM on Scheme
; library.ss
; Author : Chill

(load "basic.ss")

(library (Number)
         (export is? + - * / =?)
         (import
           (except (rnrs) + - * / =)
           (prefix (rnrs) rnrs.))
         (define is? number?)
         (define + rnrs.+)
         (define - rnrs.-)
         (define * rnrs.*)
         (define / rnrs./)
         (define =? rnrs.=))

(library (String)
         (export is? + =? ->Symbol)
         (import (except (rnrs) +))
         (define is? string?)
         (define + string-append)
         (define =? string=?)
         (define ->Symbol string->symbol))

(library (Symbol)
         (export is? =? ->String)
         (import (rnrs))
         (define is? symbol?)
         (define =? symbol=?)
         (define ->String symbol->string))

(library (List)
         (export is? make + get empty? reverse)
         (import (except (rnrs) +))
         (define is? list?)
         (define make list)
         (define + append)
         (define get list-ref)
         (define empty? null?)
         )

(library (Vector)
         (export new make is? size get set)
         (import (rnrs))
         (define new make-vector)
         (define make vector)
         (define is? vector?)
         (define size vector-length)
         (define get vector-ref)
         (define set vector-set!))

(library (HashTable)
         (export new is? insert get set get!)
         (import (rnrs))
         (define new make-eq-hashtable)
         (define is? hashtable?)
         (define insert hashtable-set!)
         (define-syntax get
           (syntax-rules ()
             ((_ hashtable key)   (hashtable-ref hashtable key `nil))
             ((_ hashtable key expr)
               (let ((val (hashtable-ref hashtable key `nil)))
                 (if (and (symbol? val) (symbol=? val `nil))
                   expr
                   val)))))
         (define (set hashtable key obj)
           (hashtable-set! hashtable key obj) obj)
         (define (get! hashtable type default)
           (get hashtable type
             (set hashtable type (default)))))

(library (Convert)
         (export -> !->)
         (import (rnrs) (Basic)
           (prefix (HashTable) HashTable.))

         (define (!-> table t1 t2 f)
           (HashTable.set (HashTable.get! table t1 HashTable.new) t2 f))

         (define (-> table t1 t2)
           (HashTable.get
             (HashTable.get! table t1 HashTable.new)
             t2
             (lambda (v) (println "Error in function " (list `-> t1 t2) ".")
                         `nil))))
