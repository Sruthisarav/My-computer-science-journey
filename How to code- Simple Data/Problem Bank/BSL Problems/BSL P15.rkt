; 
; PROBLEM:
; 
; Write a function that consumes two numbers and produces the larger of the two. 
; 
;; ==============================================================================

(check-expect (larger? 10 20) 20)
(check-expect (larger? 15 10) 15)

(define (larger? a b)
  (if (> a b)
      a
      b))
