;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 286ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 286
;; ------------
;; An inventory record specifies the name of an inventory item, a description,
;; the acquisition price, and the recommended sales price.
;; 
;; Define a function that sorts a list of inventory records by the difference
;; between the two prices.
;; -----------------------------------------------------------------------------


(define-struct ir [name description acquisition-price sales-price])
; An Inentory Record [IR] is a structure
;   (makestruct String String Number Number)
; interpretation. The inventory record that stores the name, description,
; acquisition price and recommended sales price of an item,

(define ir-ex-1 (make-ir "Smallest" "box" 100 101))
(define ir-ex-2 (make-ir "Mid" "box in a box" 100 110))
(define ir-ex-3 (make-ir "Mid" "box in a box" 100 110))
(define ir-ex-4 (make-ir "Largest" "box in a box in a box" 100 200))

;; [List-of IR] -> [List-of IR]
;; sorts a lo-ir by the difference bw their two prices

(check-expect (sort-ir-diff '())
              '())
(check-expect (sort-ir-diff (list ir-ex-1))
              (list ir-ex-1))
(check-expect (sort-ir-diff (list ir-ex-2 ir-ex-1))
              (list ir-ex-1 ir-ex-2))
(check-expect (sort-ir-diff (list ir-ex-4 ir-ex-3 ir-ex-2 ir-ex-1))
              (list ir-ex-1 ir-ex-2 ir-ex-3 ir-ex-4))

(define (sort-ir-diff lo-ir)
  (local (;; IR -> Number
          ;; get the price difference of an-IR
          (define (price-diff ir)
            (- (ir-sales-price ir) (ir-acquisition-price ir))))
    (sort lo-ir (λ (l r) (<= (price-diff l) (price-diff r))))))

