; 
; PROBLEM:
; 
; DESIGN a function called area that consumes the length of one side 
; of a square and produces the area of the square.
; 
; Remember, when we say DESIGN, we mean follow the recipe.
; 
; Leave behind commented out versions of the stub and template.
; 
;; ==================================================================

;; Integer -> Integer
;; Finds the area of a square given the length
(check-expect (area-square 5) 25)
(check-expect (area-square 10) 100)

; (define (area-square n) 0) ;stub

(define (area-square n)
  (* n n))
