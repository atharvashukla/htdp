;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 344ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 344
;; ------------
;; Redesign find-all from exercise 342 using ls-R from exercise 343. This is
;; design by composition, and if you solved the challenge part of exercise 342
;; your new function can find directories, too.
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


; Dir String -> [List-of String]
; paths to all files in dir d
(define (ls-R d)
  (local (; [List-of Dir] -> [List-of String]
          ; paths to all files in all dirs in lodir
          (define (lodir-produce-paths lodir)
            (cond
              [(empty? lodir) '()]
              [else (append (dir-produce-paths (first lodir))
                            (lodir-produce-paths (rest lodir)))]))
          
          ; Dir -> [List-of String]
          ; paths to all files in this fir d and all sub-dirs
          (define (dir-produce-paths d)
            (append (lof-produce-paths (dir-files d) d)
                    (lodir-produce-paths (dir-dirs d))))

          ; File Dir -> [List-of String]
          ; paths to all files in the lof
          (define (lof-produce-paths lof parent-dir)
            (cond
              [(empty? lof) '()]
              [else (cons (gen-path (first lof) parent-dir)
                          (lof-produce-paths (rest lof) parent-dir))]))

          ; File Dir -> String
          ; generate the path of f file in dir
          (define (gen-path f dir)
            (string-append (dir-name dir) "/" (file-name f))))

    (dir-produce-paths d)))


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

(define all-paths
  (list (make-path "/Libs/Code/draw") 
        (make-path "/Libs/Code/hang") 
        (make-path "/Libs/Docs/read!") 
        (make-path "/read!")
        (make-path "/Text/part1")
        (make-path "/Text/part2")
        (make-path "/Text/part3")))

(check-satisfied (ls-R ts-dir)
                 (variant? all-paths))

;; -----------------------------------------------------------------------------

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

;; -----------------------------------------------------------------------------

; Dir String -> [List-of String]
; return the path to file f-str, if it doesn't exist return #false
(define (find-all-2 d f-str)
  (filter (λ (p) (suffix-file? p f-str)) (ls-R d)))


; String String -> Boolean
; does path have file as a suffix?
(define (suffix-file? path file)
  (local ((define path-len (string-length path))
          (define file-len (string-length file)))
    (if (>= path-len file-len)
        (equal? (substring path (- path-len file-len) path-len) file)
        #false)))

(check-expect (find-all-2 ts-dir "part2") (list (string-append ts-path "/Text/part2")))
(check-expect (find-all-2 ts-dir "draw") (list (string-append ts-path "/Libs/Code/draw")))

(check-member-of (find-all-2 ts-dir "read!")
                 (list (string-append ts-path "/Libs/Docs/read!")
                       (string-append ts-path "/read!"))
                 (list (string-append ts-path "/read!")
                       (string-append ts-path "/Libs/Docs/read!")))