;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 338ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 338
;; ------------
;; Use create-dir to turn some of your directories into ISL+ data
;; representations. Then use how-many from exercise 336 to count how many files
;; they contain. Why are you confident that how-many produces correct results
;; for these directories?
;; -----------------------------------------------------------------------------

(require htdp/dir)

(define to-htdp "/Users/pragya/Documents/GitHub")
(define from-htdp-to-ts
  "/how-to-design-programs/9-IV-Intertwined Data/20-Iterative-Refinement/20-3-Refining-Functions/TS")
(define ts-path (string-append to-htdp from-htdp-to-ts))

; (check-expect (make-path "abc") "|abc|")

(define (make-path str)
  (string-append "|" ts-path str "|"))



(define draw-file (make-file "draw" 2 (make-date 2019 7 28 22 18 4) ""))
(define hang-file (make-file "hang" 8 (make-date 2019 7 28 22 18 8) ""))
(define read-file-inner (make-file "read!" 19 (make-date 2019 7 28 22 19 7) ""))
(define read-file-docs (make-file "read!" 19 (make-date 2019 7 28 22 19 7) ""))
(define read-file-ts (make-file "read!" 10 (make-date 2019 7 28 22 17 32) ""))


(define part1-file (make-file "part1" 99 (make-date 2019 7 29 16 33 16) ""))
(define part2-file (make-file "part2" 52 (make-date 2019 7 29 16 33 33) ""))
(define part3-file (make-file "part3" 17 (make-date 2019 7 29 16 33 50) ""))

(define code-dir (make-dir (make-path "/Libs/Code") '() (list draw-file hang-file)))
(define docs-dir (make-dir (make-path "/Libs/Docs") '() (list read-file-docs)))
(define text-dir (make-dir (make-path "/Text") '() (list part1-file part2-file part3-file)))
(define libs-dir (make-dir (make-path "/Libs") (list code-dir docs-dir) '()))
(define ts-dir (make-dir (make-path "") (list libs-dir text-dir) (list read-file-ts)))

(define TS (create-dir ts-path))
; find . -name '.DS_Store' -type f -delete
; on dir in the term to recursively remove .DS_Store file

; (check-expect (path-sym->str TS) ts-dir)

(check-expect (how-many TS) 7)
(check-expect (how-many ts-dir) 7)
(check-expect (how-many libs-dir) 3)

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


; how-many produces the correct results