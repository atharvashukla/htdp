;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 108ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 108.
;; -------------
;; In its default state, a pedestrian crossing light shows an orange person
;; standing on a red background. When it is time to allow the pedestrian to
;; cross the street, the light receives a signal and switches to a green,
;; walking person. This phase lasts for 10 seconds. After that the light
;; displays the digits 9, 8, ..., 0 with odd numbers colored orange and even
;; numbers colored green. When the countdown reaches 0, the light switches back
;; to its default state.
;;
;; Design a world program that implements such a pedestrian traffic light. The
;; light switches from its default state when you press the space bar on your
;; keyboard. All other transitions must be reactions to clock ticks. You may
;; wish to use the following images
;;
;; <pedestrian_traffic_light_red.png> <pedestrian_traffic_light_green.png>
;;
;; or you can make up your own stick figures with the image library. 
;; -----------------------------------------------------------------------------


(require 2htdp/image)
(require 2htdp/universe)

; --- data definitions ---

(define-struct tl [state time])
;; TrafficLight is a (make-tl String Number)
;;  state is the State of the TrafficLight
;;  time is the Time limit for the state

;; State is a String
;; - "Wait"
;; - "Walk"
;; - "Countdown"

;; Time is one of
;; - Number
;; - #false
;; interpretation. the number represents the amount of
;; time left. #false is indefinite time until a key press.

; --- constants ---

(define STAND-IMG (bitmap "pedestrian_traffic_light_red.png"))
(define WALK-IMG (bitmap "pedestrian_traffic_light_green.png"))

(define ODD-NO-COLOR "orange")
(define EVEN-NO-COLOR "green")

(define WALK-TIME 10)
(define COUNTDOWN-TIME 9)

(define BACKG-CD
  (rectangle (image-width (overlay STAND-IMG STAND-IMG))
             (image-height (overlay STAND-IMG WALK-IMG))
             ; dims are the max of both images' dims
             "solid"
             "black"))

(define CD-FONT-SIZE 42)

; --- render ---

;; TrafficLight -> Image
;; renders the image of the traffic light
(check-expect (render-tl (make-tl "Countdown" 9)) (render-text 9))
(check-expect (render-tl (make-tl "Countdown" 8)) (render-text 8))
(check-expect (render-tl (make-tl "Walk" 5)) WALK-IMG)
(check-expect (render-tl (make-tl "Wait" #false)) STAND-IMG)

(define (render-tl t)
  (cond
    [(equal? (tl-state t) "Wait") STAND-IMG]
    [(equal? (tl-state t) "Walk") WALK-IMG]
    [(equal? (tl-state t) "Countdown") (render-text (tl-time t))]))


;; Number -> Image
;; renders the count-down with the correct color for even/odd

(check-expect (render-text 9) (overlay (text "9" CD-FONT-SIZE ODD-NO-COLOR) BACKG-CD))
(check-expect (render-text 8) (overlay (text "8" CD-FONT-SIZE EVEN-NO-COLOR) BACKG-CD))

(define (render-text n)
  (overlay (text (number->string n) CD-FONT-SIZE (which-color? n))
           BACKG-CD))

;; Number -> String
;; decides the color based on even/odd number

(check-expect (which-color? 9) ODD-NO-COLOR)
(check-expect (which-color? 8) EVEN-NO-COLOR)
(check-expect (which-color? 1) ODD-NO-COLOR)
(check-expect (which-color? 0) EVEN-NO-COLOR)

(define (which-color? n)
  (cond
    [(even? n) EVEN-NO-COLOR]
    [(odd? n) ODD-NO-COLOR]))

; --- key handler ---

;; TrafficLight KeyEvent -> TrafficLight
;; starts the walking position
;; if space is pressed during default position

(check-expect (key-handler (make-tl "Wait" #false) " ") (make-tl "Walk" WALK-TIME))
(check-expect (key-handler (make-tl "Walk" 3) " ") (make-tl "Walk" 3))
(check-expect (key-handler (make-tl "Countdown" 1) " ") (make-tl "Countdown" 1))

(check-expect (key-handler (make-tl "Wait" #false) "q") (make-tl "Wait" #false))
(check-expect (key-handler (make-tl "Walk" 3) "left") (make-tl "Walk" 3))
(check-expect (key-handler (make-tl "Countdown" 1) "r") (make-tl "Countdown" 1))

(define (key-handler t ke)
  (cond
    [(and (string=? ke " ") (equal? (tl-state t) "Wait")) (make-tl "Walk" WALK-TIME)]
    [else t]))

; --- tock ---

;; TrafficLight -> TrafficLight
;; transitions to the next state per clock tick

(check-expect (tock (make-tl "Wait" #false)) (make-tl "Wait" #false))
(check-expect (tock (make-tl "Walk" 9)) (tock-walk (make-tl "Walk" 9)))
(check-expect (tock (make-tl "Walk" 0)) (tock-walk (make-tl "Walk" 0)))
(check-expect (tock (make-tl "Countdown" 5)) (tock-countdown (make-tl "Countdown" 5)))
(check-expect (tock (make-tl "Countdown" 0)) (tock-countdown (make-tl "Countdown" 0)))

(define (tock t)
  (cond
    [(equal? (tl-state t) "Wait") t]
    [(equal? (tl-state t) "Walk") (tock-walk t)]
    [(equal? (tl-state t) "Countdown") (tock-countdown t)]))

;; TrafficLight -> TrafficLight
;; next state for walk

(check-expect (tock-walk (make-tl "Walk" 9)) (make-tl "Walk" 8))
(check-expect (tock-walk (make-tl "Walk" 0)) (make-tl "Countdown" COUNTDOWN-TIME))

(define (tock-walk t)
  (cond
    [(= 0 (tl-time t)) (make-tl "Countdown" COUNTDOWN-TIME)]
    [else (make-tl "Walk" (sub1 (tl-time t)))]))

;; TrafficLight -> TrafficLight
;; next state for countdown

(check-expect (tock-countdown (make-tl "Countdown" 5)) (make-tl "Countdown" 4))
(check-expect (tock-countdown (make-tl "Countdown" 0)) (make-tl "Wait" #false))

(define (tock-countdown t)
  (cond
    [(= 0 (tl-time t)) (make-tl "Wait" #false)]
    [else (make-tl "Countdown" (sub1 (tl-time t)))]))

; --- big bang ---

; TrafficLight -> TrafficLight
; starts the traffic light program with an initial state
(define (main s)
  (big-bang s
    [on-tick tock 0.5]
    [on-key key-handler]
    [to-draw render-tl]))

; (main (make-tl "Wait" #false))


