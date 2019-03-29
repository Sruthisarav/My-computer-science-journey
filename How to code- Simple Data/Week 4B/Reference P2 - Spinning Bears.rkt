;; spinning-bears-starter.rkt

(require 2htdp/image)
(require 2htdp/universe)

; PROBLEM:
; 
; In this problem you will design another world program. In this program the changing 
; information will be more complex - your type definitions will involve arbitrary 
; sized data as well as the reference rule and compound data. But by doing your 
; design in two phases you will be able to manage this complexity. As a whole, this problem 
; will represent an excellent summary of the material covered so far in the course, and world 
; programs in particular.
; 
; This world is about spinning bears. The world will start with an empty screen. Clicking
; anywhere on the screen will cause a bear to appear at that spot. The bear starts out upright,
; but then rotates counterclockwise at a constant speed. Each time the mouse is clicked on the 
; screen, a new upright bear appears and starts spinning.
; 
; So each bear has its own x and y position, as well as its angle of rotation. And there are an
; arbitrary amount of bears.
; 
; To start, design a world that has only one spinning bear. Initially, the world will start
; with one bear spinning in the center at the screen. Clicking the mouse at a spot on the
; world will replace the old bear with a new bear at the new spot. You can do this part 
; with only material up through compound. 
; 
; Once this is working you should expand the program to include an arbitrary number of bears.
; 
; Here is an image of a bear for you to use: .


;; Constants:

(define WIDTH 1400)
(define HEIGHT 700)

(define CTR-Y (/ HEIGHT 2))
(define CTR-X (/ WIDTH 2))
(define BEAR .)

(define MTS (rectangle WIDTH HEIGHT "solid" "white"))
(define ANGULAR-SPEED 10)

;; Data definitions:
(define-struct bear (x y a))
;; Bear is (make-bear Natural[0, WIDTH], Natural[0, HEIGHT], Natural[0,360))
;; interp. (make-bear x y a) where
;; x is the x-coordinate of the bear
;; y is the y-coordinate of the bear
;; a is the angle of rotation of the bear
(define B0 (make-bear 0 0 0))
(define B1 (make-bear CTR-X CTR-Y 0))
#;
(define (fn-for-bear b)
  (... (bear-x b)
       (bear-y b)
       (bear-a b))) ;template

;; Template rules used:
;; compound: 3 fields
;; - atomic non-distinct: (bear-x b) is Natural
;; - atomic non-distinct: (bear-y b) is Natural
;; - atomic non-distinct: (bear-a b) is Natural

;; ListOfBear is one of:
;; - empty
;; - (cons Bear empty)

(define LOB0 empty)
(define LOB1 (cons (make-bear 100 20 0) empty)) 
(define LOB2 (cons (make-bear 50 40 50)
                      (cons (make-bear 300 100 250) empty)))
(define LOB3 (cons (make-bear CTR-X CTR-Y 0) empty))

#;
(define (fn-for-lob b)
  (cond [(empty? b) (...)]
        [else
         (... (fn-for-bear (first lob))
              (fn-for-lob (rest lob)))])) ;template

;; Template rules used:
;; - compound: 2 fields
;; - one of: 2 cases
;; - atomic distinct: empty
;; - reference: (first lob) is Bear
;; - self-reference: (rest lob) is ListOfBear


;; Functions:

;; Bear -> Bear
;; Bear is rotating in counterclockwise direction with constant angular speed in the middle of MTS
;; Starts the animation: start with (main (cons (make-bear CTR-X CTR-Y 0) empty))
(define (main b)
  (big-bang b
            (on-tick next-bears); Bear -> Bear
            (to-draw render-bears); Bear -> Image
            (on-mouse new-bear))); Bear Integer Integer MouseEvent -> Bear

;; Bear -> Bear
;; Decrease bear-a by ANGULAR-SPEED for all bears
(check-expect (next-bears (cons (make-bear CTR-X CTR-Y 40) empty)) (cons (make-bear CTR-X CTR-Y (- 40 ANGULAR-SPEED)) empty))
(check-expect (next-bears LOB2) (cons (make-bear 50 40 (- 50 ANGULAR-SPEED))
                      (cons (make-bear 300 100 (- 250 ANGULAR-SPEED)) empty)))
(check-expect (next-bears LOB3) (cons (make-bear CTR-X CTR-Y (- 360 ANGULAR-SPEED)) empty))

;(define (next-bear b) b) ;stub

; <Template from ListOfBear>

(define (next-bears lob)
  (cond [(empty? lob) lob]
        [else
         (cons (next-bear (first lob))
              (next-bears (rest lob)))]))

;; Bear -> Bear
;; Decrease bear-a by ANGULAR-SPEED
(check-expect (next-bear B1) (make-bear CTR-X CTR-Y (- 360 ANGULAR-SPEED)))

; <Template from Bear>
(define (next-bear b)
  (cond [(> (bear-a b) 0) (make-bear (bear-x b) (bear-y b) (- (bear-a b) ANGULAR-SPEED))]
        [else (make-bear (bear-x b) (bear-y b) (+ (- (bear-a b) ANGULAR-SPEED) 360))]))



;; Bear -> Image
;; Place appropriate images of all bears on MTS at (bear-x b), (bear-y b), and appropriate position at (bear-a b)
(check-expect (render-bears (cons (make-bear CTR-X 20 100) empty)) (place-image (rotate (modulo 100 360) BEAR)
                                                              CTR-X
                                                              20
                                                              MTS))
(check-expect (render-bears LOB2) (place-image (rotate (modulo 50 360) BEAR)
                                                 50
                                                 40
                                  (place-image (rotate (modulo 250 360) BEAR)
                                                 300
                                                 100
                                                 MTS)))
(check-expect (render-bears LOB3) (place-image (rotate (modulo 0 360) BEAR)
                                            CTR-X
                                            CTR-Y
                                            MTS))

; <Template from ListOfBear>

(define (render-bears lob)
  (cond [(empty? lob) MTS]
        [else
         (render-bear (first lob) (render-bears (rest lob)))]))
  
;; Bear -> Image
;; Place appropriate image of bear on MTS at (bear-x b), (bear-y b), and appropriate position at (bear-a b)
(check-expect (render-bear B1 MTS) (place-image (rotate (modulo (bear-a B1) 360) BEAR)
       (bear-x B1)
       (bear-y B1)
       MTS))

; (define (render-bear b) MTS) ;stub
; <Template from Bear>

(define (render-bear b image)
  (place-image (rotate (modulo (bear-a b) 360) BEAR)
       (bear-x b)
       (bear-y b)
       image))
  

;; Bear Integer Integer MouseEvent -> Bear
;; Replaces image of bear with a new one on MTS at the position where it is clicked
(check-expect (new-bear (cons (make-bear CTR-X CTR-Y 50) empty) 100 200 "button-down") (cons (make-bear 100 200 0) (cons (make-bear CTR-X CTR-Y 50) empty)))
(check-expect (new-bear (cons (make-bear CTR-X CTR-Y 20) empty) CTR-X CTR-Y "button-up") (cons (make-bear CTR-X CTR-Y 20) empty))
(check-expect (new-bear LOB2 50 50 "button-down") (cons (make-bear 50 50 0)
                                                           (cons (make-bear 50 40 50)
                                                                      (cons (make-bear 300 100 250) empty))))
(check-expect (new-bear LOB2 50 50 "button-up") (cons (make-bear 50 40 50)
                                                           (cons (make-bear 300 100 250) empty)))


(define (new-bear lob x y me)
  (cond [(mouse=? me "button-down") (cons (make-bear x y 0) lob)]
        [else lob]))
