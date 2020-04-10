;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 107ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 107.
;; -------------
;; Design the cham-and-cat program, which deals with both a virtual cat and a
;; virtual chameleon. You need a data definition for a “zoo” containing both
;; animals and functions for dealing with it.
;;
;; The problem statement leaves open how keys manipulate the two animals. Here
;; are two possible interpretations:
;;
;; 1. Each key event goes to both animals.
;;
;; 2. Each key event applies to only one of the two animals.
;; 
;;    For this alternative, you need a data representation that specifies a
;;    focus animal, that is, the animal that can currently be manipulated. To
;;    switch focus, have the key-handling function interpret "k" for “kitty” and
;;    "l" for lizard. Once a player hits "k", the following keystrokes apply to
;;    the cat only—until the player hits "l".
;;
;; Choose one of the alternatives and design the appropriate program. 
;; -----------------------------------------------------------------------------

; cham-and-cat program - interpretation 2
; I chose interpretation 2 because it gives more control.

(require 2htdp/image)
(require 2htdp/universe)

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

(define-struct cat-and-cham [cat cham cat-or-cham])
; A CatAndCham is a structure
;   (make-cat-and-cham VCat VCham CatOrCham])
; interpretation. A "zoo" of both cat and chameleon.
; keeps track of both animals.
; cat-or-cham decides which animal is currenctly selected. 

; CatOrCham is one of
; - "cat"
; - "cham"

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

;; --- big bang ---

; CatAndCham -> CatAndCham
; launches the program from some initial state
(define (main cac)
  (big-bang cac
    [on-tick   tock]
    [stop-when end?]
    [to-draw   render]
    [on-key    key-h]))

; --- on tick ---

; CatAndCham -> CatAndCham
; next state of the world
(define (tock cac)
  (make-cat-and-cham (animal-tock (cat-and-cham-cat cac))
                     (animal-tock (cat-and-cham-cham cac))
                     (cat-and-cham-cat-or-cham cac)))


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


; --- render ---

; CatAndCham -> Image
; rendering of the world state
(define (render cac)
  (animal-render (cat-and-cham-cat cac)
                 (animal-render (cat-and-cham-cham cac)
                                BACKGROUND
                                (cat-and-cham-cat-or-cham cac))
                 (cat-and-cham-cat-or-cham cac)))

; VAnimal Image -> Image
; renders the image with a cat or a cham
(define (animal-render va bkg current)
  (cond
    [(vcat? va) (render-vcat va bkg current)]
    [(vcham? va) (render-vcham va bkg current)]))

;; Number -> Image
;; renders the bar according to current level of happiness
(define (render-gauge happiness)
  (overlay/align "left" "middle" (rectangle happiness BAR-HEIGHT "solid" "red") BAR))

;; VCat Image -> Image
;; combines cat and gauge to render vc
(define (render-vcat vc bkg current)
  (overlay/align "right" "top"
                 (beside (render-gauge (vcat-happiness vc))
                         (render-text-cat current))
                 (render-cat-step (vcat-x vc) bkg)))

;; WorldState Image -> Image
;; combines cham and gauge to render vc
(define (render-vcham vc bkg current)
  (overlay/align "left" "top"
                 (beside (render-gauge (vcham-happiness vc))
                         (render-text-cham current))
                 (render-cham vc bkg)))

; String -> Image
; renders the cham text according to status
(define (render-text-cham current)
  (if (string=? current "cham")
      (text "lizzy" 12 "orange")
      (text "lizzy" 12 "black")))

; String -> Image
; renders the cat text according to status
(define (render-text-cat current)
  (if (string=? current "cat")
      (text "kitty" 12 "orange")
      (text "kitty" 12 "black")))

;; Number Image -> Image
;; renders the image of the cat according to x coordinate
(define (render-cat-step x bkg)
  (if (odd? x)
      (place-image CAT2 x Y-POS bkg)
      (place-image CAT1 x Y-POS bkg)))

;; VCham Image -> Image
;; renders the image of the cham according to x coordinate
(define (render-cham vc bkg)
  (place-image (orient-and-color-cham vc) (vcham-x vc) Y bkg))

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

; --- stop-when ---

; CatAndCham -> Boolean
; is the hapiness zero?
(define (end? cac)
  (or (animal-zero-happiness? (cat-and-cham-cat cac))
      (animal-zero-happiness? (cat-and-cham-cham cac))))

;; VAnimal -> Boolean
;; is the happiness of the animal zero?
(define (animal-zero-happiness? vc)
  (cond
    [(vcat? vc) (zero? (vcat-happiness vc))]
    [(vcham? vc) (zero? (vcham-happiness vc))]))

; --- key-handler ---

; CatAndCham KeyEvent -> CatAndCham
; the world state after the key event
(define (key-h cac ke)
  (cond
    [(key=? ke "l") (make-cat-and-cham (cat-and-cham-cat cac)
                                       (cat-and-cham-cham cac)
                                       "cham")]
    [(key=? ke "k") (make-cat-and-cham (cat-and-cham-cat cac)
                                       (cat-and-cham-cham cac)
                                       "cat")]
    [(string=? "cat" (cat-and-cham-cat-or-cham cac))
     (make-cat-and-cham (animal-keystroke-handler (cat-and-cham-cat cac) ke)
                        (cat-and-cham-cham cac)
                        "cat")]
    [(string=? "cham" (cat-and-cham-cat-or-cham cac))
     (make-cat-and-cham (cat-and-cham-cat cac)
                        (animal-keystroke-handler (cat-and-cham-cham cac) ke)
                        "cham")]))

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


