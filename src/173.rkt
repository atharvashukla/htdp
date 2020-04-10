;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 173ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 173
;; ------------
;; Design a program that removes all articles from a text file. The program
;; consumes the name n of a file, reads the file, removes the articles, and
;; writes the result out to a file whose name is the result of concatenating
;; "no-articles-" with n. For this exercise, an article is one of the following
;; three words: "a", "an", and "the".
;; 
;; Use read-words/line so that the transformation retains the organization of
;; the original text into lines and words. When the program is designed, run
;; it on the Piet Hein poem.
;; -----------------------------------------------------------------------------

(require 2htdp/batch-io)

;; --- helpers from the previous exercise ---

; ----------------------------
;; LLS -> String
;; converts a list of lines to their string form
(define (lines2string lines)
  (cond
    [(empty? lines) ""]
    [(empty? (rest lines)) (words2string (first lines))]
    [else
     (string-append (words2string (first lines))
                    "\n"
                    (lines2string (rest lines)))]))

(check-expect (lines2string '()) "")
(check-expect (lines2string lol1) lol1r)

; ----------------------------
;; LOS -> String
;; converts a list of words to their string form
(define (words2string words)
  (cond
    [(empty? words) ""]
    [(empty? (rest words)) (first words)]
    [else (string-append (first words)
                         " "
                         (words2string (rest words)))]))

(check-expect (words2string line1) "my name is atharva")
(check-expect (words2string line2) "beginning student memory")
(check-expect (words2string '()) "")

; ----------------------------

(define line1 (cons "my" (cons "name" (cons "is" (cons "atharva" '())))))
(define line2 (cons "beginning" (cons "student" (cons "memory" '()))))

(define lol1 (cons line1 (cons line2 '())))

(define lol1r "my name is atharva\nbeginning student memory")


; ----------------------------



;; consume name `n`
;; read file
;; remove the articles
;; write the result to a new file
;; new file name: no-articles-n

;; an Article is one of:
;; - "a"
;; - "an"
;; - "the"


;; LLS -> LLS
;; remove articles from a list of strings
(define (remove-articles-lines lines)
  (cond
    [(empty? lines) '()]
    [else (cons (remove-articles-words (first lines))
                (remove-articles-lines (rest lines)))]))

(check-expect (remove-articles-lines (cons words1 (cons words2 '())))
              (cons words1-no-articles (cons words2-no-articles '())))


;; LOS -> LOS
;; remove articles from a list of list of strings

(define (remove-articles-words words)
  (cond
    [(empty? words) '()]
    [else (if (is-article? (first words))
              (remove-articles-words (rest words))
              (cons (first words) (remove-articles-words (rest words))))]))

(define words1 (cons "this" (cons "the" (cons "a" (cons "zidane" (cons "uwu" '()))))))
(define words1-no-articles (cons "this" (cons "zidane" (cons "uwu" '()))))
(define words2 (cons "what" (cons "you" (cons "is" (cons "the" '())))))
(define words2-no-articles (cons "what" (cons "you" (cons "is" '()))))
(check-expect (remove-articles-words words1) words1-no-articles)
(check-expect (remove-articles-words words2) words2-no-articles)


;; String -> Boolean
;; is this string an article
(define (is-article? a-string)
  (cond
    [(string=? a-string "a") #true]
    [(string=? a-string "an") #true]
    [(string=? a-string "the") #true]
    [else #false]))

(check-expect (is-article? "hello") #false)
(check-expect (is-article? "a") #true)
(check-expect (is-article? "the") #true)
(check-expect (is-article? "an") #true)
(check-expect (is-article? "the") #true)
(check-expect (is-article? "neymar") #false)



;; String -> File-output
;; produces a new file with all the articles removed
(define (remove-articles file-name)
  (write-file (string-append "no-articles-" file-name) ; new name of the file
              (lines2string                            ; converting to string
               (remove-articles-lines                  ; removing all articles
                (read-words/line                       ; reading the file
                 file-name)))))

(remove-articles "a-passage.txt")

(define without-articles-string1 "for stories exercise on 30 human rights. For example: ")
(define without-articles-string2 "The Right to Life, Freedom of Thought, Freedom of ")
(define without-articles-string3 "Expression, and others. audio and story to each right.")
(define final-without-articles-string
  (string-append without-articles-string1
                 without-articles-string2
                 without-articles-string3))


(check-expect (read-file "no-articles-a-passage.txt") final-without-articles-string) ; final check
  