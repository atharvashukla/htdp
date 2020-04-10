;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 389ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 389
;; ------------
;; Design the zip function, which consumes a list of names, represented as
;; strings, and a list of phone numbers, also strings. It combines those equally
;; long lists into a list of phone records:
;;
;;    (define-struct phone-record [name number])
;;    ; A PhoneRecord is a structure:
;;    ;   (make-phone-record String String)
;;
;; Assume that the corresponding list items belong to the same person. 
;; -----------------------------------------------------------------------------


(define-struct phone-record [name number])
; A PhoneRecord is a structure:
;   (make-phone-record String String)


; [List-of String] [List-of String] -> [List-of PhoneRecord]
; combines the corrsp names and numbers into phone records
#;
(define (zip names nums)
  '())

(check-expect (zip '() '()) '())
(check-expect (zip (list "a" "b" "c") (list 1 2 3))
              (list (make-phone-record "a" 1)
                    (make-phone-record "b" 2)
                    (make-phone-record "c" 3)))

#;
(define (zip names nums)
  (cond
    [(empty? names) ...]
    [else (... (first names) ... (first nums)... (zip (rest names) (rest nums)) ...)]))


(define (zip names nums)
  (cond
    [(empty? names) '()]
    [else (cons (make-phone-record (first names) (first nums))
                (zip (rest names) (rest nums)))]))

