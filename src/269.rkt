;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 269ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 269
;; ------------
;; Define eliminate-expensive. The function consumes a number, ua, and a list of
;; inventory records, and it produces a list of all those structures whose sales
;; price is below ua.
;;
;; Then use filter to define recall, which consumes the name of an inventory
;; item, called ty, and a list of inventory records and which produces a list of
;; inventory records that do not use the name ty.
;;
;; In addition, define selection, which consumes two lists of names and selects
;; all those from the second one that are also on the first.
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

(define all-irs (list ir-ex-1 ir-ex-2 ir-ex-3 ir-ex-4))

; [List-of IR] Number -> [List-of IR]
; all irs in lo-ir whose prices are below ua

(check-expect (eliminate-expensive '() 110) '())
(check-expect (eliminate-expensive all-irs 120) (list ir-ex-1 ir-ex-2 ir-ex-3))
(check-expect (eliminate-expensive all-irs 110) (list ir-ex-1))
(check-expect (eliminate-expensive all-irs 201) all-irs)

(define (eliminate-expensive lo-ir ua)
  (local (;; Number IR -> Boolean
          ;; is the sales price of an-ir less than ua?
          (define (price<ua? an-ir)
            (< (ir-sales-price an-ir) ua)))
    (filter price<ua? lo-ir)))
  

; [List-of IR] String -> [List-of IR]
; all irs in lo-ir whose names are not ty

(check-expect (recall all-irs "Mid") (list ir-ex-1 ir-ex-4))
(check-expect (recall all-irs "Largest") (list ir-ex-1 ir-ex-2 ir-ex-3))

(define (recall lo-ir ty)
  (local (; IR -> Boolean
          ; does ir not have the same name as ty?
          (define (not-same-name? ir)
            (not (string=? (ir-name ir) ty))))
    (filter not-same-name? lo-ir)))



; [List-of String] [List-of String] -> [List-of String]
; all strings in l2 that are also in l1

(check-expect (selection '() '()) '())
(check-expect (selection '("1") '()) '())
(check-expect (selection '() '("1")) '())
(check-expect (selection '("1") '("1")) '("1"))
(check-expect (selection '("2" "1" "3" "6") '("1" "4" "2" "6")) '("1" "2"  "6"))
(check-expect (selection '("2" "2" "3" "3") '("2" "3" "3" "3")) '("2" "3" "3" "3"))

(define (selection l1 l2)
  (local (; String -> Boolean
          ; is el-l2 a member of l1?
          (define (member-l1? el-l2)
            (member? el-l2 l1)))
    (filter member-l1? l2)))