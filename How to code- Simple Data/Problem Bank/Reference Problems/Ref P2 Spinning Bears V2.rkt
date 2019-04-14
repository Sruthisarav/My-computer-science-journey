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
;; ==================================================================================================

(require 2htdp/image)
(require 2htdp/universe)

;; Constants:

(define HEIGHT 800)
(define WIDTH 1200)

(define MTS (empty-scene WIDTH HEIGHT))
(define CTR-X (/ WIDTH 2))
(define CTR-Y (/ HEIGHT 2))

(define BEAR-IMAGE .)

(define ANGULAR-SPEED 5)

;; Data definitions:

(define-struct bear (x y angle next))
;; ListOfBear is one of:
;; - (make-bear Natural[0, WIDTH] Natural[0, HEIGHT] Natural[0, 360) false)
;; - (make-bear Natural[0, WIDTH] Natural[0, HEIGHT] Natural[0, 360) Bear)
;; interpret. an arbitrary number of bears, where for each bear we have its:
;;            x-coordinates on the screen, x
;;            y-coordinates on the screen, y
;;            angle of rotation, a
(define LOB1 (make-bear 50 60 120 false))
(define LOB2 (make-bear 10 20 30
                      (make-bear 40 50 60 false)))
(define LOB3 (make-bear 10 20 30
                      (make-bear 40 50 60
                                 (make-bear 70 80 90 false))))
(define LOB4 (make-bear CTR-X CTR-Y 0 false))
#;
(define (fn-for-lob lob)
  (cond [(false? lob) (...)]
        [else
         (... (bear-x lob)
              (bear-y lob)
              (bear-angle lob)
              (fn-for-bear (bear-next lob)))]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: false
;; - compound: (make-bear Natural[0, WIDTH] Natural[0, HEIGHT] Natural[0, 360) Bear)
;; - atomic non-distinct: (bear-x b) is Natural[0, WIDTH]
;; - atomic non-distinct: (bear-y b) is Natural[0, HEIGHT]
;; - atomic non-diistinct: (beay-angle b) is Natural[0, 360)
;; - self-reference (bear-next b) is Bear

;; Functions:

;; Bear -> Bear
;; Starts off with Bear in the middle of the screen spinning in clockwise direction; start with (main LOB4)
;; no tests for main function
(define (main b)
  (big-bang b              ; ListOfBear
    (on-tick next-bears)   ; ListOfBear -> ListOfBear
    (to-draw render-bears) ; ListOfBear -> Image
    (on-mouse new-bears))) ; ListOfBeat Integer Integer MouseEvent -> ListOfBear

;; ListOfBear -> ListOfBear
;; Increase angle by ANGULAR-SPEED for all bears
(check-expect (next-bears LOB1) (make-bear 50 60 (+ 120 ANGULAR-SPEED) false))
(check-expect (next-bears LOB2) (make-bear 10 20 (+ 30 ANGULAR-SPEED)
                                           (make-bear 40 50 (+ 60 ANGULAR-SPEED) false)))
(check-expect (next-bears LOB3) (make-bear 10 20 (+ 30 ANGULAR-SPEED)
                                           (make-bear 40 50 (+ 60 ANGULAR-SPEED)
                                                      (make-bear 70 80 (+ 90 ANGULAR-SPEED) false))))

; (define (next-bears lob) lob) ;stub

(define (next-bears lob)
  (cond [(false? lob) false]
        [else
         (make-bear (bear-x lob)
                    (bear-y lob)
                    (next-bear(bear-angle lob))
                    (next-bears (bear-next lob)))]))

;; Integer -> Integer
;; Increase a by ANGULAR-SPEED
(check-expect (next-bear 120) (+ 120 ANGULAR-SPEED))

(define (next-bear a)
  (if (>= a 360)
      ANGULAR-SPEED
      (+ a ANGULAR-SPEED)))


;; ListOfBear -> Image
;; Place appropriate images of bears on MTS at appropriate place
(check-expect (render-bears LOB1) (place-image (rotate (modulo 120 360) BEAR-IMAGE)
                                               50
                                               60
                                               MTS))
(check-expect (render-bears LOB2) (place-image (rotate (modulo 30 360) BEAR-IMAGE)
                                               10
                                               20
                                               (place-image (rotate (modulo 60 360) BEAR-IMAGE)
                                                            40
                                                            50
                                                            MTS)))
(check-expect (render-bears LOB3) (place-image (rotate (modulo 30 360) BEAR-IMAGE)
                                               10
                                               20
                                               (place-image (rotate (modulo 60 360) BEAR-IMAGE)
                                                            40
                                                            50
                                                            (place-image (rotate (modulo 90 360) BEAR-IMAGE)
                                                                         70
                                                                         80
                                                                         MTS))))

; (define (render-bears lob) lob) ;stub

(define (render-bears lob)
  (cond [(false? lob) MTS]
        [else
         (place-image (rotate (modulo (bear-angle lob) 360) BEAR-IMAGE)
                      (bear-x lob)
                      (bear-y lob)
                      (render-bears (bear-next lob)))]))

;; ListOfBeat Integer Integer MouseEvent -> ListOfBear
;; Create new bears at the places the mouse clicked
(check-expect (new-bears LOB1 100 120 "button-down") (make-bear 100 120 0
                                                                (make-bear 50 60 120 false)))
(check-expect (new-bears LOB2 400 500 "button-down") (make-bear 400 500 0
                                                                (make-bear 10 20 30
                                                                           (make-bear 40 50 60 false))))
(check-expect (new-bears LOB3 500 400 "button-down") (make-bear 500 400 0
                                                                (make-bear 10 20 30
                                                                           (make-bear 40 50 60
                                                                                      (make-bear 70 80 90 false)))))
(check-expect (new-bears LOB1 100 120 "button-up") (make-bear 50 60 120 false))

; (define (new-bears lob x y me) lob) ;stub

(define (new-bears lob x y me)
  (cond [(mouse=? me "button-down")
         (make-bear x y 0 lob)]
        [else lob]))
