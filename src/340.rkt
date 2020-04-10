;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 340ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 340
;; ------------
;; Design the function ls, which lists the names of all files and directories in
;; a given Dir.
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

; Dir -> [List-of String]
; all file names within dir d
(define (ls d)
  (local (; [List-of Dir] -> [List-of String]
          ; all files names within lodir
          (define (lodir-ls lodir)
            (foldr (λ (e a) (append (dir-ls e) a)) '() lodir))

          ; [List-of File] -> [List-of String]
          ; extract names of all files in lof
          (define (lof-ls lof)
            (map file-ls lof))

          ; Dir -> [List-of String]
          ; combines files and files within sub-dirs in d
          (define (dir-ls d)
            (append (lodir-ls (dir-dirs d)) (lof-ls (dir-files d))))

          ; File -> String
          ; extracts the name of file f
          (define (file-ls f)
            (file-name f)))
    (dir-ls d)))


(check-satisfied (ls ts-dir)
                  (variant? (list "read!" "read!" "hang" "draw" "part3" "part2" "part1")))

(check-satisfied (ls libs-dir)
                 (variant? (list "read!" "hang" "draw")))

; [List-of X] -> [[List-of X] -> Boolean]
; a function that checks if l is a rearrangement of k
(define (variant? k)
  (local (; [List-of X] [List-of X] -> Boolean 
          ; are all items in list k members of list l
          (define (contains? l k)
            (andmap (lambda (in-k) (member? in-k l)) k)))
    (lambda (l)
      (and (contains? l k)
           (contains? k l)
           (= (length k) (length l))))))