(require 2htdp/image)
(require 2htdp/universe)

;; countdown-animation starter.rkt

; 
; PROBLEM:
; 
; Design an animation of a simple countdown. 
; 
; Your program should display a simple countdown, that starts at ten, and
; decreases by one each clock tick until it reaches zero, and stays there.
; 
; To make your countdown progress at a reasonable speed, you can use the 
; rate option to on-tick. If you say, for example, 
; (on-tick advance-countdown 1) then big-bang will wait 1 second between 
; calls to advance-countdown.
; 
; Remember to follow the HtDW recipe! Be sure to do a proper domain 
; analysis before starting to work on the code file.
; 
; Once you are finished the simple version of the program, you can improve
; it by reseting the countdown to ten when you press the spacebar.
; 


;; Countdown

;; =================
;; Constants:
(define WIDTH 600)
(define HEIGHT 400)
(define CTR-Y (/ HEIGHT 2))
(define CTR-X (/ WIDTH 2))
(define MTS (empty-scene WIDTH HEIGHT))
(define SPEED 1)
(define TEXT-SIZE 150)
(define TEXT-COLOUR "blue")

;; =================
;; Data definitions:

;; Countdown is Natural
;; interp. the time taken to reach 0
(define t0 10)
(define t1 5)
(define t2 0)
#;
(define (fn-for-countdown t) 
  (... t))

;; Template rules used:
;; - atomic non-distinct: Natural

;; =================
;; Functions:

;; Countdown -> Countdown
;; Countdown starts from 10.
;; 
(define (main t)
  (big-bang t                                 ; Countdown
            (on-tick advance-countdown SPEED) ; Countdown -> Countdown
            (to-draw render-countdown)        ; Countdown -> Image
            (on-key handle-key)))             ; Countdown KeyEvent -> Countdown

;; Countdown -> Countdown
;; advances the countdown by subtracting 1, if the countdown is zero it remains at zero
(check-expect (advance-countdown 10) 9)
(check-expect (advance-countdown 0) 0)
;(define (advance-cat t) 0) ;stub
;<use template from Countdown>

(define (advance-countdown t) 
  (if (= t 0)
      0
      (- t 1)))

;; Countdown -> Image
;; renders the number at appropriate place on MTS
(check-expect (render-countdown 9) (place-image (text (number->string 9) TEXT-SIZE TEXT-COLOUR)
                                                CTR-X
                                                CTR-Y
                                                MTS))
; (define (render-countdown t) MTS) ;stub
;<use template from Countdown>

(define (render-countdown t) 
  (place-image (text (number->string t) TEXT-SIZE TEXT-COLOUR)
                                                CTR-X
                                                CTR-Y
                                                MTS))

;; Countdown KeyEvent -> Countdown
;; resets countdown when space key is pressed
(check-expect (handle-key 10 " ") 0)
(check-expect (handle-key 10 "a") 10)
(check-expect (handle-key 0 " ") 0)
(check-expect (handle-key 0 "a") 0)
;(define (handle-key t ke) 0) ;stub
;<use template from Countdown>

(define (handle-key t ke) 
  (cond [(key=? ke " ") 0]
        [else t]))
