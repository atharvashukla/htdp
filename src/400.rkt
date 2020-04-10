;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 400ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 400
;; ------------
;; Design the function DNAprefix. The function takes two arguments, both lists
;; of 'a, 'c, 'g, and 't, symbols that occur in DNA descriptions. The first
;; list is called a pattern, the second one a search string. The function
;; returns #true if the pattern is identical to the initial part of the search
;; string; otherwise it returns #false.
;;
;; Also design DNAdelta. This function is like DNAprefix but returns the first
;; item in the search string beyond the pattern. If the lists are identical and
;; there is no DNA letter beyond the pattern, the function signals an error. If
;; the pattern does not match the beginning of the search string, it returns
;; #false. The function must not traverse either of the lists more than once.
;;
;; Can DNAprefix or DNAdelta be simplified?
;; -----------------------------------------------------------------------------


; Nucleotide is one of:
; - 'a
; - 'c
; - 'g
; - 't

; [List-of Nucleotide] [List-of Nucleotide] -> Boolean
; is patters a prefix of string?

(check-expect (DNAprefix '() '()) #t)
(check-expect (DNAprefix '(t a c) '()) #f)
(check-expect (DNAprefix '() '(t a c)) #t)
(check-expect (DNAprefix '(g t a) '(g t a c t g a)) #t)
(check-expect (DNAprefix '(g t a) '(g a t c t g a)) #f)
(check-expect (DNAprefix '(g) '(t a c)) #f)
(check-expect (DNAprefix '(a c g) '(a c)) #f)


#;
(define (DNAprefix pattern string)
  #true)

#;
(define (DNAprefix pattern string)
  (cond
    [(and (empty? pattern) (empty? string)) ...]
    [(and (empty? pattern) (cons? string))  ...]
    [(and (cons? pattern) (empty? string))  ...]
    [(and (cons? pattern) (cons? string))
     (... ... (first pattern) ... (first string) ...
          ... (rest pattern) ... (rest string) ...)]))


(define (DNAprefix pattern string)
  (cond
    [(and (empty? pattern) (empty? string)) #true]
    [(and (empty? pattern) (cons? string))  #true]
    [(and (cons? pattern) (empty? string))  #false]
    [(and (cons? pattern) (cons? string))
     (if (equal? (first pattern) (first string))
         (DNAprefix (rest pattern) (rest string))
         #false)]))

; [List-of Nucleotide] [List-of Nucleotide] -> [Nucleotide U #f]
; first item in string beyond the pattern, if no letter
; beyond the pattern, then error, otherwise #false

(check-error (DNAdelta '() '()) "pattern and string match exactly")
(check-error (DNAdelta '(c c c) '(c c c)) "pattern and string match exactly")
(check-expect (DNAdelta '(t a c) '()) #f)
(check-expect (DNAdelta '() '(t a c)) 't)
(check-expect (DNAdelta '(g t a) '(g t a c t g a)) 'c)
(check-expect (DNAdelta '(g t a) '(g a t c t g a)) #f)
(check-expect (DNAdelta '(g) '(t a c)) #f)
(check-expect (DNAdelta '(a c g) '(a c)) #f)

(define (DNAdelta pattern string)
  (cond
    [(and (empty? pattern) (empty? string)) (error "pattern and string match exactly" )]
    [(and (empty? pattern) (cons? string))  (first string)]
    [(and (cons? pattern) (empty? string))  #false]
    [(and (cons? pattern) (cons? string))
     (if (equal? (first pattern) (first string))
         (DNAdelta (rest pattern) (rest string))
         #false)]))


;; -----------------------------------------------------------------------------
;; Simplification


(check-expect (DNAprefix.v2 '() '()) #t)
(check-expect (DNAprefix.v2 '(t a c) '()) #f)
(check-expect (DNAprefix.v2 '() '(t a c)) #t)
(check-expect (DNAprefix.v2 '(g t a) '(g t a c t g a)) #t)
(check-expect (DNAprefix.v2 '(g t a) '(g a t c t g a)) #f)
(check-expect (DNAprefix.v2 '(g) '(t a c)) #f)
(check-expect (DNAprefix.v2 '(a c g) '(a c)) #f)


(define (DNAprefix.v2 pattern string)
  (or (empty? pattern)
      (and (not (empty? string))
           (equal? (first pattern) (first string))
           (DNAprefix.v2 (rest pattern) (rest string)))))



(check-error (DNAdelta.v2 '() '()) "pattern and string match exactly")
(check-error (DNAdelta.v2 '(c c c) '(c c c)) "pattern and string match exactly")
(check-expect (DNAdelta.v2 '(t a c) '()) #f)
(check-expect (DNAdelta.v2 '() '(t a c)) 't)
(check-expect (DNAdelta.v2 '(g t a) '(g t a c t g a)) 'c)
(check-expect (DNAdelta.v2 '(g t a) '(g a t c t g a)) #f)
(check-expect (DNAdelta.v2 '(g) '(t a c)) #f)
(check-expect (DNAdelta.v2 '(a c g) '(a c)) #f)


(define (DNAdelta.v2 pattern string)
  (cond
    [(and (empty? pattern) (empty? string)) (error "pattern and string match exactly" )]
    [(and (empty? pattern) (cons? string))  (first string)]
    [(empty? string)  #false]
    [else
     (if (equal? (first pattern) (first string))
         (DNAdelta (rest pattern) (rest string))
         #false)]))

; tougher to simplify due to various types of results on each cond clause
; cannot use boolean operator for the last two cases because DNAdelta may
; not always return a boolean
