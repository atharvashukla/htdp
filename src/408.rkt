;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 408ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 408
;; ------------
;; Design the function select. It consumes a database, a list of labels, and a
;; predicate on rows. The result is a list of rows that satisfy the given
;; predicate, projected down to the given set of labels.
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

(define select-school-content
  `(("Bob" 25 #false)))

(define select-school-db
  (make-db school-schema select-school-content))

; Row -> Boolean
; is the age in the row less than 30 years?

(check-expect (age-<-30? '("Bob"   25 #false)) #true)
(check-expect (age-<-30? '("Carol" 30 #true)) #false)

(define (age-<-30? row)
  (< (second row) 30))

; DB [List-of Label] [Any -> Boolean] -> [List-of Row]
; list of rows in db that satisfy row-pred, projected down to labels

(check-expect (select school-db '("Name" "Age" "Present") age-<-30?)
              select-school-db)

(check-expect (db-content (select school-db '("Name" "Age") (λ (r) (>= (second r) 30))))
              `(("Alice" 35) ("Carol" 30) ("Dave" 32)))

(define (select db labels row-pred)
  (project (make-db (db-schema db)
                    (filter row-pred (db-content db)))
           labels))


;; -----------------------------------------------------------------------------
;; Projection


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
 (db-content (project school-db '("Name" "Present")))
 projected-content)

(define (project db labels)
  (local ((define schema  (db-schema db))
          (define content (db-content db))
 
          ; Spec -> Boolean
          ; does this column belong to the new schema
          (define (keep? c)
            (member? (spec-label c) labels))
 
          ; Row -> Row 
          ; retains those columns whose name is in labels
          (define (row-project row)
            (foldr (lambda (cell m c) (if m (cons cell c) c))
                   '()
                   row
                   mask))
          ; [List-of Boolean] what spec labels are worth keeping?
          (define mask (map keep? schema)))
    (make-db (filter keep? schema)
             (map row-project content))))