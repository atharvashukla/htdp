;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 134ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 134.
;; ------------
;; Develop the contains? function, which determines whether some given string
;; occurs on a given list of strings.
;;
;; Note BSL actually comes with member?, a function that consumes two values
;; and checks whether the first occurs in the second, a list:
;; 
;;    > (member? "Flatt" (cons "b" (cons "Flatt" '())))
;;    #true
;;
;; Don’t use member? to define the contains? function. 
;;
;; -----------------------------------------------------------------------------


;; List-of-strings is one of:
;; - '()
;; - (cons String List-of-strings)
;; interpretation. a list of strings. 

;; String List-of-strings -> Boolean
;; does los contain str in it?
#;
(define (contains? str los)
  #true)

(check-expect
 (contains?
  "atharva"
  (cons "rig"
        (cons "sam"
              (cons "yajurva"
                    (cons "atharva" '())))))
 #true)

(check-expect
 (contains?
  "krishna"
  (cons "dan"
        (cons "trevor"
              (cons "karmen"
                    (cons "atharva" '())))))
 #false)

(define (contains? str los)
  (cond
    [(empty? los) #false]
    [else (or (string=? (first los) str)
              (contains? str (rest los)))]))




















