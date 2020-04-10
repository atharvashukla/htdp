;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 384ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 384
;; ------------
;; Figure 133 mentions read-xexpr/web. See figure 132 for its signature and
;; purpose statement and then read its documentation to determine the difference
;; to its “plain” relative.
;;
;; Figure 133 is also missing several important pieces, in particular the
;; interpretation of data and purpose statements for all the locally defined
;; functions. Formulate the missing pieces so that you get to understand the
;; program.
;; -----------------------------------------------------------------------------


; - read-xexpr/web includes whitespace, tabs, newlines
; - read-plain-xexpr/web ignores whitespace

; but both interpret the HTML as XML or return #f if url 404s

(require 2htdp/image)
(require 2htdp/universe)
(require 2htdp/batch-io)

(define PREFIX "https://www.google.com/finance?q=")
(define SIZE 22) ; font size 
 
(define-struct data [price delta])
; A StockWorld is a structure: (make-data String String)
; interpretation, the price and the change
; for the stock of a company
 
; String -> StockWorld
; retrieves the stock price of co and its change every 15s
(define (stock-alert co)
  (local ((define url (string-append PREFIX co))
          ; [StockWorld -> StockWorld]
          ; accesses the web to extract stock details for co
          (define (retrieve-stock-data __w)
            (local ((define x (read-xexpr/web url)))
              (make-data (get x "price")
                         (get x "priceChange"))))
          ; StockWorld -> Image
          ; renders the stock data as stock and diff numbers
          (define (render-stock-data w)
            (local (; [StockWorld -> String] -> Image
                    (define (word sel col)
                      (text (sel w) SIZE col)))
              (overlay (beside (word data-price 'black)
                               (text "  " SIZE 'white)
                               (word data-delta 'red))
                       (rectangle 300 35 'solid 'white)))))
    (big-bang (retrieve-stock-data 'no-use)
      [on-tick retrieve-stock-data 15]
      [to-draw render-stock-data])))
