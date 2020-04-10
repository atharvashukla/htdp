;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 166ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 166
;; ------------
;; The wage*.v2 function consumes a list of work records and produces a list of
;; numbers. Of course, functions may also produce lists of structures.
;;
;; Develop a data representation for paychecks. Assume that a paycheck contains
;; two distinctive pieces of information: the employee’s name and an amount.
;; Then design the function wage*.v3. It consumes a list of work records and
;; computes a list of paychecks from it, one per record.
;;
;; In reality, a paycheck also contains an employee number. Develop a data
;; representation for employee information and change the data definition for
;; work records so that it uses employee information and not just a string for
;; the employee’s name. Also change your data representation of paychecks so
;; that it contains an employee’s name and number, too. Finally, design
;; wage*.v4, a function that maps lists of revised work records to lists of
;; revised paychecks.
;;
;; Note on Iterative Refinement This exercise demonstrates the iterative
;; refinement of a task. Instead of using data representations that include
;; all relevant information, we started from simplistic representation of
;; aychecks and gradually made the representation realistic. For this simple
;; program, refinement is overkill; later we will encounter situations where
;; iterative refinement is not just an option but a necessity. 
;; -----------------------------------------------------------------------------

(define-struct work [employee rate hours])
; A (piece of) Work is a structure: 
;   (make-work String Number Number)
; interpretation (make-work n r h) combines the name 
; with the pay rate r and the number of hours h


; Low (short for list of works) is one of: 
; – '()
; – (cons Work Low)
; interpretation an instance of Low represents the 
; hours worked for a number of employees

(define-struct pay-check [name amount])
; A Pay-check is a structure:
;   (make-pay-check String Number)
; interpretation (make-pay-check name amount) combines
; the name with the salary of the employee

; Lop (short for list of paycheck) is one of:
; - '()
; - (cons Pay-check Lop)
; interpretation as instance of Lop represents
; the pay-check for a number of employees


(define work1 (make-work "Robby" 11.95 39))
(define work2 (make-work "Matthew" 12.95 45))

(define pay1 (make-pay-check "Robby" 466.05))
(define pay2 (make-pay-check "Matthew" 582.75))

(define low1 (cons work1 '()))
(define low2 (cons work2 low1))

; Low -> List-of-numbers
; computes the weekly wages for the given records
#;
(define (wage*.v2 an-low)
  '())

(define (wage*.v2 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low) (cons (wage.v2 (first an-low))
                          (wage*.v2 (rest an-low)))]))

(check-expect
 (wage*.v2
  (cons (make-work "Robby" 11.95 39) '()))
 (cons (* 11.95 39) '()))

; Work -> Number
; computes the wage for the given work record w
(define (wage.v2 w)
  (* (work-rate w) (work-hours w)))

; -------------------------------------------------------

; Low -> Lop
; computes a list of paychecks from list of works
(define (wage*.v3 an-low)
  (cond
    [(empty? an-low) '()]
    [else (cons (wage.v3 (first an-low))
                (wage*.v3 (rest an-low)))]))

(check-expect (wage*.v3 '()) '())
(check-expect (wage*.v3 low1) (cons pay1 '()))
(check-expect (wage*.v3 low2) (cons pay2 (cons pay1 '())))

; Work -> Paycheck
; computes the paycheck from a Work

(check-expect (wage.v3 work1) pay1)
(check-expect (wage.v3 work2) pay2)

(define (wage.v3 a-work)
  (make-pay-check (work-employee a-work)
                  (* (work-rate a-work)
                     (work-hours a-work))))

; -------------------------------------------------------

(define-struct emp-info [name id])
; An Emp-info is a structure
;   (make-emp-info String Number)
; interpration (make-emp-info name id) represents
; the identifying information of an employee

(define-struct work.v2 [emp-info rate hours])
; A (piece of) Work is a structure: 
;   (make-work Emp-info Number Number)
; interpretation (make-work ei r h) combines the
; employee information with the pay rate r and
; the number of hours h

; Low (short for list of works) is one of: 
; – '()
; – (cons Work Low)
; interpretation an instance of Low represents the 
; hours worked for a number of employees

(define-struct pay-check.v2 [emp-info amount])
; A Pay-check is a structure:
;   (make-pay-check Emp-info Number)
; interpretation (make-pay-check emp-info amount) combines
; the name with the salary of the employee

; Lop (short for list of paycheck) is one of:
; - '()
; - (cons Pay-check Lop)
; interpretation as instance of Lop represents
; the pay-check for a number of employees

(define info1 (make-emp-info "Robby" 1))
(define info2 (make-emp-info "Matthew" 2))

(define work1.v2 (make-work.v2 info1 11.95 39))
(define work2.v2 (make-work.v2 info2 12.95 45))

(define pay1.v2 (make-pay-check.v2 info1 466.05))
(define pay2.v2 (make-pay-check.v2 info2 582.75))

(define low1.v2 (cons work1.v2 '()))
(define low2.v2 (cons work2.v2 low1.v2))


; Low -> Lop
; computes a list of paychecks from list of works
(define (wage*.v4 an-low)
  (cond
    [(empty? an-low) '()]
    [else (cons (wage.v4 (first an-low))
                (wage*.v4 (rest an-low)))]))

(check-expect (wage*.v4 '()) '())
(check-expect (wage*.v4 low1.v2) (cons pay1.v2 '()))
(check-expect (wage*.v4 low2.v2) (cons pay2.v2 (cons pay1.v2 '())))

; Work -> Paycheck
; computes the paycheck from a Work

(check-expect (wage.v4 work1.v2) pay1.v2)
(check-expect (wage.v4 work2.v2) pay2.v2)

(define (wage.v4 a-work)
  (make-pay-check.v2 (work.v2-emp-info a-work)
                     (* (work.v2-rate a-work)
                        (work.v2-hours a-work))))