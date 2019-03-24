
;; movie-starter.rkt

;; ===================================================
; 
; PROBLEM A:
; 
; Design a data definition to represent a movie, including  
; title, budget, and year released.
; 
; To help you to create some examples, find some interesting movie facts below: 
; "Titanic" - budget: 200000000 released: 1997
; "Avatar" - budget: 237000000 released: 2009
; "The Avengers" - budget: 220000000 released: 2012
; 
; However, feel free to resarch more on your own!
; 
;; ===================================================

;; Data definitions:
(define-struct movie (t b y))
;; Movie is (make-movie String Natural Natural)
;; interp. (make-movie t b y) is a movie with
;;          t is the title
;;          b is the budget
;;          y is the year released
(define M1 (make-movie "Titanic" 200000000 1997))
(define M2 (make-movie "Avatar" 237000000 2009))
(define M3 (make-movie "The Avengers" 220000000 2012))

(define (fn-for-movie m)
  (... (movie-t m)     ;String
       (movie-b m)     ;Natural
       (movie-y m)))   ;Natural

;; Template rules used:
;;  - Compound: 3 fields

;; ===================================================
; 
; PROBLEM B:
; 
; You have a list of movies you want to watch, but you like to watch your 
; rentals in chronological order. Design a function that consumes two movies 
; and produces the title of the most recently released movie.
; 
; Note that the rule for templating a function that consumes two compound data 
; parameters is for the template to include all the selectors for both 
; parameters.
; 
;; ===================================================

;; Functions:

;; Movie Movie -> String
;; produces the title of the most recently released movie out of 2 movie choices
(check-expect (latest-movie M1 M2) (movie-t M2))
(check-expect (latest-movie M2 M3) (movie-t M3))

;(define (latest-movie fm sm) "") ;stub
#;
(define (latest-movie m1 m2)
  (... (movie-t m1)    
       (movie-b m1)     
       (movie-y m1)
       (movie-t m2)    
       (movie-b m2)     
       (movie-y m2))) ;template

(define (latest-movie m1 m2)
  (if (> (movie-y m1) (movie-y m2))
      (movie-t m1)
      (movie-t m2)))
