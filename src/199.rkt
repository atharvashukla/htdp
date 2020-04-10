;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 199ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 199
;; ------------
;; While the important data definitions are already provided, the first step of
;; the design recipe is still incomplete. Make up examples of Dates, Tracks, and
;; LTracks. These examples come in handy for the following exercises as inputs.
;; -----------------------------------------------------------------------------

(require 2htdp/itunes)

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