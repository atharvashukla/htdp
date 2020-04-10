;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 177ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 177
;; ------------
;; Design the function create-editor. The function consumes two strings and
;; produces an Editor. The first string is the text to the left of the cursor
;; and the second string is the text to the right of the cursor. The rest of
;; the section relies on this function.
;; -----------------------------------------------------------------------------

(define-struct editor [pre post])

; An Editor is a structure:
;   (make-editor Lo1S Lo1S)

; An Lo1S is one of: 
; – '()
; – (cons 1String Lo1S)

(define atharva (cons "a" (cons "t" (cons "h" (cons "a" (cons "r" (cons "v" (cons "a" '()))))))))
(define avrahta (cons "a" (cons "v" (cons "r" (cons "a" (cons "h" (cons "t" (cons "a" '()))))))))
(define shukla (cons "s" (cons "h" (cons "u" (cons "k" (cons "l" (cons "a" '())))))))

;; String String -> Editor
;; creates an editor from the two given strings

#;
(define (create-editor pre-str post-str)
  (make-editor "a" "a"))

(check-expect (create-editor "atharva" "shukla")
              (make-editor avrahta shukla))
(check-expect (create-editor "" "")
              (make-editor '() '()))

(define (editor-temp e)
  (... (editor-pre e) ... (editor-post e) ...))

(define (create-editor pre-str post-str)
  (make-editor (reverse (explode pre-str)) (explode post-str)))
