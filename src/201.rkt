;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 201ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 201
;; ------------
;; Design select-all-album-titles. The function consumes an LTracks and produces
;; the list of album titles as a List-of-strings.
;; 
;; Also design the function create-set. It consumes a List-of-strings and
;; constructs one that contains every String from the given list exactly once.
;; *Hint* If String s is at the front of the given list and occurs in the rest
;; of the list, too, create-set does not keep s.
;;
;; Finally design select-album-titles/unique, which consumes an LTracks and
;; produces a list of unique album titles. Use this function to determine all
;; album titles in your iTunes collection and also find out how many distinct
;; albums it contains. 
;; -----------------------------------------------------------------------------

(require 2htdp/itunes)

(require "provide.rkt")
(provide select-album-titles/unique create-set)

;; Date examples
(define ex-date1 (create-date 2018 4 20 2 25 6))
(define ex-date2 (create-date 2018 4 20 2 30 0))
(define ex-date3 (create-date 2015 12 31 23 59 59))
(define ex-date4 (create-date 2016 1 1 0 0 0))
(define ex-date5 (create-date 2005 2 23 12 12 12))


;; Track examples
(define ex-track1
  (create-track "Blues At Sunrise (Live)"
               "Albert King & Stevie Ray Vaughan"
               "In Session (Live)"
               909907
               6
               ex-date5
               7
               ex-date1))
(define ex-track2
  (create-track "Brianstorm"
               "Arctic Monkeys"
               "Favourite Worst Nightmare"
               172253
               1
               ex-date1
               7
               ex-date2))

(define ex-track3
  (create-track "It Is Not Meant to Be"
               "Tame Impala"
               "InnerSpeaker (Collector's Edition)"
               322173
               1
               ex-date3
               15
               ex-date4))

;; LTrack examples
(define ex-ltrack1 '())
(define ex-ltrack2 (list ex-track1))
(define ex-ltrack3 (list ex-track1 ex-track2))
(define ex-ltrack4 (list ex-track1 ex-track2 ex-track3))

; --------------------

;; LTracks -> List-of-strings
;; extracts all album titles from an-ltrack

(check-expect (select-all-album-titles ex-ltrack1) '())
(check-expect (select-all-album-titles ex-ltrack2)
              (list "In Session (Live)"))
(check-expect (select-all-album-titles ex-ltrack3)
              (list "In Session (Live)" "Favourite Worst Nightmare" ))
(check-expect (select-all-album-titles ex-ltrack4)
              (list "In Session (Live)" "Favourite Worst Nightmare" "InnerSpeaker (Collector's Edition)"))

(define (select-all-album-titles an-ltrack)
  (cond
    [(empty? an-ltrack) '()]
    [else (cons (track-album (first an-ltrack))
                (select-all-album-titles (rest an-ltrack)))]))


;; List-of-strings -> List-of-strings
;; removes duplicates from los

(check-expect (create-set '()) '())
(check-expect (create-set (list "s")) (list "s"))
(check-expect (create-set (list "a" "b" "c")) (list "a" "b" "c"))
(check-expect (create-set (list "a" "a" "a")) (list "a"))
(check-expect (create-set (list "a" "b" "a" "b")) (list "a" "b"))

(define (create-set los)
  (cond
    [(empty? los) '()]
    [else (if (member? (first los) (create-set (rest los)))
              (create-set (rest los))
              (cons (first los) (create-set (rest los))))]))


;; LTracks -> List-of-strings
;; creates a unique list of album names from `an-ltrack`

(check-expect (select-album-titles/unique '()) '())
(check-expect (select-album-titles/unique (append ex-ltrack4 ex-ltrack4))
              (list "In Session (Live)" "Favourite Worst Nightmare" "InnerSpeaker (Collector's Edition)"))
(check-expect (select-album-titles/unique (append ex-ltrack2 ex-ltrack3))
              (list "In Session (Live)" "Favourite Worst Nightmare"))

(define (select-album-titles/unique an-ltrack)
  (create-set (select-all-album-titles an-ltrack)))
