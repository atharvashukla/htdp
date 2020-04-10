;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 170ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 170
;; ------------
;; Here is one way to represent a phone number:
;;
;;    (define-struct phone [area switch four])
;;    ; A Phone is a structure: 
;;    ;   (make-phone Three Three Four)
;;    ; A Three is a Number between 100 and 999. 
;;    ; A Four is a Number between 1000 and 9999.
;;
;; Design the function replace. It consumes and produces a list of Phones. It
;; replaces all occurrence of area code 713 with 281. 
;; -----------------------------------------------------------------------------


(define-struct phone [area switch four])
; A Phone is a structure
;    (make-phone Three Three Fout)
; A Three is a Number between 100 and 999.
; A Four is a Number between 1000 and 9999.

; List-of-Phones -> List-of-Phones
; replaces all area codes of 713 with 281
#;
(define (replacepn lop)
  '())


(define phone1 (make-phone 000 000 0000))
(define phone2 (make-phone 713 000 0000))

(define lop1 (cons phone1 '()))
(define lop2 (cons phone2 lop1))

(define phone1r (make-phone 000 000 0000))
(define phone2r (make-phone 281 000 0000))

(check-expect (replacepn lop1) (cons phone1r '()))
(check-expect (replacepn lop2) (cons phone2r (cons phone1r '())))

(define (replacepn lop)
  (cond
    [(empty? lop) '()]
    [else (cons (replace1 (first lop)) (replacepn (rest lop)))]))

;; Phone -> Phone
;; replaces the phones with 713 switch with 281
(define (replace1 phone)
  (cond
    [(= (phone-area phone) 713)
     (make-phone 281 (phone-switch phone) (phone-four phone))]
    [else phone]))

  