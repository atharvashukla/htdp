;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 132ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 132.
;; -------------
;; Use DrRacket to run contains-flatt?
;; 
;;    (cons "Fagan"
;;      (cons "Findler"
;;        (cons "Fisler"
;;          (cons "Flanagan"
;;            (cons "Flatt"
;;              (cons "Felleisen"
;;                (cons "Friedman" '())))))))
;;
;; What answer do you expect? 
;; -----------------------------------------------------------------------------

; I expect #true because "Flatt" is in that list

; List-of-names -> Boolean
; determines whether "Flatt" is on a-list-of-names
(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (or (string=? (first alon) "Flatt")
         (contains-flatt? (rest alon)))]))


(contains-flatt?
  (cons "Fagan"
        (cons "Findler"
              (cons "Fisler"
                    (cons "Flanagan"
                          (cons "Flatt"
                                (cons "Felleisen"
                                      (cons "Friedman" '()))))))))
; => true, correct.