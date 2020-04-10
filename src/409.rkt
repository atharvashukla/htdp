;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 409ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 409
;; ------------
;; Design reorder. The function consumes a database db and list lol of Labels.
;; It produces a database like db but with its columns reordered according to
;; lol. *Hint* Read up on list-ref.
;;
;; At first assume that lol consists exactly of the labels of db’s columns. Once
;; you have completed the design, study what has to be changed if lol contain
;; fewer labels than there are columns and strings that are not labels of a
;; column in db. 
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
  `(,(make-spec "Name"    string?) ,(make-spec "Age"     integer?) ,(make-spec "Present" boolean?)))
 
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

(define reordered-school-schema
  `(,(make-spec "Age"     integer?) ,(make-spec "Present" boolean?) ,(make-spec "Name"    string?)))

(define reordered-school-schema-pres-name
  `(,(make-spec "Present" boolean?) ,(make-spec "Name"    string?)))


(define reordered-school-content
  `((35 #true "Alice")
    (25 #false "Bob")
    (30 #true "Carol")
    (32 #false "Dave")))

(define reordered-school-content-pres-name
  `((#true "Alice")
    (#false "Bob")
    (#true "Carol")
    (#false "Dave")))

(define reordered-school-db
  (make-db reordered-school-schema
           reordered-school-content))

(define reordered-school-db-pres-name
  (make-db reordered-school-schema-pres-name
           reordered-school-content-pres-name))



; DB [List-of Label] -> DB
; colums of db reordered according to lol

(check-expect (db-content (reorder school-db '("Age" "Present" "Present" "Name" "just do it")))
              (db-content reordered-school-db))

(check-expect (db-content (reorder school-db '("Present" "Present" "Name" "just do it")))
              (db-content reordered-school-db-pres-name))

(define (reorder db lol)
  (local ((define new-lol (remove-duplicates (sanitize-lol lol db)))
          (define projected-db (project db new-lol)))
    (reorder-assump projected-db new-lol)))



; DB [List-of Label] -> DB
; colums of db reordered according to lol
; ASSUMPTION: the labels in DB are a variant
; of spec labels in db

#;
(define (reorder db lol)
  db)


; I)
; '("Name" "Age" "Present")
;    0       1        2
; '("Age" "Present" "Name")
;     1       2       0
; solution (map index-of-elem '("Name" "Age" "Present") in '("Age" "Present" "Name")
; II)
; '("Alice" 35 #true) '(1 2 0)d
; =>
; '(35 #true "Alice")
; solution: (map element-at-index on '(35 #true "Alice") using '(1 2 0))

(check-expect (db-content (reorder-assump school-db '("Age" "Present" "Name")))
              (db-content reordered-school-db))

#;
(define (reorder db lol)
  (local ((define schema (db-schema db))
          (define content (db-content db)))
    (make-db ... schema ...
             ... content ...)))

(define (reorder-assump db lol)
  (local ((define schema (db-schema db))
          (define content (db-content db))
          (define schema-labels (map spec-label schema))
          (define reorder-index
            (map (λ (e)
                   ; index of each label element in schema-labels
                   (index-of-elem schema-labels e equal?))
                 lol))

          ; [X] [List-of X] -> [List-of X]
          ; reordering l using index list reorder-index
          (define (reorder-by-idx l)
            (map (λ (num) (elem-at-idx l num)) reorder-index))

          (define reordered-schema (reorder-by-idx schema))
          (define reordered-content (map (λ (row) (reorder-by-idx row)) content)))
    
    (make-db reordered-schema reordered-content)))

; [List-of String] DB -> [List-of String]
; remove strings from lol that aren't spec labels in 

(check-expect (sanitize-lol '("Age" "DOB" "Present" "Sport" "Name") school-db)
              '("Age" "Present" "Name"))

(define (sanitize-lol lol db)
  (local ((define db-schema-labels (map spec-label (db-schema db)))
          ; [List-of String] -> [List-of String]
          ; remove the labels in l that aren't a member of db-schema-labels
          (define (sanitize-l l)
            (cond
              [(empty? l) '()]
              [else (if (member? (first l) db-schema-labels)
                        (cons (first l) (sanitize-l (rest l)))
                        (sanitize-l (rest l)))])))
    (sanitize-l lol)))

; [List-of String] -> [List-of
; remove duplicates from lol

(check-expect (remove-duplicates '("a" "c" "s" "a")) '("a" "c" "s"))
(check-expect (remove-duplicates '("a" "a" "a" "a")) '("a"))
(check-expect (remove-duplicates '("a" "b")) '("a" "b"))

(define (remove-duplicates lol)
  (cond
    [(empty? lol) '()]
    [else (local ((define rem-dups-rest (remove-duplicates (rest lol)))
                  (define f (first lol)))
            (cons f
                  (if (member? f rem-dups-rest)
                      (remove-all f rem-dups-rest)
                      rem-dups-rest)))]))

;; -----------------------------------------------------------------------------
;; Generic helpers


; [X] [NEList-of X] X -> N
; index of e in l
; ASSUMPTION: (member? e l) holds
(define (index-of-elem l e equality-f)
  (local (; [X] [NEList-of X] X N -> N
          ; index of x in l (traversed n elements so far)
          (define (index-of-e l e n)
            (cond
              [(empty? (rest l)) n]
              [else (if (equality-f e (first l))
                        n
                        (index-of-e (rest l) e (add1 n)))])))
    (index-of-e l e 0)))


; [X] [NEList-of X] N -> X
; the n-th element of l (0-indexed)
; ASSUMPTION: n is less than length of l

(check-expect (elem-at-idx '(a b c) 0) 'a)
(check-expect (elem-at-idx '(a b c) 1) 'b)
(check-expect (elem-at-idx '(a b c) 2) 'c)
(check-expect (elem-at-idx '(a) 0) 'a)

(define (elem-at-idx l n)
  (cond
    [(= n 0) (first l)]
    [else (elem-at-idx (rest l) (sub1 n))]))

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