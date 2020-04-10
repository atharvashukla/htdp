;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 204ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 204
;; ------------
;; Design select-albums. The function consumes an element of LTracks. It
;; produces a list of LTracks, one per album. Each album is uniquely identified
;; by its title and shows up in the result only once. Hints (1) You want to use
;; some of the solutions of the preceding exercises. (2) The function that
;; groups consumes two lists: the list of album titles and the list of tracks;
;; it considers the latter as atomic until it is handed over to an auxiliary
;; function. See exercise 196. 
;; -----------------------------------------------------------------------------

(require 2htdp/itunes)
(require "provide.rkt")

; -----

(require "201ex.rkt")
; select-album-titles/unique : LTracks -> List-of-strings
; creates a unique list of album names from `an-ltrack`


(require "202ex.rkt")
; select-album : String LTracks -> LTracks
; list of tracks that belong to album named `title`

; -----

; A List-of-LTracks is one of
; - '()
; - (cons LTracks List-of-LTracks)
; interpretation a list of LTracks


(define d (create-date 2005 2 23 12 12 12))

; (create-track name artist album time track# added play# played)

(define ta1 (create-track "" "" "A" 0 1 d 0 d))
(define ta2 (create-track "" "" "A" 0 2 d 0 d))
(define ta3 (create-track "" "" "A" 0 3 d 0 d))
(define ta4 (create-track "" "" "A" 0 4 d 0 d))
(define tb1 (create-track "" "" "B" 0 1 d 0 d))
(define tb2 (create-track "" "" "B" 0 2 d 0 d))
(define tb3 (create-track "" "" "B" 0 3 d 0 d))
(define tb4 (create-track "" "" "B" 0 4 d 0 d))

; LTracks -> List-of-LTracks
; profuces a list of ltracks, one per album
(check-expect (select-albums (list ta1 ta2 ta3 ta4 tb1 tb2 tb3 tb4))
              (list (list ta1 ta2 ta3 ta4) (list tb1 tb2 tb3 tb4)))
(define (select-albums l)
  ; List-of-string LTracks -> List-of-LTracks
  (select-albums-aux (select-album-titles/unique l) l))


; List-of-strings LTracks -> List-of-LTracks
; creates a List-of-LTracks, one LTrack for each album title in `a`
(check-expect (select-albums-aux (list "A" "B")
                                 (list ta1 ta2 ta3 ta4 tb1 tb2 tb3 tb4))
              (list (list ta1 ta2 ta3 ta4) (list tb1 tb2 tb3 tb4)))
(define (select-albums-aux a-lst ltracks)
  (cond
    [(empty? a-lst) '()]
    [else (cons (select-album (first a-lst) ltracks) ; : LTrack
                (select-albums-aux (rest a-lst) ltracks))]))