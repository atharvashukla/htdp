;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 271ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 271
;; ------------
;; Use ormap to define find-name. The function consumes a name and a list of
;; names. It determines whether any of the names on the latter are equal to
;; or an extension of the former.

;; With andmap you can define a function that checks all names on a list of
;; names that start with the letter "a".

;; Should you use ormap or andmap to define a function that ensures that no name
;; on some list exceeds a given width?
;; -----------------------------------------------------------------------------


; String [List-of String]
; any strings in l an extension of s?

(check-expect (find-name "s" '()) #false)
(check-expect (find-name "s" '("as")) #false)
(check-expect (find-name "s" '("s")) #true)
(check-expect (find-name "sas" '("s" "tr" "sass")) #true)

(define (find-name s l)
  (local (; String -> Boolean
          ; is e an extension of s?
          (define (extension? e)
            (and ; first make sure lenght is appropriate for substring
             (>= (string-length e) (string-length s)) 
             (string=? (substring e 0 (string-length s)) s))))
    (ormap extension? l)))


;; [Listof String] -> Boolean
;; do all the names start with a?

(check-expect (all-start-with-a? '()) #t)
(check-expect (all-start-with-a? '("a" "a" "a")) #t)
(check-expect (all-start-with-a? '("a" "b" "c")) #f)
(check-expect (all-start-with-a? '("a" "ab" "abc")) #t)

(define (all-start-with-a? names)
  (local (;; String -> Boolean
          ;; does str start with "a"?
          #|
            (check-expect (starts-with-a? "a") #t)
            (check-expect (starts-with-a? "abc") #t)
            (check-expect (starts-with-a? "cba") #f)
          |#
          (define (starts-with-a? str)
            (string=? (substring str 0 1) "a")))
    (andmap starts-with-a? names)))

; [List-of String] -> Boolean
; does none of the strings in name have more than length # of char?

(check-expect (none-exceeds-lenght? '() 5) #t)
(check-expect (none-exceeds-lenght? '("a" "b" "c") 2) #true)
(check-expect (none-exceeds-lenght? '("a" "ab" "abc") 2) #false)

(define (none-exceeds-lenght? names length)
  (local (;; String -> Boolean
          ;; does the string length exceed the length?
          (define (exceeds-length? str)
            (> length (string-length str))))
    (andmap exceeds-length? names)))
