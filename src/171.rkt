;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 171ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 171
;; ------------
;; You know what the data definition for List-of-strings looks like. Spell it
;; out. Make sure that you can represent Piet Hein’s poem as an instance of the
;; definition where each line is represented as a string and another instance
;; where each word is a string. Use read-lines and read-words to confirm your
;; representation choices.
;;
;; Next develop the data definition for List-of-list-of-strings. Again,
;; represent Piet Hein’s poem as an instance of the definition where each line
;; is represented as a list of strings, one per word, and the entire poem is a
;; list of such line representations. You may use read-words/line to confirm
;; your choice. 
;; -----------------------------------------------------------------------------



(require 2htdp/batch-io)

;; A List-of-strings is one of
;; - '()
;; - (cons String List-of-string)

;; A List-of-list-of-strings is one of
;; - '()
;; - (cons List-of-strings List-of-list-of-strings)


(define lines
  (cons "TTT"
        (cons ""
              (cons "Put up in a place"
                    (cons "where it's easy to see"
                          (cons "the cryptic admonishment"
                                (cons "T.T.T."
                                      (cons ""
                                            (cons "When you feel how depressingly"
                                                  (cons "slowly you climb,"
                                                        (cons "it's well to remember that"
                                                              (cons "Things Take Time."
                                                                    (cons ""
                                                                          (cons "Piet Hein" '()))))))))))))))

(equal? lines (read-lines "ttt.txt"))


(define words
  (cons
   "TTT"
   (cons
    "Put"
    (cons
     "up"
     (cons
      "in"
      (cons
       "a"
       (cons
        "place"
        (cons
         "where"
         (cons
          "it's"
          (cons
           "easy"
           (cons
            "to"
            (cons
             "see"
             (cons
              "the"
              (cons
               "cryptic"
               (cons
                "admonishment"
                (cons
                 "T.T.T."
                 (cons
                  "When"
                  (cons
                   "you"
                   (cons
                    "feel"
                    (cons
                     "how"
                     (cons
                      "depressingly"
                      (cons
                       "slowly"
                       (cons
                        "you"
                        (cons
                         "climb,"
                         (cons
                          "it's"
                          (cons
                           "well"
                           (cons
                            "to"
                            (cons
                             "remember"
                             (cons
                              "that"
                              (cons
                               "Things"
                               (cons
                                "Take"
                                (cons
                                 "Time."
                                 (cons
                                  "Piet"
                                  (cons
                                   "Hein"
                                   '()))))))))))))))))))))))))))))))))))

(equal? words (read-words "ttt.txt"))

(define lolos
(cons
 (cons "TTT" '())
 (cons
  '()
  (cons
   (cons
    "Put"
    (cons
     "up"
     (cons "in" (cons "a" (cons "place" '())))))
   (cons
    (cons
     "where"
     (cons
      "it's"
      (cons "easy" (cons "to" (cons "see" '())))))
    (cons
     (cons
      "the"
      (cons "cryptic" (cons "admonishment" '())))
     (cons
      (cons "T.T.T." '())
      (cons
       '()
       (cons
        (cons
         "When"
         (cons
          "you"
          (cons
           "feel"
           (cons
            "how"
            (cons "depressingly" '())))))
        (cons
         (cons
          "slowly"
          (cons "you" (cons "climb," '())))
         (cons
          (cons
           "it's"
           (cons
            "well"
            (cons
             "to"
             (cons "remember" (cons "that" '())))))
          (cons
           (cons
            "Things"
            (cons "Take" (cons "Time." '())))
           (cons
            '()
            (cons
             (cons "Piet" (cons "Hein" '()))
             '()))))))))))))))

(equal? lolos (read-words/line "ttt.txt"))