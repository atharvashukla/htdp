;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 106ex-virtual-pets) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 106.
;; -------------
;; 106. In More Virtual Pets we discussed the creation of virtual pets that come
;; with happiness gauges. One of the virtual pets is a cat; the other one, a
;; chameleon. Each program is dedicated to a single pet, however.
;; 
;; Design the cat-cham world program. Given both a location and an animal, it
;; walks the latter across the canvas, starting from the given location. Here is
;; the chosen data representation for animals:
;; 
;;    ; A VAnimal is either
;;    ; – a VCat
;;    ; – a VCham
;;
;; where VCat and VCham are your data definitions from exercises 88 and 92.
;; 
;; Given that VAnimal is the collection of world states, you need to design
;;
;; - a rendering function from VAnimal to Image;
;;
;; - a function for handling clock ticks, from VAnimal to VAnimal; and
;;
;; - a function for dealing with key events so that you can feed and pet and
;;   colorize your animal—as applicable.
;;
;; It remains impossible to change the color of a cat or to pet a chameleon. 
;; -----------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)

(require "provide.rkt")
(provide animal-tock animal-render animal-keystroke-handler animal-zero-happiness?)

; ----- data definitions -----

; Dir is one of
; - "left"
; - "right"

(define-struct vcat [x happiness dir])
; VCat is a struct
;   (make-vcat Number [0, 100] Dir)
; interp. x is the x-coordinate
; happiness is the % happiness
; dir is the direction of the cat

; Color [String] is one of
; - "red"
; - "blue"
; - "green"

(define-struct vcham [x happiness dir color])
; vcham is a struct
;   (make-vcham Number [0, 100] Dir)
; interp. x is the x-coordinate
; happiness is the % happiness
; dir is the direction of the cham
; color is the color of the cham

; VAnimal is one of:
; - VCham
; - VCat

; ----- constants -----

; CAT constants ->

; physical constants
(define SCENE-WIDTH 800)
(define SCENE-HEIGHT 500)
(define BACKGROUND (empty-scene SCENE-WIDTH SCENE-HEIGHT))

(define SCENE-MID-HEIGHT (/ SCENE-HEIGHT 2))
(define SCENE-MID-WIDTH  (/ SCENE-WIDTH 2))

(define CAT1 (bitmap "cat1.png"))
(define CAT2 (bitmap "cat2.png"))

(define CAT-HEIGHT (image-height CAT1))
(define CAT-WIDTH (image-width CAT1))
(define CAT-CENTER-Y-POS (/ CAT-HEIGHT 2))

; y-coordinate of the proper place of the cat on the scene
; sub1 to not cover the empty-scene edge line by the image
(define Y-POS (sub1 (- SCENE-HEIGHT CAT-CENTER-Y-POS)))

; Cat Gauge constants ->

(define BAR-HEIGHT 5)
(define BAR-WIDTH 100) ;; max has to be 100 (the bar width)
(define BAR (empty-scene BAR-WIDTH BAR-HEIGHT))

(define on-tenth (* 1/10 BAR-WIDTH))
(define one-fifth (* 1/5 BAR-WIDTH))
(define one-third (* 1/3 BAR-WIDTH))

;; CHAM  constants -> 

;; cham pic (faces down)
(define CHAM-IMG (flip-vertical (bitmap "chameleon.png")))

;; cham images facing right and left
(define CHAM-IMG-RIGHT (rotate -90 CHAM-IMG))
(define CHAM-IMG-LEFT  (rotate 90 CHAM-IMG))

;; measurements of the cham
(define CHAM-LENGTH (image-height CHAM-IMG))
(define CHAM-GIRTH  (image-width CHAM-IMG))
(define CHAM-CENTRE (/ CHAM-LENGTH 2))

;; end-points for the cham to turn
(define START-BOUND CHAM-CENTRE)
(define END-BOUND   (- SCENE-WIDTH CHAM-CENTRE))

;; Y position of our cham
(define Y (sub1 (- SCENE-HEIGHT (/ CHAM-GIRTH 2))))

; ----- rendering functions -----

; VAnimal -> Image
; renders the image with a cat or a cham
(define (animal-render va)
  (cond
    [(vcat? va) (render-vcat va)]
    [(vcham? va) (render-vcham va)]))

;; WorldState -> Image
;; renders the bar according to current level of happiness
(define (render-gauge happiness)
  (overlay/align "left" "middle" (rectangle happiness BAR-HEIGHT "solid" "red") BAR))

;; WorldState -> Image
;; combines cat and gauge to render vc
(define (render-vcat vc)
  (overlay/align "right" "top"
                 (render-gauge (vcat-happiness vc))
                 (render-cat-step (vcat-x vc))))

;; Number -> Image
;; renders the image of the cat according to x coordinate
(define (render-cat-step x)
  (if (odd? x)
      (place-image CAT2 x Y-POS BACKGROUND)
      (place-image CAT1 x Y-POS BACKGROUND)))


;; WorldState -> Image
;; combines cham and gauge to render vc
(define (render-vcham vc)
  (overlay/align "right" "top"
                 (render-gauge (vcham-happiness vc))
                 (render-cham vc)))

;; VCham -> Image
;; renders the image of the cham according to x coordinate
(define (render-cham vc)
  (place-image (orient-and-color-cham vc) (vcham-x vc) Y BACKGROUND))

;; VCham -> Image
;; orients then colors the cham
(define (orient-and-color-cham vc)
  (overlay (orient-a-cham vc) (rectangle CHAM-LENGTH CHAM-GIRTH "solid" (vcham-color vc))))

;; VCham -> Image
;; gives a cham in
(define (orient-a-cham vc)
  (cond [(string=? (vcham-dir vc) "right") CHAM-IMG-RIGHT]
        [(string=? (vcham-dir vc) "left") CHAM-IMG-LEFT]))



;; Image Color -> Image
;; adds `color` to `cham` image
(define (add-color-to-cham cham color)
  (overlay cham (rectangle CHAM-LENGTH CHAM-GIRTH "solid" color)))

; ----- tick handlers -----

; VAnimal -> VAnimal
; adds 3 to the x-coordinate and decreases happiness
; by 1/10 per clock tick
(define (animal-tock va)
  (cond
    [(vcat? va)
     (tock-cat (make-vcat (vcat-x va) (tock-gauge (vcat-happiness va)) (vcat-dir va)))]
    [(vcham? va)
     (tock-cham (make-vcham (vcham-x va) (tock-gauge (vcham-happiness va)) (vcham-dir va) (vcham-color va)))]))


;; WorldState -> WorldState
;; adds 3 to the x coordinate
(define (tock-cat vc)
  (cond [(and (string=? (vcat-dir vc) "right") (>= (vcat-x vc) SCENE-WIDTH))
         (make-vcat (- SCENE-WIDTH 3) (vcat-happiness vc) "left")]
        [(and (string=? (vcat-dir vc) "left") (<= (vcat-x vc) 0))
         (make-vcat 3 (vcat-happiness vc) "right")]
        [(string=? (vcat-dir vc) "left")
         (make-vcat (- (vcat-x vc) 3) (vcat-happiness vc) (vcat-dir vc))]
        [(string=? (vcat-dir vc) "right")
         (make-vcat (+ (vcat-x vc) 3) (vcat-happiness vc) (vcat-dir vc))]))


;; WorldState -> WorldState
;; adds 3 to the x coordinate
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
(define (tock-gauge happiness)
  (cond [(<= happiness 0) 0]
        [(> happiness BAR-WIDTH) BAR-WIDTH]
        [else (- happiness 0.1)]))


; ----- keystroke handler -----

; VAnimal KeyEvent -> VAnimal
; pets the cat, and feeds, moves, or changes the color of the cham
(define (animal-keystroke-handler va ke)
  (cond
    [(vcat? va) (cat-keystroke-handler va ke)]
    [(vcham? va) (cham-keystroke-handler va ke)]))


; WorldState String -> WorldState 
; increases happiness by 1/5 for "down" and 1/3 for "up"
(define (cat-keystroke-handler vc ke)
  (cond
    [(key=? ke "down") (make-vcat (vcat-x vc) (+ (vcat-happiness vc) one-fifth) (vcat-dir vc))]
    [(key=? ke "up")   (make-vcat (vcat-x vc) (+ (vcat-happiness vc) one-third) (vcat-dir vc))]
    [else vc]))

; WorldState String -> WorldState 
; increases happiness by 1/5 for "down" (NO 1/3 for "up")
(define (cham-keystroke-handler vc ke)
  (cond
    [(key=? ke "down") (make-vcham (vcham-x vc) (+ (vcham-happiness vc) one-fifth) (vcham-dir vc) (vcham-color vc))]
    [(key=? ke "r") (make-vcham (vcham-x vc) (vcham-happiness vc) (vcham-dir vc) "red")]
    [(key=? ke "g") (make-vcham (vcham-x vc) (vcham-happiness vc) (vcham-dir vc) "green")]
    [(key=? ke "b") (make-vcham (vcham-x vc) (vcham-happiness vc) (vcham-dir vc) "blue")]
    [(key=? ke "left")  (make-vcham (vcham-x vc) (vcham-happiness vc) "left" (vcham-color vc))]
    [(key=? ke "right") (make-vcham (vcham-x vc) (vcham-happiness vc) "right" (vcham-color vc))]
    [else vc]))

; ----- stop -----

;; VAnimal -> Boolean
;; is the happiness of the animal zero?
(define (animal-zero-happiness? vc)
  (cond
    [(vcat? vc) (zero? (vcat-happiness vc))]
    [(vcham? vc) (zero? (vcham-happiness vc))]))

;; -- big bang / main --

(define INIT-VCAT1 (make-vcat 10 50 "right"))
(define INIT-VCHAM1 (make-vcham 10 50 "right" "red"))
(define INIT-VCHAM2 (make-vcham 10 50 "left" "red"))

(define (animal-prog init-ws)
  (big-bang init-ws
    [on-tick animal-tock]
    [to-draw animal-render]
    [on-key animal-keystroke-handler]
    [stop-when animal-zero-happiness?]))

#;
(animal-prog INIT-VCHAM2)


;; tests
(check-expect (render-vcat (make-vcat 50 30 "left"))
              (overlay/align "right" "top"
                             (render-gauge 30)
                             (render-cat-step 50)))

(check-expect (render-cat-step 7) (place-image CAT2 7 Y-POS BACKGROUND))
(check-expect (render-cat-step 40) (place-image CAT1 40 Y-POS BACKGROUND))

(check-expect (render-gauge 30) (overlay/align "left" "middle" (rectangle 30 BAR-HEIGHT "solid" "red") BAR))
(check-expect (render-gauge 300) (overlay/align "left" "middle" (rectangle 300 BAR-HEIGHT "solid" "red") BAR))

(check-expect (animal-tock (make-vcat 30 90 "left")) (make-vcat 27 89.9 "left"))
(check-expect (animal-tock (make-vcat 30 90 "right")) (make-vcat 33 89.9 "right"))

(check-expect (tock-cat (make-vcat 30 30 "left")) (make-vcat 27 30 "left"))
(check-expect (tock-cat (make-vcat 30 30 "right")) (make-vcat 33 30 "right"))

(check-expect (tock-cat (make-vcat SCENE-WIDTH 30 "right")) (make-vcat (- SCENE-WIDTH 3) 30 "left"))
(check-expect (tock-cat (make-vcat 0 30 "left")) (make-vcat 3 30 "right"))

(check-expect (tock-gauge 101) 100)
(check-expect (tock-gauge 90) 89.9)
(check-expect (tock-gauge -0.1) 0)

(check-expect (animal-keystroke-handler (make-vcat 35 100 "left") "down") (make-vcat 35 120 "left"))
(check-expect (animal-keystroke-handler (make-vcat 35 14 "left") "up") (make-vcat 35 (+ 14 (/ 100 3)) "left"))
(check-expect (animal-keystroke-handler (make-vcat 35 10 "left") "q") (make-vcat 35 10 "left"))

(check-expect (animal-zero-happiness? (make-vcat 30 0 "left")) #true)
(check-expect (animal-zero-happiness? (make-vcat 30 30 "left")) #false)

(define cham-img-right-red
  (overlay CHAM-IMG-RIGHT (rectangle CHAM-LENGTH CHAM-GIRTH "solid" "red")))

(define cham-img-left-green
  (overlay CHAM-IMG-LEFT (rectangle CHAM-LENGTH CHAM-GIRTH "solid" "green")))

(check-expect (add-color-to-cham CHAM-IMG-RIGHT "red")  cham-img-right-red)
(check-expect (add-color-to-cham CHAM-IMG-LEFT "green") cham-img-left-green)

(check-expect (render-vcham (make-vcham 50 30 "left" "red"))
              (overlay/align "right" "top"
                             (render-gauge 30)
                             (render-cham (make-vcham 50 30 "left" "red"))))

(check-expect (orient-and-color-cham (make-vcham 30 30 "right" "red"))
              (overlay CHAM-IMG-RIGHT (rectangle CHAM-LENGTH CHAM-GIRTH "solid" "red")))

(check-expect (orient-and-color-cham (make-vcham 30 30 "right" "blue"))
              (overlay CHAM-IMG-RIGHT (rectangle  CHAM-LENGTH CHAM-GIRTH "solid" "blue")))

(check-expect (orient-and-color-cham (make-vcham 30 30 "right" "green"))
              (overlay CHAM-IMG-RIGHT (rectangle CHAM-LENGTH CHAM-GIRTH "solid" "green")))

(check-expect (orient-a-cham (make-vcham 30 30 "right" "red"))
              CHAM-IMG-RIGHT)

(check-expect (orient-a-cham (make-vcham 30 30 "left" "red"))
              CHAM-IMG-LEFT)

(check-expect (render-gauge 30) (overlay/align "left" "middle" (rectangle 30 BAR-HEIGHT "solid" "red") BAR))
(check-expect (render-gauge 300) (overlay/align "left" "middle" (rectangle 300 BAR-HEIGHT "solid" "red") BAR))

(check-expect (animal-tock (make-vcham 30 90 "left" "red")) (make-vcham 27 89.9 "left" "red"))
(check-expect (animal-tock (make-vcham 30 90 "right" "red")) (make-vcham 33 89.9 "right" "red"))

(check-expect (tock-cham (make-vcham 30 30 "left" "red")) (make-vcham 27 30 "left" "red"))
(check-expect (tock-cham (make-vcham 30 30 "right" "red")) (make-vcham 33 30 "right" "red"))

(check-expect (tock-cham (make-vcham SCENE-WIDTH 30 "right" "red")) (make-vcham 0 30 "right" "red"))
(check-expect (tock-cham (make-vcham 0 30 "left" "red")) (make-vcham (- SCENE-WIDTH 3) 30 "left" "red"))

(check-expect (animal-keystroke-handler (make-vcham 35 100 "left" "red") "down") (make-vcham 35 120 "left" "red"))
(check-expect (animal-keystroke-handler (make-vcham 35 14 "left" "red") "up") (make-vcham 35 14 "left" "red"))
(check-expect (animal-keystroke-handler (make-vcham 35 10 "left" "red") "q") (make-vcham 35 10 "left" "red"))

(check-expect (animal-keystroke-handler (make-vcham 35 10 "left" "red") "r") (make-vcham 35 10 "left" "red"))
(check-expect (animal-keystroke-handler (make-vcham 35 10 "left" "red") "g") (make-vcham 35 10 "left" "green"))
(check-expect (animal-keystroke-handler (make-vcham 35 10 "left" "red") "b") (make-vcham 35 10 "left" "blue"))
(check-expect (animal-keystroke-handler (make-vcham 35 10 "left" "red") "left") (make-vcham 35 10 "left" "red"))
(check-expect (animal-keystroke-handler (make-vcham 35 10 "left" "red") "right") (make-vcham 35 10 "right" "red"))

(check-expect (animal-zero-happiness? (make-vcham 30 0 "left" "red")) #true)
(check-expect (animal-zero-happiness? (make-vcham 30 30 "left" "red")) #false)