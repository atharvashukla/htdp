;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 388ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 388
;; ------------
;; In the real world, wages*.v2 consumes lists of employee structures and lists
;; of work records. An employee structure contains an employee’s name, social
;; security number, and pay rate. A work record also contains an employee’s name
;; and the number of hours worked in a week. The result is a list of structures
;; that contain the name of the employee and the weekly wage.
;;
;; Modify the program in this section so that it works on these realistic
;; versions of data. Provide the necessary structure type definitions and data
;; definitions. Use the design recipe to guide the modification process. 
;; -----------------------------------------------------------------------------


(define-struct emp [name ssn rate])
; A (piece of) Employee is a structure: 
;   (make-emp String Number Number)
; interpretation combines the name with
; ssn and pay rate of the employee

(define-struct work [name hours])
; A (piece of) Work is a structure: 
;   (make-work String Number)
; interpretation (make-work n h) combines the name 
; with the number of hours worked h



; [List-of Employee] [List-of Word] -> [List-of Number]
; multiplies the corresponding rates from the employee
; list with the hours worked from the work list 
; assume the two lists are of equal length


(check-expect (wages*.v2 '() '()) '())
(check-expect (wages*.v2 (list (make-emp "brad" 232 5.65)) (list (make-work "brad" 40)))
              (list 226.0))
(check-expect (wages*.v2 (list (make-emp "k" 009 5.65) (make-emp "a" 007 8.75))
                         (list (make-work "k" 40.0) (make-work "a" 30.0)))
              '(226.0 262.5))


(define (wages*.v2 hours wages/h)
  (cond
    [(empty? hours) '()]
    [else
     (cons
       (weekly-wage (first hours) (first wages/h))
       (wages*.v2 (rest hours) (rest wages/h)))]))

; Employee Work -> Number
; computes the weekly wage from pay-rate and hours
(define (weekly-wage e w)
  (* (emp-rate e) (work-hours w)))
