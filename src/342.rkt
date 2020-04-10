;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 342ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 342
;; ------------
;; Design find. The function consumes a directory d and a file name f. If
;; (find? d f) is #true, find produces a path to a file with name f; otherwise
;; it produces #false.
;;
;; *Hint* While it is tempting to first check whether the file name occurs in
;; the directory tree, you have to do so for every single sub-directory. Hence
;; it is better to combine the functionality of find? and find.
;;
;; *Challenge* The find function discovers only one of the two files named read!
;; in figure 123. Design find-all, which generalizes find and produces the list
;; of all paths that lead to f in d. What should find-all produce when
;; (find? d f) is #false? Is this part of the problem really a challenge
;; compared to the basic problem? 
;; -----------------------------------------------------------------------------

(require htdp/dir)

(define to-htdp "/Users/pragya/Documents/GitHub")
(define from-htdp-to-ts
  "/how-to-design-programs/9-IV-Intertwined Data/20-Iterative-Refinement/20-3-Refining-Functions/TS")
(define ts-path (string-append to-htdp from-htdp-to-ts))

(define (make-path str)
  (string-append ts-path str))


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


; Dir String -> [String U #false]
; return the path to file f-str, if it doesn't exist return #false
(define (produce-path d f-str)
  (local (; [List-of Dir] -> [String U f-str]
          ; return the path of file f-str if it's within any dir,
          ; otherwise return #f
          (define (lodir-produce-path lodir)
            (cond
              [(empty? lodir) #false]
              [else (local ((define f-path (dir-produce-path (first lodir))))
                      (if (string? f-path)
                          f-path
                          (lodir-produce-path (rest lodir))))]))
          
          ; Dir -> [String U #false]
          ; if dir has file, return its name, else check sub dirs
          (define (dir-produce-path d)
            (if (member? f-str (map file-name (dir-files d)))
                (dir-name d)
                (lodir-produce-path (dir-dirs d))))

          ; String String -> String
          ; adds the name of the file to the path string
          (define (add-file-to-path path file)
            (local ((define pathlen (string-length path)))
              (string-append path "/" file))))
    (add-file-to-path (dir-produce-path d) f-str)))


(check-expect (produce-path ts-dir "part2") (string-append ts-path "/Text/part2"))
(check-expect (produce-path ts-dir "draw") (string-append ts-path "/Libs/Code/draw"))

; Challenge: find-all

; Dir String -> [List-of String]
; return the path to file f-str, if it doesn't exist return #false
(define (find-all d f-str)
  (local (; [List-of Dir] -> [List-of String]
          ; return the paths of all files named f-str in any dir in lodir
          (define (lodir-produce-paths lodir)
            (cond
              [(empty? lodir) '()]
              [else (append (dir-produce-paths (first lodir))
                            (lodir-produce-paths (rest lodir)))]))
          
          ; Dir -> [List-of String]
          ; return the paths of all files named f-str in dir d
          (define (dir-produce-paths d)
            (append (lof-produce-paths (dir-files d) d)
                    (lodir-produce-paths (dir-dirs d))))

          ; File Dir -> [List-of String]
          ; produce paths of all files that match with name f-str
          (define (lof-produce-paths lof parent-dir)
            (cond
              [(empty? lof) '()]
              [else (if (equal? (file-name (first lof)) f-str)
                        (cons (dir-name parent-dir) (lof-produce-paths (rest lof) parent-dir))
                        (lof-produce-paths (rest lof) parent-dir))]))
          
          ; String String -> String
          ; adds the name of the file to the path string
          (define (add-file-to-paths path file)
            (local ((define pathlen (string-length path)))
              (string-append path "/" file))))
    (map (λ (path) (add-file-to-paths path f-str)) (dir-produce-paths d))))


(check-expect (find-all ts-dir "part2") (list (string-append ts-path "/Text/part2")))
(check-expect (find-all ts-dir "draw") (list (string-append ts-path "/Libs/Code/draw")))

(check-member-of (find-all ts-dir "read!")
                 (list (string-append ts-path "/Libs/Docs/read!")
                       (string-append ts-path "/read!"))
                 (list (string-append ts-path "/read!")
                       (string-append ts-path "/Libs/Docs/read!")))

