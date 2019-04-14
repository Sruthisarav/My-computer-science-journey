; 
; PROBLEM:
; 
; Design a world program as follows:
; 
; The world starts off with a lambda on the left hand side of the screen. As 
; time passes, the lambda will roll towards the right hand side of the screen. 
; Clicking the mouse changes the direction the lambda is rolling (ie from 
; left -> right to right -> left). If the lambda hits the side of the window 
; it should also change direction.
;
; NOTE 1: Remember to follow the HtDW recipe! Be sure to do a proper domain 
; analysis before starting to work on the code file.
; 
; NOTE 2: DO THIS PROBLEM IN STAGES.
; 
; FIRST
; 
; Just make the lambda slide back and forth across the screen without rolling.
;       
; SECOND
;   
; Make the lambda spin as it slides, but don't worry about making the spinning
; be just exactly right to make it look like its rolling. Just have it 
; spinning and sliding back and forth across the screen.
; 
; FINALLY
; 
; Work out the math you need to in order to make the lambda look like it is
; actually rolling.  Remember that the circumference of a circle is 2*pi*radius,
; so that for each degree of rotation the circle needs to move:
; 
;    2*pi*radius
;    -----------
;        360
; 
; Also note that the rotate function requires an angle in degrees as its 
; first argument. [By that it means Number[0, 360). As time goes by the lambda
; may end up spinning more than once, for example, you may get to a point 
; where it has spun 362 degrees, which rotate won't accept. One solution to 
; that is to  use the modulo function as follows:
; 
; (rotate (modulo ... 360) LAMBDA)
; 
; where ... can be an expression that produces any positive number of degrees 
; and remainder will produce a number in [0, 360).
; 
; Remember that you can lookup the documentation of modulo if you need to know 
; more about it.
; 
;; =======================================================================================

(require 2htdp/image)
(require 2htdp/universe)

;; Constants:

(define WIDTH 1200)
(define HEIGHT 800)

(define BALL-RADIUS 100)
(define BALL (overlay (rectangle 80 20 "solid" "blue")
                      (rectangle 20 80 "solid" "blue")
                      (circle BALL-RADIUS "solid" "pink")))

(define CTR-Y (/ HEIGHT 2))
(define MTS (rectangle WIDTH HEIGHT "solid" "white"))

(define ANGULAR-SPEED 5)
(define BALL-SPEED (* ANGULAR-SPEED (/ (* 2 3.142 BALL-RADIUS) 360)))

;; Data definitions:
(define-struct ball (x a d))
;; Ball is (make-ball Natural[0, WIDTH] Natural[0, 360) Boolean)
;; interp. (make-ball x a) is a ball with x-coordinates, x and angle of rotation, a and the direction of ball.
;;         x is the x-coordinates of the ball on the screen (in pixels)
;;         a is the angle of rotation of the ball (in degrees)
;;         d is a boolean whcih determines whether the ball is moving right(true) or left(false)
(define B1 (make-ball 20 50 true))   ;ball with angle of 50 degrees and x-ccordinates of 50 and is moving to the right
(define B2 (make-ball 100 120 false));ball with angle of 120 degrees and x-ccordinates of 100 and is moving to the left

#;
(define (fn-for-ball b)
  (... (ball-x b)
       (ball-a b)
       (ball-d b))) ;template

;; Template rules used:
;; Compound: 3 fields

;; Functions:

;; Ball -> Ball
;; Starts off with a ball on the left hand side of the screen; start with (main (make-ball 0 0 true))

(define (main b)
  (big-bang b             ;; Ball
    (on-tick next-ball)   ;; Ball -> Ball
    (to-draw render-ball) ;; Ball -> Image
    (on-mouse new-ball))) ;; Ball Integer Integer BallEvent -> Ball

;; Ball -> Ball
;; Increase x by BALL-SPEED and a by angular speed
(check-expect (next-ball (make-ball 20 50 true)) (make-ball (+ 20 BALL-SPEED) (+ 50 ANGULAR-SPEED) true))
(check-expect (next-ball (make-ball 20 50 false)) (make-ball (- 20 BALL-SPEED) (- 50 ANGULAR-SPEED) false))
(check-expect (next-ball (make-ball 20 360 true)) (make-ball (+ 20 BALL-SPEED) ANGULAR-SPEED true))
(check-expect (next-ball (make-ball WIDTH 50 true)) (make-ball (- WIDTH BALL-SPEED) (- 50 ANGULAR-SPEED) false))
(check-expect (next-ball (make-ball (/ WIDTH 2) 40 false)) (make-ball (- (/ WIDTH 2) BALL-SPEED) (- 40 ANGULAR-SPEED) false))

; (define (next-ball b) b) ;stub

(define (next-ball b)
  (cond [(>= (ball-x b) WIDTH)
         (if (<= (ball-a b) 0)
             (make-ball (- (ball-x b) BALL-SPEED) (- 360 ANGULAR-SPEED) false)
             (make-ball (- (ball-x b) BALL-SPEED) (- (ball-a b) ANGULAR-SPEED) false))]
        [(<= (ball-x b) 0)
         (if (>= (ball-a b) 360)
             (make-ball (+ (ball-x b) BALL-SPEED) (+ 0 ANGULAR-SPEED) true)
             (make-ball (+ (ball-x b) BALL-SPEED) (+ (ball-a b) ANGULAR-SPEED) true))]
        [(and (<= (ball-a b) 0)(false? (ball-d b)))
         (make-ball (- (ball-x b) BALL-SPEED) (- 360 ANGULAR-SPEED) false)]
        [(>= (ball-a b) 360)
         (make-ball (+ (ball-x b) BALL-SPEED) ANGULAR-SPEED true)]
        [else
         (if (false? (ball-d b))
             (make-ball (- (ball-x b) BALL-SPEED) (- (ball-a b) ANGULAR-SPEED) false)
             (make-ball (+ (ball-x b) BALL-SPEED) (+ (ball-a b) ANGULAR-SPEED) true))]))

;; Ball -> Image
;; Renders the image of ball on MTS with appropriate angle of rotation and at the appropriate place
(check-expect (render-ball (make-ball 50 60 true)) (place-image (rotate (modulo 60 360) BALL)
                                                                50
                                                                CTR-Y
                                                                MTS))
(check-expect (render-ball (make-ball 50 60 false)) (place-image (rotate (modulo 60 360) BALL)
                                                                50
                                                                CTR-Y
                                                                MTS))
(check-expect (render-ball (make-ball 150 120 true)) (place-image (rotate (modulo 120 360) BALL)
                                                                150
                                                                CTR-Y
                                                                MTS))

; (define (render-ball b) MTS) ;stub

(define (render-ball b)
  (place-image (rotate (modulo (ball-a b) 360) BALL)
               (ball-x b)
               CTR-Y
               MTS))

;; Ball Integer Integer BallEvent
;; Clicking the mouse changes the direction the ball is rolling 
(check-expect (new-ball (make-ball 50 60 false) 70 50 "button-down") (make-ball 50 60 true))
(check-expect (new-ball (make-ball 50 60 true) 70 50 "button-down") (make-ball 50 60 false))
(check-expect (new-ball (make-ball 50 60 false) 70 50 "button-up") (make-ball 50 60 false))

; (define (new-ball b x y me) b) ;stub

(define (new-ball b x y me)
  (cond [(mouse=? me "button-down")
         (if (false? (ball-d b))
             (make-ball (ball-x b) (ball-a b) true)
             (make-ball (ball-x b) (ball-a b) false))]
        [else b]))
