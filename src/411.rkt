;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 411ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 411
;; ------------
;; Design join, a function that consumes two databases: db-1 and db-2. The
;; schema of db-2 starts with the exact same Spec that the schema of db-1 ends
;; in. The function creates a database from db-1 by replacing the last cell in
;; each row with the translation of the cell in db-2.
;;
;; Here is an example. Take the databases in figure 137. The two satisfy the
;; assumption of these exercises, that is, the last Spec in the schema of the
;; first is equal to the first Spec of the second. Hence it is possible to join
;; them:
;;
;;  +---------------------------------+
;;  | Name     |  Age      |  Present |
;;  | ---------+-----------+----------|
;;  | String   |  Integer  |  Boolean |
;;  | ---------+-----------+----------|
;;  | "Alice"  |  35       |  #true   |
;;  | "Bob"    |  25       |  #false  |
;;  | "Carol"  |  30       |  #true   |
;;  | "Dave"   |  32       |  #false  |
;;  +---------------------------------+
;;  
;;  +-------------------------+
;;  | Present |  Description  |
;;  |---------+---------------|
;;  | Boolean |  String       |
;;  |---------+---------------|
;;  |  #true  |  "presence"   |
;;  |  #false |  "absence"    |
;;  +-------------------------+
;;
;;  +-------------------------------------+
;;  | Name     |  Age      |  Description |
;;  | ---------+-----------+--------------|
;;  | String   |  Integer  |  Boolean     |
;;  | ---------+-----------+--------------|
;;  | "Alice"  |  35       |  "presence"  |
;;  | "Bob"    |  25       |  "absence"   |
;;  | "Carol"  |  30       |  "presence"  |
;;  | "Dave"   |  32       |  "absence"   |
;;  +-------------------------------------+
;;
;; Its translation maps #true to "presence" and #false to "absence".
;;
;; *Hints* (1) In general, the second database may “translate” a cell to a row
;; of values, not just one value. Modify the example by adding additional terms
;; to the row for "presence" and "absence".
;;
;; (2) It may also “translate” a cell to several rows, in which case the process
;; adds several rows to the new database. Here is a second example, a slightly
;; different pair of databases from those in figure 137:
;;
;;  +---------------------------------+
;;  | Name     |  Age      |  Present |
;;  | ---------+-----------+----------|
;;  | String   |  Integer  |  Boolean |
;;  | ---------+-----------+----------|
;;  | "Alice"  |  35       |  #true   |
;;  | "Bob"    |  25       |  #false  |
;;  | "Carol"  |  30       |  #true   |
;;  | "Dave"   |  32       |  #false  |
;;  +---------------------------------+
;;
;;  +-------------------------+
;;  | Present |  Description  |
;;  |---------+---------------|
;;  | Boolean |  String       |
;;  |---------+---------------|
;;  |  #true  |  "presence"   |
;;  |  #true  |  "here"       |
;;  |  #false |  "absence"    |
;;  |  #false |  "there"      |
;;  +-------------------------+
;;
;;  +-------------------------------------+
;;  | Name     |  Age      |  Description |
;;  | ---------+-----------+--------------|
;;  | String   |  Integer  |  Boolean     |
;;  | ---------+-----------+--------------|
;;  | "Alice"  |  35       |  "presence"  |
;;  | "Alice"  |  35       |  "here"      |
;;  | "Bob"    |  25       |  "absence"   |
;;  | "Bob"    |  25       |  "there"     |
;;  | "Carol"  |  30       |  "presence"  |
;;  | "Carol"  |  30       |  "here"      |
;;  | "Dave"   |  32       |  "absence"   |
;;  | "Dave"   |  32       |  "there"     |
;;  +-------------------------------------+
;;
;; (3) Use iterative refinement to solve the problem. For the first iteration,
;; assume that a “translation” finds only one row per cell. For the second one,
;; drop the assumption.
;;
;; *Note* on Assumptions This exercise and the entire section mostly rely on
;; informally stated assumptions about the given databases. Here, the design of
;; join assumes that “the schema of db-2 starts with the exact same Spec that
;; the schema of db-1 ends in.” In reality, database functions must be checked
;; functions in the spirit of Input Errors. Designing checked-join would be
;; impossible for you, however. A comparison of the last Spec in the schema of
;; db-1 with the first one in db-2 calls for a comparison of functions. For
;; practical solutions, see a text on databases. 
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
  `(,(make-spec "Name" string?) ,(make-spec "Age" integer?) ,(make-spec "Present" boolean?)))
 
(define presence-schema
  `(,(make-spec "Present" boolean?) ,(make-spec "Description" string?)))

(define big-presence-schema
  `(,(make-spec "Present" boolean?) ,(make-spec "Description" string?)))
 
(define school-content
  `(("Alice" 35 #true)
    ("Bob"   25 #false)
    ("Carol" 30 #true)
    ("Dave"  32 #false)))

(define presence-content
  `((#true  "presence")
    (#false "absence")))

(define big-presence-content
  `((#true  "presence")
    (#true  "here")
    (#false "absence")
    (#false "there")))
 
(define school-db
  (make-db school-schema school-content))
 
(define presence-db
  (make-db presence-schema presence-content))


(define school-presence-join-schema
  `(,(make-spec "Name" string?) ,(make-spec "Age" integer?) ,(make-spec "Description" string?)))

(define school-presence-join-content
  `(("Alice" 35 "presence")
    ("Bob"   25 "absence")
    ("Carol" 30 "presence")
    ("Dave"  32 "absence")))

(define school-presence-join-db
  (make-db school-presence-join-schema school-presence-join-content))


(define school-big-presence-join-schema
  `(,(make-spec "Name" string?) ,(make-spec "Age" integer?) ,(make-spec "Description" string?)))

(define school-big-presence-join-content
  `(("Alice" 35 "presence")
    ("Alice" 35 "here")
    ("Bob"   25 "absence")
    ("Bob"   25 "there")
    ("Carol" 30 "presence")
    ("Carol" 30 "here")
    ("Dave"  32 "absence")
    ("Dave"  32 "there")))

(define big-presence-db
  (make-db big-presence-schema big-presence-content))

(define school-big-presence-join-db
  (make-db school-big-presence-join-schema school-big-presence-join-content))

;; -----------------------------------------------------------------------------

; DB DB -> DB
; joins db-1 with db-2
; ASSUMPTION: the last column of db-1 is the
; same kind of data the first column of db-2

(check-expect (db-content (join.v1 school-db presence-db)) (db-content  school-presence-join-db))
(check-expect (db-content (join.v1 school-db big-presence-db)) (db-content school-big-presence-join-db))
              

(define (join.v1 db-1 db-2)
  (make-db (join-row.v1 (db-schema db-1) (db-schema db-2))
           (join-content.v1 (db-content db-1) (db-content db-2))))

; Row Row -> Row
; join two rows
(define (join-row.v1 r1 r2)
  (append (rem-last r1) (rest r2)))

; [List-of Row] [List-of Row] -> [List-of Row]
; joins the contents of two databases
; ASSUMPTION: c1 and c2 can be joined
(define (join-content.v1 c1 c2)
  (cond
    [(empty? c1) '()]
    [else (append (gen-joined-rows.v1 (first c1) c2) (join-content.v1 (rest c1) c2))]))

; Row [List-of Row] -> [List-of Row]
; rows generated for the Row by joining with c
(define (gen-joined-rows.v1 r c)
  (cond
    [(empty? c) '()]
    [else (local ((define gen-rest (gen-joined-rows.v1 r (rest c)))
                  (define f (first c)))
            (if (equal? (get-last r) (first f))
                (cons (join-row.v1 r f) gen-rest)
                gen-rest))]))

;; -----------------------------------------------------------------------------

; DB DB -> DB
; joins db-1 with db-2
; ASSUMPTION: the last column of db-1 is the
; same kind of data the first column of db-2

(check-expect (db-content (join school-db presence-db)) (db-content  school-presence-join-db))
(check-expect (db-content (join school-db big-presence-db)) (db-content school-big-presence-join-db))
              

(define (join db-1 db-2)
  (local ((define db-2-content (db-content db-2))

          ; Row Row -> Row
          ; join two rows
          (define (join-row r1 r2)
            (append (rem-last r1) (rest r2)))

          ; [List-of Row] [List-of Row] -> [List-of Row]
          ; joins the contents of c1 with db-2-content
          ; ASSUMPTION: c1 and c2 can be joined
          (define (join-content c1)
            (foldr (λ (e a) (append (gen-joined-rows e db-2-content) a)) '() c1))

          ; Row [List-of Row] -> [List-of Row]
          ; rows generated for the Row by joining with c
          (define (gen-joined-rows r c)
            (cond
              [(empty? c) '()]
              [else (local ((define gen-rest (gen-joined-rows r (rest c)))
                            (define f (first c)))
                      (if (equal? (get-last r) (first f))
                          (cons (join-row r f) gen-rest)
                          gen-rest))])))
    (make-db (join-row (db-schema db-1) (db-schema db-2))
             (join-content (db-content db-1)))))

;; -----------------------------------------------------------------------------
; generic helpers

; [NEList-of X] -> [NEList-of X]
; removes the last element of l

(check-expect (rem-last '(1)) '())
(check-expect (rem-last '(1 2 3)) '(1 2))

(define (rem-last l)
  (cond
    [(empty? (rest l)) '()]
    [else (cons (first l) (rem-last (rest l)))]))


; [NEList-of X] -> X
; the last element of l

(check-expect (get-last '(1)) 1)
(check-expect (get-last '(1 2 3)) 3)

(define (get-last l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (get-last (rest l))]))