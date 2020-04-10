;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 397ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 397
;; ------------
;; In a factory, employees punch time cards as they arrive in the morning and
;; leave in the evening. Electronic time cards contain an employee number and
;; record the number of hours worked per week. Employee records always contain
;; the name of the employee, an employee number, and a pay rate.
;;
;; Design wages*.v3. The function consumes a list of employee records and a
;; list of time-card records. It produces a list of wage records, which contain
;; the name and weekly wage of an employee. The function signals an error if it
;; cannot find an employee record for a time card or vice versa.
;;
;; *Assumption* There is at most one time card per employee number.
;; -----------------------------------------------------------------------------

(define-struct emp-rec [name emp-num pay-rate])
; EmployeeRecord is a structure:
;   (make-emp-rec String Number Number)
; intepretation. records the name of the employee
; the employee number and the pay rate

(define-struct time-card [emp-num hrs])
; TimeCard is a structure:
;   (make-time-card Number Number Number)
; interpretation. records the employee number
; and the number of hrs worked per week

(define-struct wage-rec [name wage])
; WageRecord is a structure:
;   (make-wage-record String Number)
; interpretation. the name and the weekly wage
; of the employee


(define a-er (make-emp-rec "a" 7 45))
(define k-er (make-emp-rec "k" 5 37))
(define d-er (make-emp-rec "d" 123 23))

(define a-tc (make-time-card 7 40))
(define k-tc (make-time-card 5 35))
(define d-tc (make-time-card 123 30))

(define a-wr (make-wage-rec "a" 1800))
(define k-wr (make-wage-rec "k" 1295))
(define d-wr (make-wage-rec "d" 690))



; [List-of EmployeeRecord] [List-of TimeCard] -> [List-of WageRecord]
; computes the list of all employees from their records and cards

(check-expect (wage*.v3 (list a-er k-er d-er) (list a-tc k-tc d-tc))
              (list a-wr k-wr d-wr))

(check-expect (wage*.v3 '() (list a-tc k-tc d-tc))
              '())

#;
(define (wage*.v3 records cards)
  '())

(define (wage*.v3 records cards)
  (local (; EmployeeRecord [List-of TimeCard] -> WageRecord
          ; create a wage record for the employee from the given cards
          (define (gen-wage-record emp)
            (local (; EmployeeRecord TimeCard -> Boolean
                    ; does e and c have the same employee number?
                    (define (employee-matches-card emp c)
                      (= (emp-rec-emp-num emp) (time-card-emp-num c)))
                    (define the-card (first (filter (λ (c) (employee-matches-card emp c)) cards)))
                    (define total-wage (* (time-card-hrs the-card) (emp-rec-pay-rate emp)))
                    (define wage-record (make-wage-rec (emp-rec-name emp) total-wage)))
              wage-record)))
    (map gen-wage-record records)))
      