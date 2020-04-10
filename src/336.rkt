;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 336ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 336
;; ------------
;; Translate the directory tree in figure 123 into a data representation
;; according to model 3. Use "" for the content of files.
;;
;; Given the complexity of the data definition, contemplate how anyone can
;; design correct functions. Why are you confident that how-many produces
;; correct results? 
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


; Signature, Purpose Statement, Stub
; ==================================

; Dir.v3 -> Nat
; how many files does this directory contain?
#;
(define (how-many d)
  0)

; Tests
; =====
(check-expect (how-many ts) 7)
(check-expect (how-many text) 3)
(check-expect (how-many libs) 3)
(check-expect (how-many docs) 1)
(check-expect (how-many code) 2)
(check-expect (how-many (make-dir "Empty" '() '())) 0)

; Template
; ========

; Dir.v3 -> ...
(define (dir*-temp d*)
  (cond
    [(empty? d*) ...]
    [else (... (dir-temp (first d*)) ... (dir*-temp (rest d*)) ...)]))

; File.v3 -> ...
(define (file*-temp f*)
  (cond
    [(empty? f*) ...]
    [else (... (file-temp (first f*)) ... (file*-temp (rest f*)) ...)]))

; Dir* -> ...
(define (dir-temp d)
  (... (dir.v3-name d) ... (dir*-temp (dir.v3-dirs d)) ... (file*-temp (dirs-files d)) ...))

; File* -> ...
(define (file-temp f)
  (... (file-name f) ... (file-size f) ... (file-content f) ...))


; Code
; ====

(define (how-many D)
  (local (; Dir.v3 -> Nat
          (define (dir*-how-many d*)
            (cond
              [(empty? d*) 0]
              [else (+ (dir-how-many (first d*)) (dir*-how-many (rest d*)))]))

          ; File.v3 -> Nat
          (define (file*-how-many f*)
            (cond
              [(empty? f*) 0]
              [else (+ 1 (file*-how-many (rest f*)))]))

          ; Dir* -> Nat
          (define (dir-how-many d)
            (+ (dir*-how-many (dir-dirs d)) (file*-how-many (dir-files d)))))
    (dir-how-many D)))



; reasons we can design correct programs from such complex definitions:
; - designing the program parallel to the data definition (template)
; - and iteratively refining the data definition (and the program)

