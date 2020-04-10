;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 183ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 183
;; ------------
;;
;; On some occasions lists are formed with cons and list.
;;
;;    1. (cons "a" (list 0 #false))
;;    
;;    2. (list (cons 1 (cons 13 '())))
;;    
;;    3. (cons (list 1 (list 13 '())) '())
;;    
;;    4. (list '() '() (cons 1 '()))
;;    
;;    5. (cons "a" (cons (list 1) (list #false '())))
;;
;; Reformulate each of the following expressions using only cons or only list.
;; Use check-expect to check your answers.
;;
;; -----------------------------------------------------------------------------


; Given form

(define given-one (cons "a" (list 0 #false)))

(define given-two (list (cons 1 (cons 13 '()))))

(define given-three (cons (list 1 (list 13 '())) '()))

(define given-four (list '() '() (cons 1 '())))

(define given-five (cons "a" (cons (list 1) (list #false '()))))

; Cons form

(define cons-one (cons "a" (cons 0 (cons #false '()))))

(define cons-two (cons (cons 1 (cons 13 '())) '()))

(define cons-three (cons (cons 1 (cons (cons 13 (cons '() '())) '())) '()))

(define cons-four (cons '() (cons '() (cons (cons 1 '()) '()))))

(define cons-five (cons "a" (cons (cons 1 '()) (cons #false (cons '() '())))))

; List form

(define list-one (list "a" 0 #false))

(define list-two (list (list 1 13)))

(define list-three (list (list 1 (list 13 '()))))

(define list-four (list '() '() (list 1)))

(define list-five (cons "a" (list (list 1) #false '())))


; Tests

(check-expect given-one cons-one)

(check-expect given-two cons-two)

(check-expect given-three cons-three)

(check-expect given-four cons-four)

(check-expect given-five cons-five)

(check-expect given-one list-one)

(check-expect given-two list-two)

(check-expect given-three list-three)

(check-expect given-four list-four)

(check-expect given-five list-five)
  

