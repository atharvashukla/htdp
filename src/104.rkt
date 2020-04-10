;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 104ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 104.
;; -------------
;; Your home town manages a fleet of vehicles: automobiles, vans, buses, and
;; SUVs. Develop a data representation for vehicles. The representation of each
;; vehicle must describe the number of passengers that it can carry, its license
;; plate number, and its fuel consumption (miles per gallon). Develop a template
;; for functions that consume vehicles. 
;; -----------------------------------------------------------------------------


; A Vehicle is one of:
; - Auto
; - Van
; - Bus
; - SUV
; intepretation. A vehicle can be of the given 4 types.

(define-struct auto [capacity plate fuel])
; An Auto is a structure
;    (make-auto Number Number Number)
; interpretation. capacity, license plate number
; and fuel consumption (in miles/gal) of the auto.

(define-struct van [capacity plate fuel])
; An Van is a structure
;    (make-van Number Number Number)
; interpretation. capacity, license plate number 
; and fuel consumption (in miles/gal) of the van.

(define-struct bus [capacity plate fuel])
; An Bus is a structure
;    (make-bus Number Number Number)
; interpretation. capacity, license plate number 
; and fuel consumption (in miles/gal) of the bus.

(define-struct suv [capacity plate fuel])
; An SUV is a structure
;    (make-suv Number Number Number)
; interpretation. capacity, license plate  number
; and fuel consumption (in miles/gal) of the suv.


; Vehicle -> ...
; processes a vehicle
(define (vehicle-temp v)
  (cond
    [(auto? v) (... (auto-capacity v) ... (auto-plate v) ... (auto-fuel v) ...)]
    [(van? v) (... (van-capacity v) ... (van-plate v) ... (van-fuel v) ...)]
    [(bus? v) (... (bus-capacity v) ... (bus-plate v) ... (bus-fuel v) ...)]
    [(suv? v) (... (suv-capacity v) ... (suv-plate v) ... (suv-fuel v) ...)]))