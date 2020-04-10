;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 93ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 93.
;; ------------
;; Copy your solution to exercise 92 and modify the copy so that the chameleon
;; walks across a tricolor background. Our solution uses these colors:
;;
;;    (define BACKGROUND
;;      (beside (empty-scene WIDTH HEIGHT "green")
;;              (empty-scene WIDTH HEIGHT "white")
;;              (empty-scene WIDTH HEIGHT "red")))
;;
;; but you may use any colors. Observe how the chameleon changes colors to blend
;; in as it crosses the border between two colors.
;;
;; Note When you watch the animation carefully, you see the chameleon riding on
;; a white rectangle. If you know how to use image editing software, modify the
;; picture so that the white rectangle is invisible. Then the chameleon will
;; really blend in. 
;; -----------------------------------------------------------------------------


(require 2htdp/image)
(require 2htdp/universe)

;; cham pic (faces down)
(define CHAM-IMG (flip-vertical (bitmap "chameleon-cropped.png")))

;; cham images facing right and left
(define CHAM-IMG-RIGHT (rotate -90 CHAM-IMG))
(define CHAM-IMG-LEFT  (rotate 90 CHAM-IMG))

;; dimensions of the scene
(define SCENE-WIDTH  800)
(define SCENE-HEIGHT 500)

;; miday through height and width of scene
(define SCENE-MID-HEIGHT (/ SCENE-HEIGHT 2))
(define SCENE-MID-WIDTH  (/ SCENE-WIDTH 2))

;; the background
(define BACKG
  (beside (empty-scene (/ SCENE-WIDTH 3) SCENE-HEIGHT "red")
          (empty-scene (/ SCENE-WIDTH 3) SCENE-HEIGHT "green")
          (empty-scene (/ SCENE-WIDTH 3) SCENE-HEIGHT "white")))

;; measurements of the cham
(define CHAM-LENGTH (image-height CHAM-IMG))
(define CHAM-GIRTH  (image-width CHAM-IMG))
(define CHAM-CENTRE (/ CHAM-LENGTH 2))

;; end-points for the cham to turn
(define START-BOUND CHAM-CENTRE)
(define END-BOUND   (- SCENE-WIDTH CHAM-CENTRE))

;; Y position of our cham
(define Y (sub1 (- SCENE-HEIGHT (/ CHAM-GIRTH 2))))

;; --------------------------------------------------

; Color [String] is one of
; - "red"
; - "blue"
; - "green"

(define cham-img-right-red
  (overlay CHAM-IMG-RIGHT (rectangle CHAM-LENGTH CHAM-GIRTH "solid" "red")))

(define cham-img-left-green
  (overlay CHAM-IMG-LEFT (rectangle CHAM-LENGTH CHAM-GIRTH "solid" "green")))

;; Image Color -> Image
;; adds `color` to `cham` image
(define (add-color-to-cham cham color)
  (overlay cham (rectangle CHAM-LENGTH CHAM-GIRTH "solid" color)))

(check-expect (add-color-to-cham CHAM-IMG-RIGHT "red")  cham-img-right-red)
(check-expect (add-color-to-cham CHAM-IMG-LEFT "green") cham-img-left-green)

; Dir is one of
; - "left"
; - "right"

(define-struct vcham [x happiness dir color])
; vcham is a struct
;   (make-vcham Number [0, 100] Dir)
; interp. x is the x-coordinate
; happiness is the % happiness
; dir is the direction of the cham
; color is the color of the cham


; Gauge constants ->

(define BAR-HEIGHT 5)
(define BAR-WIDTH 100) ;; max has to be 100 (the bar width)
(define BAR (empty-scene BAR-WIDTH BAR-HEIGHT))

(define on-tenth (* 1/10 BAR-WIDTH))
(define one-fifth (* 1/5 BAR-WIDTH))
(define one-third (* 1/3 BAR-WIDTH))



; ---------------------------------------------------------

;; WorldState -> Image
;; combines cham and gauge to render vc

(check-expect (render-vc (make-vcham 50 30 "left" "red"))
              (overlay/align "right" "top"
                             (render-gauge 30)
                             (render-cham (make-vcham 50 30 "left" "red"))))

(define (render-vc vc)
  (overlay/align "right" "top"
                 (render-gauge (vcham-happiness vc))
                 (render-cham vc)))


;; VCham -> Image
;; renders the image of the cham according to x coordinate

(define (render-cham vc)
  (place-image (orient-a-cham vc) (vcham-x vc) Y BACKG))


;; VCham -> Image
;; gives a cham in

(check-expect (orient-a-cham (make-vcham 30 30 "right" "red"))
              CHAM-IMG-RIGHT)

(check-expect (orient-a-cham (make-vcham 30 30 "left" "red"))
              CHAM-IMG-LEFT)

(define (orient-a-cham vc)
  (cond [(string=? (vcham-dir vc) "right") CHAM-IMG-RIGHT]
        [(string=? (vcham-dir vc) "left") CHAM-IMG-LEFT]))


;; WorldState -> Image
;; renders the bar according to current level of happiness

(check-expect (render-gauge 30) (overlay/align "left" "middle" (rectangle 30 BAR-HEIGHT "solid" "red") BAR))
(check-expect (render-gauge 300) (overlay/align "left" "middle" (rectangle 300 BAR-HEIGHT "solid" "red") BAR))

(define (render-gauge happiness)
  (overlay/align "left" "middle" (rectangle happiness BAR-HEIGHT "solid" "red") BAR))



;; WorldState -> WorldState
;; adds 3 to the x-coordinate and decreases happiness
;; by 1/10 per clock tick

(check-expect (tock (make-vcham 30 90 "left" "red")) (make-vcham 27 89.9 "left" "red"))
(check-expect (tock (make-vcham 30 90 "right" "red")) (make-vcham 33 89.9 "right" "red"))

(define (tock ws)
  (tock-cham (make-vcham (vcham-x ws) (tock-gauge (vcham-happiness ws)) (vcham-dir ws) (vcham-color ws))))



;; WorldState -> WorldState
;; adds 3 to the x coordinate

(check-expect (tock-cham (make-vcham 30 30 "left" "red")) (make-vcham 27 30 "left" "red"))
(check-expect (tock-cham (make-vcham 30 30 "right" "red")) (make-vcham 33 30 "right" "red"))

(check-expect (tock-cham (make-vcham SCENE-WIDTH 30 "right" "red")) (make-vcham 0 30 "right" "red"))
(check-expect (tock-cham (make-vcham 0 30 "left" "red")) (make-vcham (- SCENE-WIDTH 3) 30 "left" "red"))

(define (tock-cham vc)
  (cond [(and (string=? (vcham-dir vc) "right") (>= (vcham-x vc) SCENE-WIDTH))
         (make-vcham 0 (vcham-happiness vc) "right" (vcham-color vc))]
        [(and (string=? (vcham-dir vc) "left") (<= (vcham-x vc) 0))
         (make-vcham (- SCENE-WIDTH 3) (vcham-happiness vc) "left" (vcham-color vc))]
        [(string=? (vcham-dir vc) "left")
         (make-vcham (- (vcham-x vc) 3) (vcham-happiness vc) (vcham-dir vc) (vcham-color vc))]
        [(string=? (vcham-dir vc) "right")
         (make-vcham (+ (vcham-x vc) 3) (vcham-happiness vc) (vcham-dir vc) (vcham-color vc))]))

;; Number -> WorldState
;; decreases happiness by 1/10 per clock tick
(check-expect (tock-gauge 101) 100)
(check-expect (tock-gauge 90) 89.9)
(check-expect (tock-gauge -0.1) 0)

(define (tock-gauge happiness)
  (cond [(<= happiness 0) 0]
        [(> happiness BAR-WIDTH) BAR-WIDTH]
        [else (- happiness 0.1)]))



; WorldState String -> WorldState 
; increases happiness by 1/5 for "down" (NO 1/3 for "up")

(check-expect (keystroke-handler (make-vcham 35 100 "left" "red") "down") (make-vcham 35 120 "left" "red"))
(check-expect (keystroke-handler (make-vcham 35 14 "left" "red") "up") (make-vcham 35 14 "left" "red"))
(check-expect (keystroke-handler (make-vcham 35 10 "left" "red") "q") (make-vcham 35 10 "left" "red"))

(check-expect (keystroke-handler (make-vcham 35 10 "left" "red") "r") (make-vcham 35 10 "left" "red"))
(check-expect (keystroke-handler (make-vcham 35 10 "left" "red") "g") (make-vcham 35 10 "left" "green"))
(check-expect (keystroke-handler (make-vcham 35 10 "left" "red") "b") (make-vcham 35 10 "left" "blue"))
(check-expect (keystroke-handler (make-vcham 35 10 "left" "red") "left") (make-vcham 35 10 "left" "red"))
(check-expect (keystroke-handler (make-vcham 35 10 "left" "red") "right") (make-vcham 35 10 "right" "red"))

(define (keystroke-handler vc ke)
  (cond
    [(key=? ke "down") (make-vcham (vcham-x vc) (+ (vcham-happiness vc) one-fifth) (vcham-dir vc) (vcham-color vc))]
    [(key=? ke "r") (make-vcham (vcham-x vc) (vcham-happiness vc) (vcham-dir vc) "red")]
    [(key=? ke "g") (make-vcham (vcham-x vc) (vcham-happiness vc) (vcham-dir vc) "green")]
    [(key=? ke "b") (make-vcham (vcham-x vc) (vcham-happiness vc) (vcham-dir vc) "blue")]
    [(key=? ke "left")  (make-vcham (vcham-x vc) (vcham-happiness vc) "left" (vcham-color vc))]
    [(key=? ke "right") (make-vcham (vcham-x vc) (vcham-happiness vc) "right" (vcham-color vc))]
    [else vc]))

;; WorldState -> Boolean
;; is the happiness of the cham 0?
(check-expect (zero-happiness? (make-vcham 30 0 "left" "red")) #true)
(check-expect (zero-happiness? (make-vcham 30 30 "left" "red")) #false)

(define (zero-happiness? vc)
  (zero? (vcham-happiness vc)))

(define INIT-VCHAM1 (make-vcham 10 50 "right" "red"))
(define INIT-VCHAM2 (make-vcham 10 50 "left" "red"))


(define (cham init-ws)
  (big-bang init-ws
    [on-tick tock]
    [to-draw render-vc]
    [on-key keystroke-handler]
    [stop-when zero-happiness?]))

#;
(cham INIT-VCHAM2)
