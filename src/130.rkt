;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 130ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 130.
;; -------------
;; Create an element of List-of-names that contains five Strings. Sketch a box
;; representation of the list similar to those found in figure 44.
;;
;; Explain why
;;
;;    (cons "1" (cons "2" '()))
;;
;; is an element of List-of-names and why (cons 2 '()) isn’t. 
;; -----------------------------------------------------------------------------


; A List-of-names is one of: 
; – '()
; – (cons String List-of-names)
; interpretation a list of invitees, by last name


(define five-names
  (cons "Felleisen"
        (cons "Flatt"
              (cons "Findler"
                    (cons "Gray"
                          (cons "Krishnamurthi" '()))))))

; <box-diagram.png>

(cons "1" (cons "2" '()))

; is a List-of-names because "1" is a String consed onto a
; (cons "2" '()) which is a List-of-names because "2" is a
; String consed onto a '() which is a List-of-names.

(cons 2 '())

; isn't a List-of-names because 1 is consed onto a List-of-names
; but 1 is not a String.