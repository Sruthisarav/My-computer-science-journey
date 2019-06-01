(require 2htdp/image)
; 
; PROBLEM :
; 
; Design a function that will create the following fractal:
; 
;             .
; 
;             
; 
; Each circle is surrounded by circles that are two-fifths smaller. 
; 
; You can build these images using the convenient beside and above functions
; if you make your actual recursive function be one that just produces the
; top leaf shape. You can then rotate that to produce the other three shapes.
; 
; You don't have to use this structure if you are prepared to use more
; complex place-image functions and do some arithmetic. But the approach
; where you use the helper is simpler.
; 
; Include a termination argument for your design.
;; =================================================================================

;; Constants:

(define STEP (/ 2 5))
(define TRIVIAL-SIZE 2)

;; Functions:

;; Number -> Image
;; produces a circule fractal of the given size.
(check-expect (cir-frac TRIVIAL-SIZE) (circle TRIVIAL-SIZE "solid" "blue"))
(check-expect (cir-frac (/ TRIVIAL-SIZE STEP))
              (local [(define sub (circle TRIVIAL-SIZE "solid" "blue"))
                      (define main (circle (/ TRIVIAL-SIZE STEP) "solid" "blue"))]
                (above sub
                       (beside sub main sub)
                       sub)))
(check-expect (cir-frac (/ TRIVIAL-SIZE (sqr STEP)))
              (local [(define center (circle (/ TRIVIAL-SIZE (sqr STEP)) "solid" "blue"))
                      (define sub-center (circle (/ TRIVIAL-SIZE STEP) "solid" "blue"))
                      (define sub-sub (circle TRIVIAL-SIZE "solid" "blue"))
                      (define sub
                        (above sub-sub
                               (beside sub-sub sub-center sub-sub)))]
                (above sub
                       (beside (rotate 90 sub) center (rotate 270 sub))
                       (rotate 180 sub))))

; (define (cir-frac s) (square 0 "solid" "white"))

(define (cir-frac s)
  (local [(define center (circle s "solid" "blue"))
          (define sub-side (side (* s STEP)))]
    (if (<= s TRIVIAL-SIZE)
        (circle s "solid" "blue")
        (above sub-side
               (beside (rotate 90 sub-side) center (rotate 270 sub-side))
               (rotate 180 sub-side)))))

;; Number -> Image
;; Produces the image of the side of the fractal
(check-expect (side TRIVIAL-SIZE) (circle TRIVIAL-SIZE "solid" "blue"))
(check-expect (side (/ TRIVIAL-SIZE STEP))
              (local [(define center (circle (/ TRIVIAL-SIZE STEP) "solid" "blue"))
                      (define sub (circle TRIVIAL-SIZE "solid" "blue"))]
                (above sub
                       (beside sub center sub))))

(define (side s)
  (if (<= s TRIVIAL-SIZE)
      (circle s "solid" "blue")
      (local [(define center (circle s "solid" "blue"))
              (define sub (side (* s STEP)))]
        (above sub
               (beside (rotate 90 sub) center (rotate 270 sub))))))

; Termination Argument
;     trivial case: (<= s TRIVIAL-SIZE)
;     reduction step: (side (* s STEP))
;     argument: By multiplying the size of the circle with STEP, the size of the circles continue to decrease
;     until it is less than the TRIVIAL-SIZE
