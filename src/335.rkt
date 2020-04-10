;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 335ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 335
;; ------------
;; Exercise 335. Translate the directory tree in figure 123 into a data
;; representation according to model 3. Use "" for the content of files. 
;; -----------------------------------------------------------------------------


; Data Definition
; ===============

(define-struct file [name size content])
; A File.v3 is a structure: 
;   (make-file String N String)

(define-struct dir [name dirs files])
; A Dir.v3 is a structure: 
;   (make-dir.v3 String Dir* File*)
 
; A Dir* is one of: 
; – '()
; – (cons Dir.v3 Dir*)
 
; A File* is one of: 
; – '()
; – (cons File.v3 File*)


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
