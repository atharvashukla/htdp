;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 90ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 90.
;; ------------
;; Modify the happy-cat program from the preceding exercises so that it stops
;; whenever the cat’s happiness falls to 0.
;; -----------------------------------------------------------------------------

(define-struct vcat [x happiness])
; VCat is a struct
;   (make-vcat Number [0, 100])
; interp. x is the x-coordinate
; happiness is the % happiness


(require 2htdp/image)
(require 2htdp/universe)

; Cat constants ->

; physical constants
(define SCENE-WIDTH 300)
(define SCENE-HEIGHT 200)
(define BACKGROUND (empty-scene SCENE-WIDTH SCENE-HEIGHT))

(define CAT1 (bitmap "cat1.png"))
(define CAT2 (bitmap "cat2.png"))

(define CAT-HEIGHT (image-height CAT1))
(define CAT-WIDTH (image-width CAT1))
(define CAT-CENTER-Y-POS (/ CAT-HEIGHT 2))

; y-coordinate of the proper place of the cat on the scene
; sub1 to not cover the empty-scene edge line by the image
(define Y-POS (sub1 (- SCENE-HEIGHT CAT-CENTER-Y-POS)))

; Gauge constants ->

(define BAR-HEIGHT 5)
(define BAR-WIDTH 100) ;; max has to be 100 (the bar width)
(define BAR (empty-scene BAR-WIDTH BAR-HEIGHT))

(define on-tenth (* 1/10 BAR-WIDTH))
(define one-fifth (* 1/5 BAR-WIDTH))
(define one-third (* 1/3 BAR-WIDTH))

; ---------------------------------------------------------

;; WorldState -> Image
;; combines cat and gauge to render vc

(check-expect (render-vc (make-vcat 50 30))
              (overlay/align "right" "top"
                             (render-gauge 30)
                             (render-cat 50)))

(define (render-vc vc)
  (overlay/align "right" "top"
                 (render-gauge (vcat-happiness vc))
                 (render-cat (vcat-x vc))))

;; Number -> Image
;; renders the image of the cat according to x coordinate

(check-expect (render-cat 7) (place-image CAT2 7 Y-POS BACKGROUND))
(check-expect (render-cat 40) (place-image CAT1 40 Y-POS BACKGROUND))

(define (render-cat x)
  (if (odd? x)
      (place-image CAT2 x Y-POS BACKGROUND)
      (place-image CAT1 x Y-POS BACKGROUND)))


;; WorldState -> Image
;; renders the bar according to current level of happiness

(check-expect (render-gauge 30) (overlay/align "left" "middle" (rectangle 30 BAR-HEIGHT "solid" "red") BAR))
(check-expect (render-gauge 300) (overlay/align "left" "middle" (rectangle 300 BAR-HEIGHT "solid" "red") BAR))

(define (render-gauge happiness)
  (overlay/align "left" "middle" (rectangle happiness BAR-HEIGHT "solid" "red") BAR))


;; WorldState -> WorldState
;; adds 3 to the x-coordinate and decreases happiness
;; by 1/10 per clock tick

(check-expect (tock (make-vcat 30 90)) (make-vcat 33 89.9))

(define (tock ws)
  (make-vcat (tock-cat (vcat-x ws)) (tock-gauge (vcat-happiness ws))))


;; Number -> WorldState
;; adds 3 to the x coordinate

(check-expect (tock-cat 10) 13)
(check-expect (tock-cat 0) 3)
(check-expect (tock-cat 300) 0)

(define (tock-cat x)
  (if (>= x SCENE-WIDTH)
      (modulo x SCENE-WIDTH)
      (+ 3 x)))

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
; increases happiness by 1/5 for "down" and 1/3 for "up"

(check-expect (keystroke-handler (make-vcat 35 100) "down") (make-vcat 35 120))
(check-expect (keystroke-handler (make-vcat 35 14) "up") (make-vcat 35 (+ 14 (/ 100 3))))
(check-expect (keystroke-handler (make-vcat 35 10) "q") (make-vcat 35 10))

(define (keystroke-handler vc ke)
  (cond
    [(key=? ke "down") (make-vcat (vcat-x vc) (+ (vcat-happiness vc) one-fifth))]
    [(key=? ke "up")   (make-vcat (vcat-x vc) (+ (vcat-happiness vc) one-third))]
    [else vc]))

;; WorldState -> Boolean
;; is the happiness of the cat 0?

(check-expect (zero-happiness? (make-vcat 30 0)) #true)
(check-expect (zero-happiness? (make-vcat 30 30)) #false)

(define (zero-happiness? vc)
  (zero? (vcat-happiness vc)))

(define START-VCAT (make-vcat 10 50))

(define (happy-cat start-vcat)
  (big-bang start-vcat
    [on-tick tock]
    [to-draw render-vc]
    [on-key keystroke-handler]
    [stop-when zero-happiness?]))

#;
(happy-cat START-VCAT)