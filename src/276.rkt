;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 276ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 276
;; ------------
;; Real-World Data: iTunes explains how to analyze the information in an iTunes
;; XML library.
;;
;; Design select-album-date. The function consumes the title of an album, a
;; date, and an LTracks. It extracts from the latter the list of tracks from the
;; given album that have been played after the date.

;; Design select-albums. The function consumes an LTracks. It produces a list of
;; LTracks, one per album. Each album is uniquely identified by its title and
;; shows up in the result only once.

;; See figure 77 for the services provided by the 2htdp/itunes library.
;; -----------------------------------------------------------------------------

(require 2htdp/itunes)

; (define-struct date [year month day hour minute second])
; A Date is a structure:
;   (make-date N N N N N N)
; interpretation An instance records six pieces of information:
; the date's year, month (between 1 and 12 inclusive), 
; day (between 1 and 31), hour (between 0 
; and 23), minute (between 0 and 59), and 
; second (also between 0 and 59).


; String Date LTracks -> Ltracks
; tracks that have been played after date

(define d0 (create-date 0 1 1 0 0 0))

(define s1 (create-track "s1" "" "A" 0 0 d0 0 (create-date 2018 04 20 6 55 59)))
(define s2 (create-track "s2" "" "A" 0 0 d0 0 (create-date 2018 04 20 6 56 0)))
(define s3 (create-track "s3" "" "A" 0 0 d0 0 (create-date 2018 04 19 6 56 0)))
(define t4 (create-track "t4" "" "B" 0 0 d0 0 (create-date 2018 04 20 7 0 0)))

(check-expect (select-album-date "A" (create-date 2018 04 20 1 1 1) '()) '())
(check-expect (select-album-date "A" (create-date 2018 04 20 1 1 1) (list s1 s2 s3 t4)) (list s1 s2))

(define (select-album-date album date ltracks)
  (local (
          ; Date Date -> Boolean
          ; does d2 come after d1?

          #|
          (define ex-date1 (create-date 2018 4 20 2 25 6))
          (define ex-date2 (create-date 2018 4 20 2 30 0))
          (define ex-date3 (create-date 2015 12 31 23 59 59))
          (define ex-date4 (create-date 2016 1 1 0 0 0))
          (define ex-date5 (create-date 2005 2 23 12 12 12))

          (check-expect (date> (create-date 2005 2 23 12 12 12) (create-date 2018 4 20 2 25 6)) #true)
          (check-expect (date> (create-date 2005 1 23 12 12 12) (create-date 2005 4 20 2 25 6)) #true)
          (check-expect (date> (create-date 2005 4 19 12 12 12) (create-date 2005 4 20 2 25 6)) #true)
          (check-expect (date> (create-date 2005 4 19 0 12 12) (create-date 2005 4 19 2 25 6)) #true)
          (check-expect (date> (create-date 2005 4 19 0 12 12) (create-date 2005 4 19 0 25 6)) #true)
          (check-expect (date> (create-date 2005 4 19 0 12 3) (create-date 2005 4 19 0 12 6)) #true)
          (check-expect (date> (create-date 2005 4 19 0 12 9) (create-date 2005 4 19 0 12 6)) #false)
          (check-expect (date> (create-date 2018 4 20 2 25 6) (create-date 2005 2 23 12 12 12)) #false)
          (check-expect (date> (create-date 2005 4 20 2 25 6) (create-date 2005 1 23 12 12 12)) #false)
          (check-expect (date> (create-date 2005 4 20 2 25 6) (create-date 2005 4 19 12 12 12)) #false)
          (check-expect (date> (create-date 2005 4 19 2 25 6) (create-date 2005 4 19 0 12 12)) #false)
          (check-expect (date> (create-date 2005 4 19 0 25 6) (create-date 2005 4 19 0 12 12)) #false)
          (check-expect (date> (create-date 2005 4 19 0 12 6) (create-date 2005 4 19 0 25 6)) #true)
          (check-expect (date> (create-date 2005 4 19 1 1 1) (create-date 2005 4 19 1 1 1)) #false)
          ; important one:
          (check-expect (date> (create-date 2005 4 19 1 1 1) (create-date 2004 4 20 1 1 1)) #false)
          |#
          
          (define (date> d1 d2)
            (cond
              [(> (date-year d2) (date-year d1)) #true]
              [(< (date-year d2) (date-year d1)) #false]
              [(> (date-month d2) (date-month d1)) #true]
              [(< (date-month d2) (date-month d1)) #false]
              [(> (date-day d2) (date-day d1)) #true]
              [(< (date-day d2) (date-day d1)) #false]
              [(> (date-hour d2) (date-hour d1)) #true]
              [(< (date-hour d2) (date-hour d1)) #false]
              [(> (date-minute d2) (date-minute d1)) #true]
              [(< (date-minute d2) (date-minute d1)) #false]
              [(> (date-second d2) (date-second d1)) #true]
              [(< (date-second d2) (date-second d1)) #false]
              [else #false])))
    (foldr (λ (e a) (if (and (date> date (track-played e))
                             (string=? (track-album e) album))
                        (cons e a)
                        a))
           '()
           ltracks)))

;; -----------------------------------------------------------------------------

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
  (local (;; LTracks -> List-of-strings
          ;; creates a unique list of album names from `an-ltrack`
          (define (select-album-titles/unique an-ltrack)
            (local (;; LTracks -> List-of-strings
                    ;; extracts all album titles from an-ltrack
                    (define (select-all-album-titles an-ltrack)
                      (map track-album an-ltrack))

                    ;; List-of-strings -> List-of-strings
                    ;; removes duplicates from los
                    (define (create-set los)
                      (foldr (λ (e a) (if (member? e a) a (cons e a))) '() los)))
              (create-set (select-all-album-titles an-ltrack))))

          (define (select-albums-aux a-lst ltracks)
            (local (; String LTracks -> LTracks
                    ; list of tracks that belong to album named `title`
                    (define (select-album title ltracks)
                      (filter (λ (x) (string=? (track-album x) title)) ltracks))

                    (define (select-albums-aux2 a-lst)
                      (map (λ (x) (select-album x ltracks)) a-lst)))
              (select-albums-aux2 a-lst))))

    (select-albums-aux (select-album-titles/unique l) l)))
