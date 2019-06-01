(require 2htdp/image)
(require 2htdp/universe)
; 
; PROBLEM:
; 
; A Cantor Set is another fractal with a nice simple geometry.
; The idea of a Cantor set is to have a bar (or rectangle) of
; a certain width w, then below that are two recursive calls each
; of 1/3 the width, separated by a whitespace of 1/3 the width.
; 
; So this means that the
;   width of the whitespace   wc  is  (/ w 3)
;   width of recursive calls  wr  is  (/ (- w wc) 2)
;   
; To make it look better a little extra whitespace is put between
; the bars.
; 
; 
; Here are a couple of examples (assuming a reasonable CUTOFF)
; 
; (cantor CUTOFF) produces:
; 
; .
; 
; (cantor (* CUTOFF 3)) produces:
; 
; .
; 
; And that keeps building up to something like the following. So
; as it goes it gets wider and taller of course.
; 
; .
; 
; 
; PROBLEM A:
; 
; Design a function that consumes a width and produces a cantor set of 
; the given width.
; 
; 
; PROBLEM B:
; 
; Add a second parameter to your function that controls the percentage 
; of the recursive call that is white each time. Calling your new function
; with a second argument of 1/3 would produce the same images as the old 
; function.
; 
; PROBLEM C:
; 
; Now you can make a fun world program that works this way:
;   The world state should simply be the most recent x coordinate of the mouse.
;   
;   The to-draw handler should just call your new cantor function with the
;   width of your MTS as its first argument and the last x coordinate of
;   the mouse divided by that width as its second argument.
; 
;; ===================================================================================

;; Constants:

(define CUTOFF 2)
(define STEP (/ 1 3))
(define HEIGHT 15)

(define MS-WIDTH 1400)
(define MS-HEIGHT 1000)

(define MTS (rectangle MS-WIDTH MS-HEIGHT "solid" "white"))

;; Data definitions:
;; WorldState is Integer
;; interp. the last x-coordinate of the mouse
(define WS0 0)
(define WS1 60)
(define WS2 200)

#;
(define (fn-for-ws ws)
  (... ws)) ;template


;; Functions:

;; WorldState -> WorldState
;; Produces a cantor whenever there is a mouse click
;; Start with (main 0)
(define (main ws)
  (big-bang ws
    (to-draw render-worldstate)  ; WorldState -> Image
    (on-mouse new-worldstate)))  ; WorldState Integer Integer MouseEvent -> WorldState

;; WorldState -> Image
;; Place appropriate image of contour on MTS
(check-expect (render-worldstate WS1) (cantor MS-WIDTH (/ WS1 MS-WIDTH)))
(check-expect (render-worldstate WS2) (cantor MS-WIDTH (/ WS2 MS-WIDTH)))

; (define (render-worldstate ws) MTS) ;stub

(define (render-worldstate ws)
  (cantor MS-WIDTH (/ ws MS-WIDTH)))

;; WorldState Integer Integer MouseEvent -> WorldState
;; Replaces cantor with a new one on MTS with the value of WorldState=x-coordinate/MS-WIDTH
(check-expect (new-worldstate 250 100 40 "move") 100)
(check-expect (new-worldstate 110 250 120 "button-down") 110)

(define (new-worldstate ws x y me)
  (cond [(mouse=? me "move") x]
        [else ws]))


;; Number -> Image
;; Produces a cantor set of the given width
(check-expect (cantor CUTOFF STEP) (rectangle CUTOFF HEIGHT "solid" "blue"))
(check-expect (cantor (* CUTOFF 3) STEP) (local [(define main (rectangle (* CUTOFF 3) HEIGHT "solid" "blue"))
                                                 (define space (rectangle (* CUTOFF 3) (/ HEIGHT 2) "solid" "white"))
                                                 (define wc (rectangle CUTOFF HEIGHT "solid" "white"))
                                                 (define wr (rectangle CUTOFF HEIGHT "solid" "blue"))]
                                           (above main
                                                  space
                                                  (beside wr wc wr))))
(check-expect (cantor (* CUTOFF 9) STEP) (local [(define main (rectangle (* CUTOFF 9) HEIGHT "solid" "blue"))
                                                 (define space (rectangle (* CUTOFF 9) (/ HEIGHT 2) "solid" "white"))
                                                 (define wc1 (rectangle (* CUTOFF 3) HEIGHT "solid" "white"))
                                                 (define wr1 (rectangle (* CUTOFF 3) HEIGHT "solid" "blue"))
                                                 (define wc2 (rectangle CUTOFF HEIGHT "solid" "white"))
                                                 (define wr2 (rectangle CUTOFF HEIGHT "solid" "blue"))
                                                 (define space2 (rectangle (* CUTOFF 3) (/ HEIGHT 2) "solid" "white"))]
                                           (above main
                                                  space
                                                  (beside
                                                   (above wr1
                                                          space2
                                                          (beside wr2 wc2 wr2))
                                                   wc1
                                                   (above wr1
                                                          space2
                                                          (beside wr2 wc2 wr2))))))

(check-expect (cantor (* CUTOFF 4) 0.5) (local [(define main (rectangle (* CUTOFF 4) HEIGHT "solid" "blue"))
                                                 (define space (rectangle (* CUTOFF 4) (/ HEIGHT 2) "solid" "white"))
                                                 (define wc1 (rectangle (* CUTOFF 2) HEIGHT "solid" "white"))
                                                 (define wr1 (rectangle (/ (- (* CUTOFF 4) (* CUTOFF 2)) 2) HEIGHT "solid" "blue"))]
                                           (above main
                                                  space
                                                  (beside wr1 wc1 wr1))))

(check-expect (cantor (* CUTOFF (/ 10 4)) 0.4) (local [(define main (rectangle (* CUTOFF (/ 10 4)) HEIGHT "solid" "blue"))
                                                 (define space (rectangle (* CUTOFF (/ 10 4)) (/ HEIGHT 2) "solid" "white"))
                                                 (define wc (rectangle CUTOFF HEIGHT "solid" "white"))
                                                 (define wr (rectangle (/ (- (* CUTOFF (/ 10 4)) CUTOFF) 2) HEIGHT "solid" "blue"))]
                                           (above main
                                                  space
                                                  (beside wr wc wr))))


; (define (cantor s) (square 0 "solid" "white"))

(define (cantor s p)
  (if (<= s CUTOFF)
      (rectangle s HEIGHT "solid" "blue")
      (above (rectangle s HEIGHT "solid" "blue")
             (rectangle s (/ HEIGHT 2) "solid" "white")
             (local [(define wc (rectangle (* s p) HEIGHT "solid" "white"))
                     (define wr (cantor (/ (- s (* s p)) 2) p))]
               (beside wr wc wr)))))
