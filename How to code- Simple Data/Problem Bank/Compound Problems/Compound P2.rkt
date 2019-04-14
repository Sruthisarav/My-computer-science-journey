; 
; PROBLEM:
; 
; Design a world program as follows:
; 
; The world starts off with a small square at the center of the screen. As time 
; passes, the square stays fixed at the center, but increases in size and rotates 
; at a constant speed.Pressing the spacebar resets the world so that the square 
; is small and unrotated.
;
; NOTE 1: Remember to follow the HtDW recipe! Be sure to do a proper domain 
; analysis before starting to work on the code file.
; 
; NOTE 2: The rotate function requires an angle in degrees as its first 
; argument. By that it means Number[0, 360). As time goes by the box may end up 
; spinning more than once, for example, you may get to a point where it has spun 
; 362 degrees, which rotate won't accept. One solution to that is to use the 
; remainder function as follows:
; 
; (rotate (remainder ... 360) (text "hello" 30 "black"))
; 
; where ... can be an expression that produces any positive number of degrees 
; and remainder will produce a number in [0, 360).
; 
; Remember that you can lookup the documentation of rotate if you need to know 
; more about it.
; 
; NOTE 3: There is a way to do this without using compound data. But you should 
; design the compound data based solution.
; 
;; ==============================================================================================

(require 2htdp/image)
(require 2htdp/universe)

;; Constants:

(define WIDTH 1200)
(define HEIGHT 800)

(define CTR-X (/ WIDTH 2))
(define CTR-Y (/ HEIGHT 2))
(define RED-SQUARE (square 5 "solid" "red"))
(define MTS (rectangle WIDTH HEIGHT "solid" "white"))

(define SQUARE-SIZE-INCREASE 5)
(define ANGULAR-SPEED 10)


;; Data definitions:
(define-struct object (s a))
;; Object is (make-object Natural[5,WIDTH] Natural[0, 360))
;; interp. (make-object s a) is a square with size s, angle of rotation a
;;         s is the length of the side of the square
;;         a is the angle of rotation of the square
(define O1 (make-object 10 50)) ;angle of 50 degrees with the square having a length of 10
(define O2 (make-object 10 0))  ;angle of 0 degrees with the square having a length of 10

#;
(define (fn-for-object o)
  (... (object-s o)
       (object-a o))) ;template

;; Templates used:
;; Compound: 2 fields

;; Functions:

;; Object -> Object
;; object is a red square in the middle of the screen; start with (main (make-object 5 0))
;; no tests for main function

(define (main o)
  (big-bang o               ; Object
    (on-tick next-object)   ; Object -> Object 
    (to-draw render-object) ; Object -> Image
    (on-key reset-object))) ; Object KeyEvent -> Object


;; Object -> Object
;; Increase s by SQUARE-SIZE-INCREASE and a by ANGULAR-SPEED
(check-expect (next-object (make-object 10 5)) (make-object (+ 10 SQUARE-SIZE-INCREASE) (+ 5 ANGULAR-SPEED)))
(check-expect (next-object (make-object 15 360)) (make-object (+ 15 SQUARE-SIZE-INCREASE) ANGULAR-SPEED))

; (define (next-object o) o) ;stub

(define (next-object o)
  (if (>= (+ (object-a o) ANGULAR-SPEED) 360)
      (make-object (+ (object-s o) SQUARE-SIZE-INCREASE) ANGULAR-SPEED)
      (make-object (+ (object-s o) SQUARE-SIZE-INCREASE) (+ (object-a o) ANGULAR-SPEED))))

;; Object -> Image
;; Create red square with the appropriate angle of rotation at the appropriate place on MTS
(check-expect (render-object (make-object 10 5)) (place-image (rotate (remainder 5 360) (square 10 "solid" "red"))
                                                             CTR-X
                                                             CTR-Y
                                                             MTS))
(check-expect (render-object (make-object 20 80)) (place-image (rotate (remainder 80 360) (square 20 "solid" "red"))
                                                               CTR-X
                                                               CTR-Y
                                                               MTS))

; (define (render-object o) MTS) ;stub

(define (render-object o)
  (place-image (rotate (remainder (object-a o) 360) (square (object-s o) "solid" "red"))
               CTR-X
               CTR-Y
               MTS))


;; Object KeyEvent -> Object
;; reset object back to RED-SQUARE when space key is pressed
(check-expect (reset-object (make-object 60 50) " ") (make-object 5 0))
(check-expect (reset-object (make-object 60 50) "a") (make-object 60 50))


; (define (reset-object o key) o) ;stub

(define (reset-object o key)
  (cond [(key=? " " key) (make-object 5 0)]
        [else o]))
