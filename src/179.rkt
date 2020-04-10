;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 179ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 179
;; ------------
;;
;; Design the functions
;;
;;    ; Editor -> Editor
;;    ; moves the cursor position one 1String left, 
;;    ; if possible 
;;    (define (editor-lft ed) ed)
;;     
;;    ; Editor -> Editor
;;    ; moves the cursor position one 1String right, 
;;    ; if possible 
;;    (define (editor-rgt ed) ed)
;;     
;;    ; Editor -> Editor
;;    ; deletes a 1String to the left of the cursor,
;;    ; if possible 
;;    (define (editor-del ed) ed)
;;
;; Again, it is critical that you work through a good range of examples. 
;; 
;; -----------------------------------------------------------------------------


(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor Lo1S Lo1S) 
; An Lo1S is one of: 
; – '()
; – (cons 1String Lo1S)
; interpretation pre is a list of 1String that
; precedes the cursor in reverse order. post is
; a list of 1String that succeeds the post.

(define good
  (cons "g" (cons "o" (cons "o" (cons "d" '())))))
(define all
  (cons "a" (cons "l" (cons "l" '()))))
(define lla
  (cons "l" (cons "l" (cons "a" '()))))
(define init-editor (make-editor '() '()))

#;; template
(define (editor-temp ed)
  (... ed ...
   ... (editor-pre ed) ...
   ... (editor-post ed) ...))



; Editor -> Editor
; moves the cursor position one 1String left, 
; if possible

(check-expect (editor-lft (make-editor lla good)) (make-editor (rest lla) (cons "l" good)))
(check-expect (editor-lft init-editor) init-editor)

(define (editor-lft ed)
  (if (empty? (editor-pre ed))
      ed
      (make-editor (rest (editor-pre ed)) (cons (first (editor-pre ed)) (editor-post ed)))))
 
; Editor -> Editor
; moves the cursor position one 1String right, 
; if possible

(check-expect (editor-rgt (make-editor lla good)) (make-editor (cons "g" lla) (rest good)))
(check-expect (editor-rgt init-editor) init-editor)

(define (editor-rgt ed)
  (if (empty? (editor-post ed))
      ed
      (make-editor (cons (first (editor-post ed)) (editor-pre ed)) (rest (editor-post ed)))))
 
; Editor -> Editor
; deletes a 1String to the left of the cursor,
; if possible

(check-expect (editor-del (make-editor lla good)) (make-editor (rest lla) good))
(check-expect (editor-del init-editor) init-editor)

(define (editor-del ed)
  (if (empty? (editor-pre ed))
      ed
      (make-editor (rest (editor-pre ed)) (editor-post ed))))

