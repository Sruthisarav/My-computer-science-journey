; 
; PROBLEM:
; 
; Design a world program that displays the current (x, y) position
; of the mouse at that current position. So as the mouse moves the 
; numbers in the (x, y) display changes and its position changes. 
; 
;; ======================================================================================

(require 2htdp/image)
(require 2htdp/universe)

;; Constants:
(define WIDTH 1200)
(define HEIGHT 800)

(define MTS (rectangle WIDTH HEIGHT "solid" "white"))

(define DISPLAY-WIDTH 100)
(define DISPLAY-HEIGHT 50)
(define DISPLAY (rectangle DISPLAY-WIDTH DISPLAY-HEIGHT "outline" "black"))
(define CTR-X (/ DISPLAY-WIDTH 2))
(define CTR-Y (/ DISPLAY-HEIGHT 2))

(define TEXT-SIZE 20)
(define TEXT-COLOR "blue")

;; Data definitions:
(define-struct position (x y))
;; Position is (make-position Natural[0, WIDTH] Natural[0, HEIGHT])
;; interp. (make-position x y) is position with x-coordinates, x and y-coordinates y
;;         x is the x-coordinates of the position of mouse on screen (in pixels)
;;         y is the y-coordinates of the position of mouse on screen (in pixels)
(define P1 (make-position 40 50))   ; position with 40 x-coordinates and 50 y-coordinates
(define P2 (make-position 100 300)) ; position with 100 x-coordinates and 300 y-coordinates

#;
(define (fn-for-position p)
  (... (position-x p)
       (position-y p)))

;; Template rules used:
;; Compound: 2 fields

;; Functions:

;; Position -> Position
;; Displays the current position of the mouse; start with (main (make-position 0 0))

(define (main p)
  (big-bang p                   ; Position
    (to-draw render-position)   ; Position -> Image
    (on-mouse reset-position))) ; Position Integer Integer MouseEvent -> Position

;; Position -> Image
;; Place the DISPLAY with the appropriate coordinates on the left side of screen
(check-expect (render-position (make-position 40 50)) (place-image (overlay (text (string-append (number->string 40) " , " (number->string 50)) TEXT-SIZE TEXT-COLOR)
                                                                            DISPLAY)
                                                                   CTR-X
                                                                   CTR-Y
                                                                   MTS))
(check-expect (render-position (make-position 60 170)) (place-image (overlay (text (string-append (number->string 60) " , " (number->string 170)) TEXT-SIZE TEXT-COLOR)
                                                                            DISPLAY)
                                                                   CTR-X
                                                                   CTR-Y
                                                                   MTS))

; (define (render-position p) MTS) ;stub

(define (render-position p)
  (place-image (overlay (text (string-append (number->string (position-x p)) " , " (number->string (position-y p))) TEXT-SIZE TEXT-COLOR)
                                                                            DISPLAY)
                                                                   CTR-X
                                                                   CTR-Y
                                                                   MTS))

;; Position Integer Integer MouseEvent -> Position
;; Finds the coordinates of the new position of mouse
(check-expect (reset-position (make-position 40 50) 60 160 "button-down") (make-position 60 160))
(check-expect (reset-position (make-position 40 50) 60 160 "button-up") (make-position 40 50))

; (define (reset-position p x y me) p) ;stub

(define (reset-position p x y me)
  (cond [(mouse=? me "button-down") (make-position x y)]
        [else p]))
