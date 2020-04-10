;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 405ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 405
;; ------------
;; Design the function row-filter. Construct examples for row-filter from the
;; examples for project.
;;
;; *Assumption* The given database passes an integrity check, meaning each row
;; is as long as the schema and thus its list of names. 
;; -----------------------------------------------------------------------------


; Row [List-of Label] -> Row
; retains those cells whose name is in labels

(define labels '("Name" "Present"))

(check-expect (row-filter (list "Alice" 35 #true)
                          (list "Name" "Age" "Present"))
              (list "Alice" #true))


(define (row-filter row names)
  (cond
    [(empty? names) '()]
    [else
     (if (member? (first names) labels)
         (cons (first row)
               (row-filter (rest row) (rest names)))
         (row-filter (rest row) (rest names)))]))
