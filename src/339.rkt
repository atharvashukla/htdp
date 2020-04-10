;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 339ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 339
;; ------------
;; Design find?. The function consumes a Dir and a file name and determines
;; whether or not a file with this name occurs in the directory tree.
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


; [List-of Dir] -> ???
; ...
(define (lodir-temp lodir)
  (cond
    [(empty? lodir) ...]
    [else (... (dir-temp (first lodir)) ... (lodir-temp (rest lodir)) ...)]))

; [List-of File] -> ???
; ...
(define (lof-temp lof)
  (cond
    [(empty? lof) ...]
    [else (... (file-temp (first lof)) ... (lof-temp (rest lof)) ...)]))

; Dir -> ???
; ...
(define (dir-temp d)
  (... (dir-name d) ... (lodir-temp (dir-dirs d)) ... (lof-temp (dir-files d)) ...))

; File -> ???
; ...
(define (file-temp f)
  (... (file-name f) ... (file-size f) ...
       (file-dat f) ... (file-content) ...))

; Dir String -> Boolean
; does file f-str occur within dir d?
(define (find? d f-str)
  (local (; [List-of Dir] -> Boolean
          ; is a file na,es f-str within lodir?
          (define (lodir-find? lodir)
            (ormap dir-find? lodir))

          ; [List-of File] -> Boolean
          ; is f-str in this list of files?
          (define (lof-find? lof)
            (ormap file-find? lof))

          ; Dir -> Boolean
          ; is a file na,es f-str within dir d?
          (define (dir-find? d)
            (or (lodir-find? (dir-dirs d)) (lof-find? (dir-files d))))

          ; File -> Boolean
          ; is file f have the name f-str?
          (define (file-find? f)
            (string=? (file-name f) f-str)))
    (dir-find? d)))


(check-expect (find? ts-dir "draw") #true)
(check-expect (find? ts-dir "hang") #true)
(check-expect (find? ts-dir "readme") #false)