;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |designing-with-structures copy|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 80.
;; ------------
;; Create templates for functions that consume instances of the following
;; structure types:
;;
;;    (define-struct movie [title director year])
;;    
;;    (define-struct pet [name number])
;;    
;;    (define-struct CD [artist title price])
;;    
;;    (define-struct sweater [material size color])
;;
;; No, you do not need data definitions for this task.
;; -----------------------------------------------------------------------------


(define-struct movie [title director year])

(define (movie-temp m)
  (... (movie-title m) ... (movie-director m) ... (movie-year m)))

(define-struct pet [name number])

(define (pet-temp p)
  (... (pet-name p) ... (pet-number p) ...))

(define-struct CD [artist title price])

(define (cd-temp c)
  (... (cd-artist c) ... (cd-title c) ... (cd-price c) ...))

(define-struct sweater [material size color])

(define (sweater-temp s)
  (... (sweater-material s) ... (sweater-size s) ... (sweater-color s) ...))