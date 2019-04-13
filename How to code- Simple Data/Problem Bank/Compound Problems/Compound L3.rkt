; 
; PROBLEM:
; 
; As we learned in the cat world programs, cats have a mind of their own. When they 
; reach the edge they just keep walking out of the window.
; 
; Cows on the other hand are docile creatures. They stay inside the fence, walking
; back and forth nicely.
; 
; Design a world program with the following behaviour:
;    - A cow walks back and forth across the screen.
;    - When it gets to an edge it changes direction and goes back the other way
;    - When you start the program it should be possible to control how fast a
;      walker your cow is.
;    - Pressing space makes it change direction right away.
;    
; To help you here are two pictures of the right and left sides of a lovely cow that 
; was raised for us at Brown University.
; 
; .     .
; 
; Once your program works here is something you can try for fun. If you rotate the
; images of the cow slightly, and you vary the image you use as the cow moves, you
; can make it appear as if the cow is waddling as it walks across the screen.
; 
; Also, to make it look better, arrange for the cow to change direction when its
; nose hits the edge of the window, not the center of its body.
; 
;; ===========================================================================================

(require 2htdp/image)
(require 2htdp/universe)

;; Constants:

(define WIDTH 600)
(define HEIGHT 400)
(define CTR-Y (/ HEIGHT 2))
(define RIGHT-COW-IMG . )
(define LEFT-COW-IMG .)
(define MTS (rectangle WIDTH HEIGHT "solid" "white"))
(define SPEED 5)

;; Data definitions:

(define-struct cow (x b))
;; Cow is (make-cow Natural[0, WIDTH], Boolean)
;; interp. (make-cow x b) is a cow with x-coordinates, and the direction the cow is moving in
;;         x is the screen coordinates (pixels)
;;         b is the direction in which the cow is moving in, where true means to the right and false means to the left of the screen
(define C1 (make-cow 10 true))  ; at 10, cow moving to the right
(define C2 (make-cow 50 false)) ; at 50, cow moving to the left

#;
(define (fn-for-cow c)
  (... (cow-x c)
       (cow-b c))) ;template


;; Template rules used:
;; - compound: 2 fields

;; Functions:

;; Cow -> Cow
;; Start with cow moving to the right from the left side of the screen: (main (make-cow 0 true))

(define (main c)
  (big-bang c                ; Cow
    (on-tick advance-cow)    ; Cow -> Cow
    (to-draw render-cow)     ; Cow -> Image
    (on-key reset-cow)))     ; Cow KeyEvent -> Cow

;; Cow -> Cow
;; produces the next cow
(check-expect (advance-cow (make-cow 10 true)) (make-cow (+ 10 SPEED) true))
(check-expect (advance-cow (make-cow 0 false)) (make-cow (+ 0 SPEED) true))
(check-expect (advance-cow (make-cow WIDTH true)) (make-cow (- WIDTH SPEED) false))
(check-expect (advance-cow (make-cow 10 false)) (make-cow (- 10 SPEED) false))

; (define (advance-cow c) c) ;stub

(define (advance-cow c)
  (cond[(false? (cow-b c))(if (= (cow-x c) 0)
                              (make-cow SPEED true)
                              (make-cow (- (cow-x c) SPEED) false))]
       [else (if (= (cow-x c) WIDTH)
                 (make-cow (- WIDTH SPEED) false)
                 (make-cow (+ (cow-x c) SPEED) true))]))

;; Cow -> Image
;; Renders the appropriate image of the cow on screen
(check-expect (render-cow (make-cow 50 true)) (place-image RIGHT-COW-IMG
                                                           50
                                                           CTR-Y
                                                           MTS))
(check-expect (render-cow (make-cow 100 false)) (place-image LEFT-COW-IMG
                                                             100
                                                             CTR-Y
                                                             MTS))

; (define (render-cow c) MTS) ;stub

(define (render-cow c)
  (cond [(false? (cow-b c))
         (place-image LEFT-COW-IMG
                      (cow-x c)
                      CTR-Y
                      MTS)]
        [else (place-image RIGHT-COW-IMG
                           (cow-x c)
                           CTR-Y
                           MTS)]))


;; Cow KeyEvent -> Cow
;; Change the direction of the cow whenever space key is pressed
(check-expect (reset-cow (make-cow 10 true) " ") (make-cow 10 false))
(check-expect (reset-cow (make-cow 50 false) " ") (make-cow 50 true))
(check-expect (reset-cow (make-cow 10 true) "a") (make-cow 10 true))
(check-expect (reset-cow (make-cow 50 false) "b") (make-cow 50 false))

; (define (reset-cow c key) c) ;stub

(define (reset-cow c key)
  (cond [(key=? " " key)
         (if (false? (cow-b c))
             (make-cow (cow-x c) true)
             (make-cow (cow-x c) false))]
        [else c]))

