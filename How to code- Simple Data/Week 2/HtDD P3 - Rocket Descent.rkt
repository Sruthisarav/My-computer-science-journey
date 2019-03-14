; 
; PROBLEM A:
; 
; You are designing a program to track a rocket's journey as it descends 
; 100 kilometers to Earth. You are only interested in the descent from 
; 100 kilometers to touchdown. Once the rocket has landed it is done.
; 
; Design a data definition to represent the rocket's remaining descent. 
; Call it RocketDescent.
; 

;; =================
;; Data definitions:
;; RocketDescent is one of:
;; - Number (0, 100]
;; - "done"
;; interp.
;;   Number (0, 100]  means rocket is descending and how many kilometers away
;;   "done"            means rocket has landed
(define RD1 100)    ;rocket just started descending
(define RD2 0.1)    ;rocket is about to land
(define RD3 "done") ;rocket has landed
#;
(define (rocket-descent-to-ms d)
  (cond [(and (number? d) (< 0 d) (<= d 100)) (... d)]
        [else (...)]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic non-distinct: Natural (0, 100]
;; - atomic distinct: "done"

;; =================
; 
; PROBLEM B:
; 
; Design a function that will output the rocket's remaining descent distance 
; in a short string that can be broadcast on Twitter. 
; When the descent is over, the message should be "The rocket has landed!".
; Call your function rocket-descent-to-msg.
; 
;; =================
;; Functions:
;; RocketDescent -> string
;; Broadcast on twitter, the rocket's remaining descent distance or whether the rocket has landed
(check-expect (rocket-descent-to-msg 20) "The rocket is 20 kilometers away from landing!")
(check-expect (rocket-descent-to-msg "done") "The rocket has landed!")
(check-expect (rocket-descent-to-msg 0.1) "The rocket is 1/10 kilometers away from landing!")

;(define (rocket-descent-to-msg d) "") ;stub

; Use template from RocketDescent
(define (rocket-descent-to-msg d)
  (cond [(and (number? d) (< 0 d) (<= d 100)) (string-append "The rocket is " (number->string d) " kilometers away from landing!")]
        [else "The rocket has landed!"]))
