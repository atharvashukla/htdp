;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 298ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 298
;; ------------
;; Design my-animate. Recall that the animate function consumes the
;; representation of a stream of images, one per natural number. Since streams
;; are infinitely long, ordinary compound data cannot represent them. Instead,
;; we use functions:
;; -----------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)

; An ImageStream is a function: 
;   [N -> Image]
; interpretation a stream s denotes a series of images

(define rocket (bitmap "rocket.png"))

; ImageStream
(define (create-rocket-scene height)
  (place-image rocket 50 height (empty-scene 60 60)))

(define-struct ws (s n c))
; WS is a struct
;   (make-struct ImageStream Number Number)
; interpretation. s is the stream, n is the total
; number of images and c is the current image #

; ImageStream Number -> Number
; animates the image on the numbers 0, 1, ... n
; the end result of my-animate is the # of clock ticks
(define (my-animate s n)
  (local (; WS -> Boolean
          ; is it time to end it?
          (define (same-as-n? ws)
            (= ws n))
          
          ; WS -> Image
          ; display the ws
          (define (render ws)
            (s ws))
          
          ; WS -> WS
          ; the next ws
          (define (tock ws)
            (+ ws 1)))
    (big-bang 0 ; the 0th image
      [on-tick   tock 1/30]
      [stop-when same-as-n?]
      [to-draw   render])))

(my-animate create-rocket-scene 60)