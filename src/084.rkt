;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 84ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 84.
;; ------------
;;
;; Design edit. The function consumes two inputs, an editor ed and a KeyEvent
;; ke, and it produces another editor. Its task is to add a single-character
;; KeyEvent ke to the end of the pre field of ed, unless ke denotes the
;; backspace ("\b") key. In that case, it deletes the character immediately to
;; the left of the cursor (if there are any). The function ignores the tab key
;; ("\t") and the return key ("\r").
;;
;; The function pays attention to only two KeyEvents longer than one letter:
;; "left" and "right". The left arrow moves the cursor one character to the;
;; left (if any), and the right arrow moves it one character to the right (if
;; any). All other such KeyEvents are ignored.
;;
;; Develop a goodly number of examples for edit, paying attention to special
;; cases. When we solved this exercise, we created 20 examples and turned all
;; of them into tests.
;; 
;; Hint Think of this function as consuming KeyEvents, a collection that is
;; specified as an enumeration. It uses auxiliary functions to deal with the
;; Editor structure. Keep a wish list handy; you will need to design additional
;; functions for most of these auxiliary functions, such as string-first,
;; string-rest, string-last, and string-remove-last. If you haven’t done so,
;; solve the exercises in Functions.
;;
;; -----------------------------------------------------------------------------


(require 2htdp/image)
(require 2htdp/universe)

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t


; Editor KeyEvent -> Editor
; Responds to keypress:
; - Adds the `ke` at the end of `pre` field of `ed`
; - Deletes it if "\b" is pressed.
; - Ignores "\t" and "\r"
; - Moves left on "left" and right on "right"
#;
(define (edit ed ke)
  ed)

; - "|" "a" -> "a|"
; - "|" "left" -> "|"
; - "|" "right" -> "|"
; - "|" "\b" -> "|"
; - "|" "\t" -> "|"
; - "|" "\r" -> "|"
; - "abc|" "\b" -> "ab|"
; - "ab|c" "\b" -> "a|c"
; - "|abc" "\b" -> "|abc"
; - "ab|" "c" -> "abc|"
; - "|bc" "a" -> "a|bc"
; - "a|c" "b" -> "ab|c"
; - "abc|" "left" -> "ab|c"
; - "abc|" "right" -> "abc|"
; - "|abc" "left" -> "|abc"
; - "|abc" "right" -> "a|bc"
; - "ab|c" "\t" -> "ab|c"
; - "ab|c" "\r" -> "ab|c" 
#;
(define (edit ed ke)
  (cond
    [(key=? "\b" ke) ...]
    [(key=? "left" ke) ...]
    [(key=? "right" ke) ...]
    [(or (key=? "\t" ke) (key=? "\r" ke)) ...]
    [else ...]))

(define (edit ed ke)
  (cond
    [(key=? "\b" ke) (delete ed)]
    [(key=? "left" ke) (move-left ed)]
    [(key=? "right" ke) (move-right ed)]
    [(or (key=? "\t" ke) (key=? "\r" ke)) ed]
    [else (insert ed ke)]))

;; Wish list: delete, move-left, move-right, insert

; Editor -> Editor
; deletes a letter to the left of the cursor
#;
(define (delete ed)
  (... (editor-pre ed) ... (editpr-post ed) ...))

(define (delete ed)
  (delete-str (editor-pre ed) (editor-post ed)))

; Editor -> Editor
; moves the cursor to its left
#;
(define (move-left ed)
  (... (editor-pre ed) ... (editpr-post ed) ...))

(define (move-left ed)
  (move-left-str (editor-pre ed)
                 (editor-post ed)))

; Editor -> Editor
; moves the cursor to its right
#;
(define (move-right ed)
  (... (editor-pre ed) ... (editpr-post ed) ...))

(define (move-right ed)
  (move-right-str (editor-pre ed) (editor-post ed)))


; Editor KeyEvent-> Editor
; inserts ke at the cursor position
#;
(define (insert ed ke)
  (... (editor-pre ed) ... (editpr-post ed) ...))

(define (insert ed ke)
  (insert-str (editor-pre ed) (editor-post ed) ke))


; String String -> Editor
(define (delete-str strl strr)
  (cond
    [(empty-string? strl) (make-editor strl strr)]
    [else (make-editor (string-remove-last strl) strr)]))

; String String -> Editor
(define (move-left-str strl strr)
  (if (empty-string? strl)
      (make-editor strl strr)
      (make-editor (string-remove-last strl) (string-append (string-last strl) strr))))

; String String -> Editor
(define (move-right-str strl strr)
  (if (empty-string? strr)
      (make-editor strl strr)
      (make-editor (string-append strl (string-first strr)) (string-rest strr))))

; String String -> Editor
(define (insert-str strl strr e)
  (make-editor (string-append strl e) strr))



(check-expect (edit (make-editor "" "") "a") (make-editor "a" ""))
(check-expect (edit (make-editor "" "") "left") (make-editor "" ""))
(check-expect (edit (make-editor "" "") "right") (make-editor "" ""))
(check-expect (edit (make-editor "" "") "\b") (make-editor "" ""))
(check-expect (edit (make-editor "" "") "\t") (make-editor "" ""))
(check-expect (edit (make-editor "" "") "\r") (make-editor "" ""))
(check-expect (edit (make-editor "abc" "") "\b") (make-editor "ab" ""))
(check-expect (edit (make-editor "ab" "c") "\b") (make-editor "a" "c"))
(check-expect (edit (make-editor "" "abc") "\b") (make-editor "" "abc"))
(check-expect (edit (make-editor "ab" "") "c") (make-editor "abc" ""))
(check-expect (edit (make-editor "" "bc") "a") (make-editor "a" "bc"))
(check-expect (edit (make-editor "a" "c") "b") (make-editor "ab" "c"))
(check-expect (edit (make-editor "abc" "") "left") (make-editor "ab" "c"))
(check-expect (edit (make-editor "abc" "") "right") (make-editor "abc" ""))
(check-expect (edit (make-editor "" "abc") "left") (make-editor "" "abc"))
(check-expect (edit (make-editor "" "abc") "right") (make-editor "a" "bc"))
(check-expect (edit (make-editor "ab" "c") "\t") (make-editor "ab" "c"))
(check-expect (edit (make-editor "ab" "c") "\r") (make-editor "ab" "c"))

;; String helpers

; NEString -> String
; gets the first character of a ne-str

(check-expect (string-first "abc") "a")

(define (string-first ne-str)
  (substring ne-str 0 1))

; NEString -> String
; gets the rest of the ne-str

(check-expect (string-rest "abc") "bc")

(define (string-rest ne-str)
  (substring ne-str 1))


; NEString -> String
; gets the last character of ne-str

(check-expect (string-last "abc") "c")

(define (string-last ne-str)
  (substring ne-str (sub1 (string-length ne-str))))

; NEString -> String
; removes the last character of ne-str

(check-expect (string-remove-last "abc") "ab")

(define (string-remove-last ne-str)
  (substring ne-str 0 (sub1 (string-length ne-str))))

; String -> Boolean
; is the string "" ?

(check-expect (empty-string? "abc") #false)
(check-expect (empty-string? "") #true)

(define (empty-string? str)
  (string=? "" str))