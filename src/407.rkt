;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 407ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 407
;; ------------
;; Redesign row-filter using foldr. Once you have done so, you may merge
;; row-project and row-filter into a single function. *Hint* The foldr function
;; in ISL+ may consume two lists and process them in parallel. 
;; -----------------------------------------------------------------------------


(define-struct db [schema content])
; A DB is a structure: (make-db Schema Content)
 
; A Schema    is a [List-of Spec]
; Spec is a structure: (make-spec Label Predicate)
(define-struct spec [label predicate])
; A Label     is a String
; A Predicate is a [Any -> Boolean]
 
; A (piece of) Content is a [List-of Row]
; A Row is a [List-of Cell]
; A Cell is Any
; constraint cells do not contain functions 
 
; integrity constraint In (make-db sch con), 
; for every row in con,
; (I1) its length is the same as sch's, and
; (I2) its ith Cell satisfies the ith Predicate in sch

(define school-schema
  `(,(make-spec "Name"    string?)
    ,(make-spec "Age"     integer?)
    ,(make-spec "Present" boolean?)))
 
(define presence-schema
  `(,(make-spec "Present"     boolean?)
    ,(make-spec "Description" string?)))
 
(define school-content
  `(("Alice" 35 #true)
    ("Bob"   25 #false)
    ("Carol" 30 #true)
    ("Dave"  32 #false)))
 
(define presence-content
  `((#true  "presence")
    (#false "absence")))
 
(define school-db
  (make-db school-schema
           school-content))
 
(define presence-db
  (make-db presence-schema
           presence-content))


;; -----------------------------------------------------------------------------


(define projected-content
  `(("Alice" #true)
    ("Bob"   #false)
    ("Carol" #true)
    ("Dave"  #false)))
 
(define projected-schema
  `(("Name" ,string?) ("Present" ,boolean?)))
 
(define projected-db
  (make-db projected-schema projected-content))



; DB [List-of Label] -> DB
; retains a column from db if its label is in labels

(check-expect
 (db-content (project.v1 school-db '("Name" "Present")))
  projected-content)

(define (project.v1 db labels)
  (local ((define schema  (db-schema db))
          (define content (db-content db))
          (define schema-labels (map spec-label schema))
 
          ; Spec -> Boolean
          ; does this column belong to the new schema
          (define (keep? c)
            (member? (spec-label c) labels))
 
          ; Row -> Row
          ; retains those columns whose name is in labels
          (define (row-project row)
            (foldr (λ (r n a) (if (member? n labels) (cons r a) a))
                   '()
                   row
                   schema-labels)))
    (make-db (filter keep? schema)
             (map row-project content))))
