;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 386ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 386
;; ------------
;; Here is the get function:
;;
;;    ; Xexpr.v3 String -> String
;;    ; retrieves the value of the "content" attribute 
;;    ; from a 'meta element that has attribute "itemprop"
;;    ; with value s
;;    (check-expect
;;      (get '(meta ((content "+1") (itemprop "F"))) "F")
;;      "+1")
;;     
;;    (define (get x s)
;;      (local ((define result (get-xexpr x s)))
;;        (if (string? result)
;;            result
;;            (error "not found"))))
;;
;; It assumes the existence of get-xexpr, a function that searches an arbitrary
;; Xexpr.v3 for the desired attribute and produces [Maybe String].
;; 
;; Formulate test cases that look for other values than "F" and that force get
;; to signal an error.

;; Design get-xexpr. Derive functional examples for this function from those
;; for get. Generalize these examples so that you are confident get-xexpr can
;; traverse an arbitrary Xexpr.v3. Finally, formulate a test that uses the web
;; data saved in exercise 385.
;; -----------------------------------------------------------------------------


; Xexpr -> Symbol
; the tag of the element representation
(define (xexpr-name x)
  (first x))

; Xexpr -> [List-of Content]
; list of content elements
(define (xexpr-content xe)
  (local ((define optional-loa+content
            (rest xe)))
    (cond
      [(empty? optional-loa+content) '()]
      [else
       (local ((define loa-or-x (first optional-loa+content)))
         (if (list-of-attributes? loa-or-x)
             (rest optional-loa+content)
             optional-loa+content))])))


; [List-of Attribute] or Xexpr -> [List-of Attribtute]
; the attribute list of the xexpr

(define (xexpr-attr xe)
  (local ((define optional-loa+content (rest xe)))
    (cond
      [(empty? optional-loa+content) '()]
      [else
       (local ((define loa-or-x (first optional-loa+content)))
         (if (list-of-attributes? loa-or-x)
             loa-or-x
             '()))])))

; [List-of Attribute] or Xexpr.v2 -> Boolean
; is x a list of attributes
(define (list-of-attributes? x)
  (cond
    [(empty? x) #true]
    [else
     (local ((define possible-attribute (first x)))
       (cons? possible-attribute))]))

;; -----------------------------------------------------------------------------


(require 2htdp/image)
(require 2htdp/universe)
(require 2htdp/batch-io)

; An Xexpr.v3 is one of:
;  – Symbol
;  – String
;  – Number
;  – (cons Symbol (cons Attribute*.v3 [List-of Xexpr.v3]))
;  – (cons Symbol [List-of Xexpr.v3])
; 
; An Attribute*.v3 is a [List-of Attribute.v3].
;   
; An Attribute.v3 is a list of two items:
;   (list Symbol String)


;; -----------------------------------------------------------------------------

; Xexpr -> ???
; ...
(define (xexpr-temp x)
  (cond
    [(symbol? x) ...]
    [(string? x) ...]
    [(number? x) ...]
    [else (... ... (xexpr-name x) ...
               ... (loa-temp (xexpr-attr x)) ...
               ... (lox-temp (xexpr-content)) ...)]))

; [List-of Xexpr] -> ???
; ...
(define (lox-temp lox)
  (cond
    [(empty? lox) ...]
    [else (... (xexpr-temp (first lox)) ... (lox-temp (rest lox)) ...)]))

; [List-of Attribute] -> ???
; ...
(define (loa-temp loa)
  (cond
    [(empty? loa) ...]
    [else (... (attr-temp (firts loa)) ... (loa-temp (rest loa)) ...)]))

; Attribute -> ???
; ...
(define (attr-temp a)
  (... (first a) ... (second a) ...))

;; -----------------------------------------------------------------------------

; Xexpr String -> String
; get the content of the property searched for
(define (get-content x str)
  (local ((define lookd (xexpr-get x str)))
    (if (equal? lookd #false)
        (error "the thing you're searching for is not there")
        (second (assq 'content lookd)))))

; Xexpr String -> [[List-of Attribute] U #false]
; finds the string associated with sym in x
(define (xexpr-get x str)
  (cond
    [(symbol? x) #false]
    [(string? x) #false]
    [(number? x) #false]
    [else (local ((define search-in-loa (get-correct-loa (xexpr-attr x) str)))
            (if (boolean? search-in-loa)
                (lox-get (xexpr-content x) str)
                search-in-loa))]))

; [List-of Xexpr] String -> [String U #false]
; finds the string associated with sym in lox
(define (lox-get lox str)
  (cond
    [(empty? lox) #false]
    [else (local ((define in-fst (xexpr-get (first lox) str)))
            (if (boolean? in-fst)
                (lox-get (rest lox) str)
                in-fst))]))

; [List-of Attribute] -> [String U #false]
; if loa has an attr with a string "priceChange"
; return the loa, otherwise, return #false
(define (get-correct-loa loa str)
  (local (; [List-of Attribute] -> #false
          (define (is-correct-loa? loa str)
            (cond
              [(empty? loa) #false]
              [else (or (correct-a? (first loa) str) 
                        (is-correct-loa? (rest loa) str))])))
    (if (is-correct-loa? loa str)
        loa
        #false)))

; Attribute -> Boolean
; does this attr have str associated to the symbol?
(define (correct-a? attr str)
  (equal? str (second attr)))


(check-expect (get-content (read-xexpr "tsla.html") "price") "235.63")
(check-error (get-content (read-xexpr "tsla.html") "blegh"))

;; -----------------------------------------------------------------------------