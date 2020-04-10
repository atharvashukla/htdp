;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 385ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 385
;; ------------
;; Look up the current stock price for your favorite company at Google’s
;; financial service page. If you don’t favor a company, pick Ford. Then save
;; the source code of the page as a file in your working directory. Us
;; read-xexpr in DrRacket to view the source as an Xexpr.v3.
;; -----------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)
(require 2htdp/batch-io)


; (second (first (second (list-ref (third (read-xexpr/web "https://www.marketwatch.com/investing/stock/aapl")) 82))))

#;; takes a while to print
(read-xexpr "tsla.html")