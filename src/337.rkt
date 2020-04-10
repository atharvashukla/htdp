;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 337ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 337
;; ------------
;; Use List-of to simplify the data definition Dir.v3. Then use ISL+’s
;; list-processing functions from figures 95 and 96 to simplify the function
;; definition(s) for the solution of exercise 336.
;; -----------------------------------------------------------------------------


(define-struct file [name size content])
; A File.v3 is a structure: 
;   (make-file String N String)

(define-struct dir [name dirs files])
; A Dir.v3 is a structure: 
;   (make-dir.v3 String Dir* File*)

; A Dir* is a [List-of Dir.v3]
; A File* is a [List-of File.v3]



; Data Examples
; =============

; files
(define hang (make-file "hang" 8 ""))
(define draw (make-file "draw" 2 ""))
(define read!-in-docs (make-file "read!" 19 ""))
(define read!-in-ts (make-file "read!" 10 ""))
(define part1 (make-file "part1" 99 ""))
(define part2 (make-file "part2" 52 ""))
(define part3 (make-file "part3" 17 ""))

; directories
(define code (make-dir "Code" '() (list hang draw)))
(define docs (make-dir "Docs" '() (list read!-in-docs)))
(define text (make-dir "Text" '() (list part1 part2 part3)))
(define libs (make-dir "Libs" (list code docs) '()))
(define ts (make-dir "TS"  (list text libs) (list read!-in-ts)))


; Tests
; =====
(check-expect (how-many ts) 7)
(check-expect (how-many text) 3)
(check-expect (how-many libs) 3)
(check-expect (how-many docs) 1)
(check-expect (how-many code) 2)
(check-expect (how-many (make-dir "Empty" '() '())) 0)

; Dir.v3 -> Nat
; how many files does this directory contain?
(define (how-many D)
  (local (; Dir.v3 -> Nat
          (define (dir*-how-many d*)
            (foldr (λ (e a) (+ (dir-how-many e) a)) 0 d*))

          ; Dir* -> Nat
          (define (dir-how-many d)
            (+ (dir*-how-many (dir-dirs d)) (length (dir-files d)))))
    
    (dir-how-many D)))