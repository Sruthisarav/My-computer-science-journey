(require 2htdp/image)
(require 2htdp/universe)

;; traffic-light-starter.rkt

; 
; PROBLEM:
; 
; Design an animation of a traffic light. 
; 
; Your program should show a traffic light that is red, then green, 
; then yellow, then red etc. For this program, your changing world 
; state data definition should be an enumeration.
; 
; To make your lights change at a reasonable speed, you can use the 
; rate option to on-tick. If you say, for example, (on-tick next-color 1) 
; then big-bang will wait 1 second between calls to next-color.
; 
; Remember to follow the HtDW recipe! Be sure to do a proper domain 
; analysis before starting to work on the code file.
; 
; Note: If you want to design a slightly simpler version of the program,
; you can modify it to display a single circle that changes color, rather
; than three stacked circles. 
; 


;; Animation of traffic lights changing colours

;; =================
;; Constants:
(define WIDTH 200)
(define HEIGHT 500)
(define CTR-X (/ WIDTH 2))
(define CTR-Y (/ HEIGHT 2))
(define MTS (overlay (rectangle WIDTH HEIGHT "solid" "black") (empty-scene WIDTH HEIGHT)))
(define REDLIGHT (above(overlay (circle 50 "solid" "red") (rectangle 100 120 "solid" "black"))
                       (overlay (circle 50 "outline" "yellow") (rectangle 100 120 "solid" "black"))
                       (overlay (circle 50 "outline" "green") (rectangle 100 120 "solid" "black"))))
(define YELLOWLIGHT (above(overlay (circle 50 "outline" "red") (rectangle 100 120 "solid" "black"))
                          (overlay (circle 50 "solid" "yellow") (rectangle 100 120 "solid" "black"))
                          (overlay (circle 50 "outline" "green") (rectangle 100 120 "solid" "black"))))
(define GREENLIGHT (above(overlay (circle 50 "outline" "red") (rectangle 100 120 "solid" "black"))
                         (overlay (circle 50 "outline" "yellow") (rectangle 100 120 "solid" "black"))
                         (overlay (circle 50 "solid" "green") (rectangle 100 120 "solid" "black"))))


;; =================
;; Data definitions:

;; Traffic light is one of:
;; - "red"
;; - "yellow"
;; - "green"
;; interp. the color of a traffic light
#;
(define (fn-for-light-state tl)
  (cond [(string =? "red" tl) (...)]
        [(string =? "yellow" tl) (...)]
        [(string =? "green" tl) (...)]))
;; Template rules used:
;; - one of: 3 cases
;; - atomic distinct: "red"
;; - atomic distinct: "yellow"
;; - atomic distinct: "green"

;; =================
;; Functions:

;; Traffic Light -> Traffic Light
;; Start with green light.
;; 
(define (main tl)
  (big-bang tl                         ; Traffic Light
            (on-tick advance-light 1.5); Traffic Light -> Traffic Light
            (to-draw render-light)))   ; Traffic Light -> Image

;; Traffic Light -> Traffic Light
;; produces the next traffic light colour
(check-expect (advance-light "green") "yellow")
(check-expect (advance-light "yellow") "red")
(check-expect (advance-light "red") "green")

;(define (advance-light tl) "") ;stub
;<Use template from Traffic Light>

(define (advance-light tl)
  (cond [(string=? "red" tl) "green"]
        [(string=? "yellow" tl) "red"]
        [(string=? "green" tl) "yellow"]))   

;; Traffic Light -> Image
;; render the traffic light image on screen
(check-expect (render-light "green") (place-image GREENLIGHT CTR-X CTR-Y MTS))
(check-expect (render-light "yellow") (place-image YELLOWLIGHT CTR-X CTR-Y MTS))
(check-expect (render-light "red") (place-image REDLIGHT CTR-X CTR-Y MTS))
    
;(define (render-light tl) (... tl)) ;stub
;<Use template from Traffic Light>

(define (render-light tl)
  (cond [(string=? "red" tl) (place-image REDLIGHT CTR-X CTR-Y MTS)]
        [(string=? "yellow" tl) (place-image YELLOWLIGHT CTR-X CTR-Y MTS)]
        [(string=? "green" tl) (place-image GREENLIGHT CTR-X CTR-Y MTS)]))
