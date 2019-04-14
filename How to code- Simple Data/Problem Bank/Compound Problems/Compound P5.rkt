; 
; PROBLEM:
; 
; Design a world program as follows:
; 
; The world starts off with a piece of grass waiting to grow. As time passes, 
; the grass grows upwards. Pressing any key cuts the current strand of 
; grass to 0, allowing a new piece to grow to the right of it.
; 
; NOTE 1: Remember to follow the HtDW recipe! Be sure to do a proper domain 
; analysis before starting to work on the code file.
; 
;; ==================================================================================

(require 2htdp/image)
(require 2htdp/universe)

;; Constants:

(define WIDTH 1200)
(define HEIGHT 800)

(define BLUE-BACKGROUND (rectangle WIDTH HEIGHT "solid" "lightblue"))
(define GRASS-WIDTH 10)

(define GRASS-GROWTH 10)

;; Data definitions
(define-struct grass (x length))
;; Grass is (make-grass Natural[0, WIDTH] Natural[0, HEIGHT])
;; interp. (make-grass x length) is grass with x-coordinates x, length
;;         x is the x-coordinates of the grass on screen (in pixels)
;;         length is the length of grass on screen (in pixels)
(define G1 (make-grass 10 20)) ; grass with 10 x-coordinates and 20 pixels long
(define G2 (make-grass 40 30)) ; grass with 40 x-coordinates and 30 pixels long

#;
(define (fn-for-grass g)
  (... (grass-x g)
       (grass-length g))) ;template

;; Template rules used:
;; Compound: 2 fields

;; Functions:

;; Grass -> Grass
;; Grass will start growing on the left side of screen; start with (main (make-grass 5 0))
;; no tests for main function

(define (main g)
  (big-bang g              ; Grass
    (on-tick next-grass)   ; Grass -> Grass
    (to-draw render-grass) ; Grass -> Image
    (on-key reset-grass))) ; Grass KeyEvent -> Grass

;; Grass -> Grass
;; Increase the size of grass by GRASS-GROWTH
(check-expect (next-grass (make-grass 10 20)) (make-grass 10 (+ 20 GRASS-GROWTH)))
(check-expect (next-grass (make-grass 100 0)) (make-grass 100 (+ 0 GRASS-GROWTH)))
(check-expect (next-grass (make-grass 50 (* 2 HEIGHT))) (make-grass 50 (* 2 HEIGHT)))

; (define (next-grass g) g) ;stub

(define (next-grass g)
  (if (= (grass-length g) (* 2 HEIGHT))
      g
      (make-grass (grass-x g) (+ (grass-length g) GRASS-GROWTH))))

;; Grass -> Image
;; Places the appropriate image of grass at the appropirate place on BLUE-BACKGROUND
(check-expect (render-grass (make-grass 10 20)) (place-image (rectangle GRASS-WIDTH 20 "solid" "green")
                                                             10
                                                             HEIGHT
                                                             BLUE-BACKGROUND))
(check-expect (render-grass (make-grass 100 0)) BLUE-BACKGROUND)
(check-expect (render-grass (make-grass 50 40)) (place-image (rectangle GRASS-WIDTH 40 "solid" "green")
                                                             50
                                                             HEIGHT
                                                             BLUE-BACKGROUND))

; (define (render-grass g) BLUE-BACKGROUND) ;stub

(define (render-grass g)
  (if (zero? (grass-length g))
      BLUE-BACKGROUND
      (place-image (rectangle GRASS-WIDTH (grass-length g) "solid" "green")
                   (grass-x g)
                   HEIGHT
                   BLUE-BACKGROUND)))

;; Grass KeyEvent -> Grass
;; Pressing any key cuts the current strand of grass to 0, allowing a new piece to grow to the right of it.
(check-expect (reset-grass (make-grass 10 20) " ") (make-grass 20 0))
(check-expect (reset-grass (make-grass 50 100) "button-down") (make-grass 50 100))
(check-expect (reset-grass (make-grass 50 100) "a") (make-grass 60 0))
(check-expect (reset-grass (make-grass 30 40) "b") (make-grass 40 0))

; (define (reset-grass g key) g) ;stub

(define (reset-grass g key)
  (if (key-event? key)
  (make-grass (+ (grass-x g) 10) 0)
  g))
