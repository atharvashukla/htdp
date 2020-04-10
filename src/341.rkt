;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 341ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 341
;; ------------
;; Design du, a function that consumes a Dir and computes the total size of all
;; the files in the entire directory tree. Assume that storing a directory in a
;; Dir structure costs 1 file storage unit. In the real world, a directory is
;; basically a special file, and its size depends on how large its associated
;; directory is.
;; -----------------------------------------------------------------------------

(require htdp/dir)

(define to-htdp "/Users/pragya/Documents/GitHub")
(define from-htdp-to-ts
  "/how-to-design-programs/9-IV-Intertwined Data/20-Iterative-Refinement/20-3-Refining-Functions/TS")
(define ts-path (string-append to-htdp from-htdp-to-ts))

(define (make-path str)
  (string-append "|" ts-path str "|"))


; (define-struct dir [name dirs files])
;   (make-dir String (List-of Dir) (List-of File))

; (define-struct file [name size date content])
;   (make-dir String Integer [Date U 0] Any)

; (define-struct date [year month day hours minutes seconds])
;   (make-date at Nat Nat Nat Nat Nat)


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


(check-expect (du ts-dir) (+ 207 5))


; Dir -> Number
; size of all files + 1 unit per directory
(define (du d)
  (local (; [List-of Dir] -> Number
          ; sum of the sizes of all files within lodir
          ; and +1 unit per directory
          (define (lodir-du lodir)
            (apply + (map dir-du lodir)))

          ; [List-of File] -> Number
          ; sum of file sizes in lof
          (define (lof-du lof)
            (apply + (map file-du lof)))

          ; Dir -> Number
          ; sizes of all files within sub-dirs and files of d
          ; and one unit for this directory
          (define (dir-du d)
            (+ 1 ; adding one unit per directory
               (+ (lodir-du (dir-dirs d)) (lof-du (dir-files d)))))

          ; File -> Number
          ; extracts the size of file f
          (define (file-du f)
            (file-size f)))
    (dir-du d)))