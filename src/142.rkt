;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 142ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 142.
;; -------------
;; Design the ill-sized? function, which consumes a list of images loi and a
;; positive number n. It produces the first image on loi that is not an n by n
;; square; if it cannot find such an image, it produces #false.
;;
;; *Hint* Use
;; 
;;    ; ImageOrFalse is one of:
;;    ; – Image
;;    ; – #false
;;
;; fot the result part of the signature
;; -----------------------------------------------------------------------------

(require 2htdp/image)

;; List-of-images is one of
;; - '()
;; - (cons Image List-of-images)
;; interpretation. a list of images.

(define non-sq1 (rectangle 23 42 "solid" "black"))
(define non-sq2 (rectangle 23 2 "solid" "red"))
(define sq1 (square 5 "outline" "blue"))
(define sq2 (square 10 "solid" "green"))


(define (loi-temp loi)
  (cond
    [(empty? loi) ...]
    [else (... (first loi) ... (loi-temp (rest loi)) ...)]))

; ImageOrFalse is one of:
; – Image
; – #false 

;; List-of-images -> ImageOrFalse
;; produces the first image on loi that is not an n by  n square
;; if no such image exists, produces false
#;
(define (ill-sized? loi)
  #false)

(check-expect (ill-sized? (cons sq1 (cons sq2 '()))) #false)
(check-expect (ill-sized? (cons sq1 '())) #false)
(check-expect (ill-sized? (cons sq1 (cons non-sq1 '()))) non-sq1)
(check-expect (ill-sized? (cons non-sq2 '())) non-sq2)

(define (ill-sized? loi)
  (cond
    [(empty? loi) #false]
    [else (if (is-square? (first loi)) (ill-sized? (rest loi)) (first loi))]))

;; Image -> Image
;; is the image a square?

(check-expect (is-square? non-sq1) #false)
(check-expect (is-square? non-sq2) #false)
(check-expect (is-square? sq1) #true)
(check-expect (is-square? sq2) #true)
#;
(define (is-square? loi)
  #false)

(define (is-square? im)
  (= (image-width im) (image-height im)))

