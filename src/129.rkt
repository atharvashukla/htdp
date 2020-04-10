;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 129ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 129. 
;; -------------
;;
;; Create BSL lists that represents
;; 
;; 1. a list of, celestial bodies, say all the planets
;; of our solar system
;;
;; 2. a list of items for a meal
;; 
;; 3. a list of colors
;;
;; -----------------------------------------------------------------------------


(define planets
  (cons "Mercury"
        (cons "Venus"
              (cons "Earth"
                    (cons "Mars"
                          (cons "Jupiter"
                                (cons "Saturn"
                                      (cons "Uranus"
                                            (cons "Neptune" '())))))))))



(define meal
  (cons "steak"
        (cons "french fries"
              (cons "beans"
                    (cons "bread"
                          (cons "water"
                                (cons "Brie cheese"
                                      (cons "ice cream" '()))))))))


(define colors
  (cons "blue"
        (cons "red"
              (cons "yellow"
                    (cons"green"
                         (cons "white"
                               (cons "black"
                                     (cons "gray" '()))))))))