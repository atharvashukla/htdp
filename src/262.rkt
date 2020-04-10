;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 262ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 262
;; ------------
;; Design the function identityM, which creates diagonal squares of 0s and 1s:
;;
;;    > (identityM 1) ; identity matrix
;;    (list (list 1))
;;    
;;    > (identityM 3)
;;    (list (list 1 0 0) (list 0 1 0) (list 0 0 1))
;;
;; Use the structural design recipe and exploit the power of local.
;; -----------------------------------------------------------------------------


; Number -> [List-of [List-of Number]]
; creates an an identity matrix of size n
#;
(define (identityM n)
'())


; examples

; 0 => []

; 1 => [1]

; 2
; =>
; [[1 0]
;  [0 1]]

; 3
; =>
; 1 0 0
; 0 1 0
; 0 0 1

; 4
; =>
; 1 0 0 0
; 0 1 0 0
; 0 0 1 0
; 0 0 0 1


; 5
; =>
; 1 0 0 0
; 0 1 0 0
; 0 0 1 0
; 0 0 0 1


; tests

(check-expect (identityM 0) '())
(check-expect (identityM 1) '((1)))
(check-expect (identityM 2) '((1 0) (0 1)))
(check-expect (identityM 3) '((1 0 0) (0 1 0) (0 0 1)))
(check-expect (identityM 4) '((1 0 0 0) (0 1 0 0) (0 0 1 0) (0 0 0 1)))
(check-expect (identityM 5) '((1 0 0 0 0) (0 1 0 0 0) (0 0 1 0 0) (0 0 0 1 0) (0 0 0 0 1)))

; template
#;
(define (identityM n)
  (cond
    [(zero? n) ...]
    [else (... n ... (identityM (sub1 n)) ...)]))


; funtion definition

(define (identityM n)
  (cond
    [(zero? n) '()]
    [else
     ; the last row has n-1 0s and a 1 at the nth position
     (add-last-row n
                   ; adds 0 at the end of every row of the result of the natural recursion
                   (add-0-at-the-end-of-each-row (identityM (sub1 n))))]))


; [List-of [List-of Number]] -> [List-of [List-of Number]]
; adds 0 at the end of each list in l
(check-expect (add-0-at-the-end-of-each-row '((1 0 0) (0 1 0) (0 0 1)))
              '((1 0 0 0) (0 1 0 0) (0 0 1 0)))
(check-expect (add-0-at-the-end-of-each-row '()) '())

(define (add-0-at-the-end-of-each-row l)
  (cond
    [(empty? l) '()]
    [else (cons (add-elem-at-end 0 (first l))
                (add-0-at-the-end-of-each-row (rest l)))]))



; Number [List-of Number] -> [List-of Number]
; makes a row with 1 at nth position (other positions have 0s)
; and adds it to l
(define (add-last-row n l)
  (add-elem-at-end (make-last-row n) l))

; Number -> [List-of ZeroOrOne]
; the list has n element and the last element is a 1 (others are 0s)

(check-expect (make-last-row 5) '(0 0 0 0 1))
(check-expect (make-last-row 1) '(1))

(define (make-last-row n)
  (add-elem-at-end 1 (zero-list (sub1 n))))


; Number -> [List-of Number]
; a list with n zeroes

(check-expect (zero-list 0) '())
(check-expect (zero-list 1) '(0))
(check-expect (zero-list 5) '(0 0 0 0 0))

(define (zero-list n)
  (cond
    [(zero? n) '()]
    [else (cons 0 (zero-list (sub1 n)))]))


; [X] X [List-of X] -> [List-of X]
; add e at the end of l

(check-expect (add-elem-at-end 0 '()) '(0))
(check-expect (add-elem-at-end 0 '(1 0)) '(1 0 0))

(define (add-elem-at-end e l)
  (cond
    [(empty? l) (list e)]
    [else (cons (first l) (add-elem-at-end e (rest l)))]))


; conversion to local:

(check-expect (identityM2 0) '())
(check-expect (identityM2 1) '((1)))
(check-expect (identityM2 2) '((1 0) (0 1)))
(check-expect (identityM2 3) '((1 0 0) (0 1 0) (0 0 1)))
(check-expect (identityM2 4) '((1 0 0 0) (0 1 0 0) (0 0 1 0) (0 0 0 1)))
(check-expect (identityM2 5) '((1 0 0 0 0) (0 1 0 0 0) (0 0 1 0 0) (0 0 0 1 0) (0 0 0 0 1)))

; Number -> [List-of [List-of Number]]
; creates an an identity matrix of size n
(define (identityM2 N)
  (local (; Number -> [List-of [List-of Number]]
          ; creates an an identity matrix of size n
          (define (id n)
            (cond
              [(zero? n) '()]
              [else (combine-ids n (identityM (sub1 n)))]))

          ; Numbner [List-of Number] -> [List-of Number]
          ; transforms an identity matrix id of size n-1 to one of size n
          (define (combine-ids n id)
            (local (; [List-of [List-of Number]] -> [List-of [List-of Number]]
                    ; adds 0 at the end of each list in l
                    (define (add-0-at-the-end-of-each-row2 l)
                      (cond
                        [(empty? l) '()]
                        [else (cons (add-elem-at-end 0 (first l))
                                    (add-0-at-the-end-of-each-row2 (rest l)))]))
                    ; Number [List-of Number] -> [List-of Number]
                    ; makes a row with 1 at nth position (other positions have 0s)
                    ; and adds it to l
                    (define (add-last-row2 n l)
                      (local (; Number -> [List-of ZeroOrOne]
                              ; the list has n element and the last element is a 1 (others are 0s)
                              (define (make-last-row2 n)
                                (local (; Number -> [List-of Number]
                                        ; a list with n zeroes
                                        (define (zero-list2 n)
                                          (cond
                                            [(zero? n) '()]
                                            [else (cons 0 (zero-list2 (sub1 n)))]))
                                        (define lo-sub1-zeroes (zero-list2 (sub1 n)))
                                        (define snoc-1-to-lo-zeroes (add-elem-at-end 1 lo-sub1-zeroes)))
                                  ; -->
                                  snoc-1-to-lo-zeroes))
                              (define the-last-row (make-last-row2 n))
                              (define add-the-last-row (add-elem-at-end the-last-row l)))
                        ; -->
                        add-the-last-row))
                    (define snoc-0s+append-last-row (add-last-row2 n (add-0-at-the-end-of-each-row2 id))))
              ; -->
              snoc-0s+append-last-row)))
    (id N)))

