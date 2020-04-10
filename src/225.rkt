;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 225ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 225
;; ------------
;; Design a fire-fighting game.
;; 
;; The game is set in the western states where fires rage through vast forests.
;; It simulates an airborne fire-fighting effort. Specifically, the player acts
;; as the pilot of an airplane that drops loads of water on fires on the ground.
;; The player controls the plane’s horizontal movements and the release of water
;; loads.
;; 
;; Your game software starts fires at random places on the ground. You may wish
;; to limit the number of fires, making them a function of how many fires are
;; currently burning or other factors. The purpose of the game is to extinguish
;; all fires in a limited amount of time. Hint Use an iterative design approach
;; as illustrated in this chapter to create this game. 
;; -----------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)

; ----------------------------- Constants -----------------------------

(define FIRE-BLOCKS 10) ; # total fire blocks
(define BLOCK-SIDE-LEN 30)
(define BLOCK-MID-SIDE-LEN (/ BLOCK-SIDE-LEN 2))

(define FIRE-COLOR "dark orange")
; (define FOREST-COLOR "dark green")
(define WATER-COLOR "blue")
(define HELI-COLOR "black")

; Color -> Image
; makes a solid square of length BLOCK-SIDE-LEN with color `color`
(define (make-block color)
  (square BLOCK-SIDE-LEN "solid" color))

(define FIRE (square BLOCK-SIDE-LEN "solid" FIRE-COLOR))
; (define FOREST (make-block FOREST-COLOR))
(define WATER (make-block WATER-COLOR))
(define HELI (make-block HELI-COLOR))

(define SCENE-WIDTH 300)
(define SCENE-LENGTH 300)
(define SCENE-COLOR "gray")
(define BACKG (rectangle SCENE-WIDTH SCENE-LENGTH "solid" SCENE-COLOR))

(define BLOCK-Y-POS (- SCENE-LENGTH BLOCK-MID-SIDE-LEN))

; -------------------------- DATA DEFINITIONS -------------------------

(define-struct ffg [heli loads ground time score])
; A Fire-Fighting-Game (FFG) is a structure
; (make-ffg Heli Loads Ground Time Score)

; Heli is a Posn
; interpretation the position of the helicopter

; Loads is one of
; - '()
; - (cons Load Loads)
; interpretation a list of loads

; A Load is a Posn
;interpretation the position of a water load

; Ground is one of:
; - '()
; - (cons Fire Ground)
; interpretation list of fire positions

; Fire is a Posn
; interpretation the position of the file

; Time is a Number
; interpretation the time left for the game to end

; Score is a Number
; interpretation the number of fires extinguished to far


;; ----------------------------- Templates ----------------------------

; Heli -> ...
(define (heli-temp h)
  (... (posn-x h) ... (posn-y h) ...))

; Load -> ...
(define (load-temp l)
  (... (posn-x l) ... (posn-y l) ...))

; Fire -> ...
(define (fire-temp f)
  (... (posn-x f) ... (posn-y f) ...))

; Loads -> ...
(define (loads-temp l)
  (cond
    [(empty? l) ...]
    [else (... (load-temp (first l)) ... (loads-temp (rest l)) ...)]))

; Ground -> ...
(define (ground-temp g)
  (cond
    [(empty? g) ...]
    [else (... (fire-temp (first g)) ... (ground-temp (rest g)) ...)]))

; FFG -> ...
(define (ffg-temp ffg)
  (... (heli-temp (ffg-heli)) ... (loads-temp (ffg-loads ffg)) ... (ground-temp (ffg-ground ffg) ...)))

; ------------------------------ BIG-BANG -----------------------------

; launches the program with an initial state
(define (main sigs rate)
  (ffg-score
   (big-bang sigs
     [on-tick   tock rate]
     [stop-when end? end-state-render]
     [to-draw   render]
     [on-key    key-h])))

; ------------------------------ TO-DRAW ------------------------------

; FFG -> Image
; renders ffg
(define (render ffg)
  (time-render (ffg-time ffg)
               (heli-render (ffg-heli ffg)
                            (ground-render (ffg-ground ffg)
                                           (loads-render (ffg-loads ffg)
                                                         BACKG)))))

; Heli Image -> Image
; places h on b
(define (heli-render h b)
  (place-image HELI (posn-x h) (posn-y h) b))

; Load Image -> Image
; places l on b
(define (load-render l b)
  (place-image WATER (posn-x l) (posn-y l) b))

; Fire Image -> Image
; places f on b
(define (fire-render f b)
  (place-image FIRE (posn-x f)  (posn-y f) b))

; Time Image -> Image
(define (time-render n b)
  (overlay (text (number->string n) 24 "white") b))

; Loads -> Image
; places all loads on b
(define (loads-render l b)
  (cond
    [(empty? l) b]
    [else (load-render (first l) (loads-render (rest l) b))]))

; Ground -> Image
; places all forests on b
(define (ground-render g b)
  (cond
    [(empty? g) b]
    [else (fire-render (first g) (ground-render (rest g) b))]))


(check-expect (render (make-ffg (make-posn 15 15) '() '() 10 0))
              (overlay (text "10" 24 "white")
                       (place-image HELI 15 15 BACKG)))

(check-expect (render (make-ffg (make-posn 15 15) (list (make-posn 15 45)) '() 10 0))
              (overlay (text "10" 24 "white")
                       (place-image HELI 15 15 (place-image WATER 15 45 BACKG))))

(check-expect (render (make-ffg (make-posn 15 15) (list (make-posn 15 75)) '() 10 0))
              (overlay (text "10" 24 "white")
                       (place-image HELI 15 15 (place-image WATER 15 75 BACKG))))

(check-expect (render (make-ffg (make-posn 15 15) (list (make-posn 15 75)) (list (make-posn 15 285)) 10 0))
              (overlay (text "10" 24 "white")
                       (place-image HELI 15 15  (place-image FIRE 15 285 (place-image WATER 15 75 BACKG)))))

(check-expect (render (make-ffg (make-posn 15 15)
                                (list (make-posn 15 75) (make-posn 15 285))
                                (list (make-posn 15 285) (make-posn 75 285))
                                10
                                0))
              (overlay (text "10" 24 "white")
                       (place-image HELI 15 15
                                    (place-image FIRE 15 285
                                                 (place-image FIRE 75 285
                                                              (place-image WATER 15 75
                                                                           (place-image WATER 15 285 BACKG)))))))


; ------------------------------ ON-KEY -------------------------------

; FFG -> FFG
; responds to the k keypress
(define (key-h ffg k)
  (cond
    [(key=? k "right") (move-heli-right ffg)]
    [(key=? k "left") (move-heli-left ffg)]
    [(key=? k " ") (gen-heli-load ffg)]
    [else ffg]))

; FFG -> FFG
; moving the heli in ffg to the right
(define (move-heli-right ffg)
  (make-ffg (move-heli-r (ffg-heli ffg))
            (ffg-loads ffg)
            (ffg-ground ffg)
            (ffg-time ffg)
            (ffg-score ffg)))

; Heli -> Heli
; moving a heli to the right
(define (move-heli-r h)
  (make-posn (+ (posn-x h) BLOCK-SIDE-LEN)
             (posn-y h)))

; FFG -> FFG
; moving heli in ffg to the left
(define (move-heli-left ffg)
  (make-ffg (move-heli-l (ffg-heli ffg))
            (ffg-loads ffg)
            (ffg-ground ffg)
            (ffg-time ffg)
            (ffg-score ffg)))

; Heli -> Heli
; moving a heli to the left
(define (move-heli-l h)
  (make-posn (- (posn-x h) BLOCK-SIDE-LEN)
             (posn-y h)))

; FFG -> FFG
; placing a newly generated load in ffg
(define (gen-heli-load ffg)
  (make-ffg (ffg-heli ffg)
            (cons (new-load-posn ffg) (ffg-loads ffg))
            (ffg-ground ffg)
            (ffg-time ffg)
            (ffg-score ffg)))

; FFG -> Posn
; the position where the new load will be generated
(define (new-load-posn ffg)
  (make-posn (posn-x (ffg-heli ffg))
             (+ (posn-y (ffg-heli ffg)) BLOCK-SIDE-LEN))) 


; List-of-posn -> List-of-posn
; remove common elements in l2 that also exist in l1
(define (remove-same l1 l2)
  (cond
    [(empty? l1) l2]
    [else (remove-elem (first l1) (remove-same (rest l1) l2))]))

(check-expect (remove-same '(1 2 3) '(1 2 3 4 5 6)) '(4 5 6))


; Posn List-of-posn -> List-of-posn
; remove e from l if it is in the list
(define (remove-elem e l)
  (cond
    [(empty? l) l]
    [else (if (equal? (first l) e)
              (remove-elem e (rest l))
              (cons (first l) (remove-elem e (rest l))))]))

; ------------------------------ ON-TICK ------------------------------

; FFG -> FFg
; move the loads down, generate fire (if needed), decrease time and update score
(define (tock ffg) 
  (make-ffg (ffg-heli ffg)
            (move-loads-down (ffg-loads ffg))
            (remove-same (ffg-loads ffg) (gen-fire-or-not (ffg-ground ffg) (ffg-time ffg)))
            (sub1 (ffg-time ffg))
            (new-score ffg)))

; List-of-posn Number -> List-of-fires
(define (gen-fire-or-not fires time)
  (if (time-to-gen-fire? time) (add-fire fires) fires))

; FFG -> FFG
; update-score by checking which waters are on fires at this moment
(define (new-score ffg)
  (+ (ffg-score ffg)
     ; adding the number of waters on fires
     (length (which-waters-on-fires (ffg-ground ffg)
                                    (ffg-loads ffg)))))

; Number -> Boolean
; If time is a multiple of 10, add a new fire
(define (time-to-gen-fire? time)
  (= 0 (modulo time 10)))

; List-of-posn -> List-of-posn 
; generate a new fire and add it to fires
(define (add-fire fires)
  (cons (gen-fire-posn fires) fires))


; Load -> Load
; move all loads down
(define (move-loads-down l)
  (cond
    [(empty? l) '()]
    [else (cons (move-water (first l))
                (move-loads-down (rest l)))]))

; Water -> Water
; moves the water down
(define (move-water w)
  (make-posn (posn-x w) (+ (posn-y w) BLOCK-SIDE-LEN)))


; List-of-posns List-of-posns -> List-of-posns
(define (which-waters-on-fires fires waters)
  (cond
    [(empty? waters) '()]
    [else (append (water-on-what-fires fires (first waters))
                  (which-waters-on-fires fires (rest waters)))]))

; List-of-posns Posn -> List-of-posn
; all the fires that the water overlaps
(define (water-on-what-fires fires water)
  (cond
    [(empty? fires) '()]
    [else (if (equal? water (first fires))
              (cons water (water-on-what-fires (rest fires) water))
              (water-on-what-fires (rest fires) water))]))


; ------------------- Random Fires -------------------

; List-of-Posn -> Posn
; generates random fires but makes sure they are not one of the fires in lop
(define (gen-fire-posn lop)
  (fire-check-create lop (make-posn (+ (* (random FIRE-BLOCKS) BLOCK-SIDE-LEN) BLOCK-MID-SIDE-LEN) BLOCK-Y-POS)))

; List-of-Posn Posn -> Posn
; makes sure the proposed fire is not the same as one of the fires in lop
(define (fire-check-create lop candidate)
  (if (member? candidate lop) (gen-fire-posn lop) candidate))

; ------------------------------ STOP-WHEN ----------------------------

; FFG -> Boolean
; is the game over?
(define (end? ffg)
  (<= (ffg-time ffg) 0))

; ------------------------------ FINAL-RENDER -------------------------

; FFG -> Image
; the rendering of the last state
(define (end-state-render ffg)
  (render ffg))

; -------------------------------- MAIN -------------------------------

#;
(main (make-ffg (make-posn 15 15) '() '() 120 0) 0.02)
