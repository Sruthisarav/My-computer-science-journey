
;; water-balloon-starter.rkt

; PROBLEM:
; 
; In this problem, we will design an animation of throwing a water balloon.  
; When the program starts the water balloon should appear on the left side 
; of the screen, half-way up.  Since the balloon was thrown, it should 
; fly across the screen, rotating in a clockwise fashion. Pressing the 
; space key should cause the program to start over with the water balloon
; back at the left side of the screen. 
; 
; NOTE: Please include your domain analysis at the top in a comment box. 
; 
; Use the following images to assist you with your domain analysis:
; 
; 
; 1)
; 2).
; .
; 3)
; .
; 4)
; 
; .
;     
; 
; Here is an image of the water balloon:
; (define WATER-BALLOON.)
; 
; 
; 
; NOTE: The rotate function wants an angle in degrees as its first 
; argument. By that it means Number[0, 360). As time goes by your balloon 
; may end up spinning more than once, for example, you may get to a point 
; where it has spun 362 degrees, which rotate won't accept. 
; 
; The solution to that is to use the modulo function as follows:
; 
; (rotate (modulo ... 360) (text "hello" 30 "black"))
; 
; where ... should be replaced by the number of degrees to rotate.
; 
; NOTE: It is possible to design this program with simple atomic data, 
; but we would like you to use compound data.


(require 2htdp/image)
(require 2htdp/universe)
;; ==================================================
;; Constants:

(define WIDTH 400)
(define HEIGHT 200)

(define CTR-Y (/ HEIGHT 2))
(define WATER-BALLOON .)

(define MTS (rectangle WIDTH HEIGHT "solid" "white"))
(define LINEAR-SPEED 5)
(define ANGULAR-SPEED 10)

;; ==================================================
;; Data definitions:
(define-struct balloon (x a))
;; Balloon is (make-balloon Natural[0, WIDTH], Natural[0,360))
;; interp. (make-balloon x a) is a water balloon with x-coordinate x, angular velocity a
;;         x is the screen coordinates (pixels)
;;         a is the angle of rotation (degrees)
(define B1 (make-balloon 10 0))  ; at 10, angle of 0 degrees
(define B2 (make-balloon 30 30)) ; at 30, angle of 30 degrees
#;
(define (fn-for-balloon b)
  (... (balloon-x b)
       (balloon-a b))) ;template

;; ==================================================
;; Functions:

;; Balloon -> Balloon
;; water balloon is thrown from the left, rotating in a clockwise direction; start with (main (make-balloon 0 0))
;; no tests for main function
(define (main b)
  (big-bang b
            (on-tick next-balloon); Balloon -> balloon
            (to-draw render-balloon); Balloon -> Image
            (on-key reset-balloon))); Balloon KeyEvent -> Balloon

;; Balloon -> Balloon
;; Increase ballon x by LINEAR-SPEED and a by ANGULAR-SPEED
(check-expect (next-balloon (make-balloon 20 15)) (make-balloon (+ 20 LINEAR-SPEED) (+ 15 ANGULAR-SPEED)))

; (define (next-balloon b) b) ;stub

;<template from Balloon>
(define (next-balloon b)
  (cond [(< (balloon-a b) 360) (make-balloon (+ (balloon-x b) LINEAR-SPEED)(+ (balloon-a b) ANGULAR-SPEED))]
        [else (make-balloon (+ (balloon-x b) LINEAR-SPEED)(- (+ (balloon-a b) ANGULAR-SPEED) 360))]))


;; Balloon -> Image
;; place appropriate cow image on MTS at (balloon-x b), CTR-Y and appropriate position at (balloon-da b)
(check-expect (render-balloon(make-balloon 10 100))(place-image (rotate (modulo 100 360) WATER-BALLOON)
               10
               CTR-Y
               MTS))

; (define (render-balloon b) MTS) ;stub

;<template from Balloon>
(define (render-balloon b)
  (place-image (rotate (modulo (balloon-a b) 360) WATER-BALLOON)
               (balloon-x b)
               CTR-Y
               MTS))

;; Balloon KeyEvent -> Balloon
;; reposition image of water balloon back at the left side of MTS
(check-expect (reset-balloon (make-balloon 20 120) " ")
              (make-balloon 0 0))
(check-expect (reset-balloon (make-balloon 10 240) "right")
              (make-balloon 10 240))

; (define (handle-key b ke) b) ;stub

; Template from KeyEvent
(define (reset-balloon b key)
  (cond [(key=? " " key) (make-balloon 0 0)]
        [else b]))
