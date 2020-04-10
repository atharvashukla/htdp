;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 172ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 172
;; ------------
;; Design the function collapse, which converts a list of lines into a string.
;; The strings should be separated by blank spaces (" "). The lines should be
;; separated with a newline ("\n").
;;
;; *Challenge* When you are finished, use the program like this:
;; 
;;    (write-file "ttt.dat"
;;                (collapse (read-words/line "ttt.txt")))
;; 
;; To make sure the two files "ttt.dat" and "ttt.txt" are identical, remove all
;; extraneous white spaces in your version of the T.T.T. poem. 
;; -----------------------------------------------------------------------------

(require 2htdp/batch-io)

(define (collapse lol)
  "")

(define line1 (cons "my" (cons "name" (cons "is" (cons "atharva" '())))))
(define line2 (cons "beginning" (cons "student" (cons "memory" '()))))

(define lol1 (cons line1 (cons line2 '())))

(define lol1r "my name is atharva\nbeginning student memory")

(check-expect (read-file "this.txt") lol1r)



;; A List-of-strings is one of
;; - '()
;; - (cons String List-of-string)

;; A List-of-list-of-strings is one of
;; - '()
;; - (cons List-ofStrings List-of-list-of-strings)

; LLS -> List-of-numbers
; determines the number of words on each line 


#;
(define (convert-words lls)
  (cond
    [(empty? lls) ...]
    [else
     (... (first lls)
          ... (convert-words (rest lls)) ...)]))

#;
(define (convert-lines ln)
  (cond
    [(empty? lls) ...]
    [else
     (... (first ln)
          ... (convert-lines (rest ln)) ...)]))

; ----------------------------
;; LLS -> String
;; converts a list of lines to their string form
(define (lines2string lines)
  (cond
    [(empty? lines) ""]
    [else
     (if (empty? (rest lines))
         (words2string (first lines))
         (string-append (words2string (first lines))
                    "\n"
                    (lines2string (rest lines))))]))

(check-expect (lines2string '()) "")
(check-expect (lines2string lol1) lol1r)

; ----------------------------
;; LOS -> String
;; converts a list of words to their string form
(define (words2string words)
  (cond
    [(empty? words) ""]
    [else (if (empty? (rest words))
              (first words)
              (string-append (first words)
                             " "
                             (words2string (rest words))))]))

(check-expect (words2string line1) "my name is atharva")
(check-expect (words2string line2) "beginning student memory")
(check-expect (words2string '()) "")

; -------

; check
(equal? (lines2string (read-words/line "ttt.txt")) (read-file "ttt.txt"))

(write-file "ttt.dat" (lines2string (read-words/line "ttt.txt"))) ;; good