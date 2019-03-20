;; HtDD Design Quiz

;; Age is Natural
;; interp. the age of a person in years
(define A0 18)
(define A1 25)

#;
(define (fn-for-age a)
  (... a))

;; Template rules used:
;; - atomic non-distinct: Natural


; Problem 1:
; 
; Consider the above data definition for the age of a person.
; 
; Design a function called teenager? that determines whether a person
; of a particular age is a teenager (i.e., between the ages of 13 and 19).

===================================================================================================

; Solution 1:
;; Age -> Boolean
;; Determine whether a person is a teenager or not
(check-expect(teenager? 12) false)
(check-expect (teenager? 13) true)
(check-expect (teenager? 15) true)
; (define (teenager? a) false) ;stub
(define (teenager? a)
        (if (and (>= a 13) (<= a 19))
            true
            false))

===================================================================================================

; Problem 2:
; 
; Design a data definition called MonthAge to represent a person's age
; in months.

===================================================================================================

; Solution 2:
;; MonthAge is Natural
;; interp. the age of a person in months
(define MA0 24)
(define MA1 120)

#;
(define (fn-for-month-age m)
  (... m))
;; Template rules used:
;; - atomic non-distinct: Natural

===================================================================================================

; Problem 3:
; 
; Design a function called months-old that takes a person's age in years 
; and yields that person's age in months.
; 

===================================================================================================

; Solution 3:
;; MonthAge -> Integer
;; Determine the person's age in months using the person's age in years
(check-expect(months-old 5) 60)
(check-expect (months-old 10) 120)
; (define (months-old m) 0) ;stub
(define (months-old m)
  (* m 12))

===================================================================================================

; Problem 4:
; 
; Consider a video game where you need to represent the health of your
; character. The only thing that matters about their health is:
; 
;   - if they are dead (which is shockingly poor health)
;   - if they are alive then they can have 0 or more extra lives
; 
; Design a data definition called Health to represent the health of your
; character.
; 
; Design a function called increase-health that allows you to increase the
; lives of a character.  The function should only increase the lives
; of the character if the character is not dead, otherwise the character
; remains dead.

===================================================================================================

; Solution 4:
;; Data definitions:
;; Health is one of:
;; - "dead"
;; - Natural
;; interp.
;;  Natural means the character is alive with how many extra lives
;;  "dead"  means the character is dead
(define Health1 0)      ;character is alive with 0 extra lives
(define Health2 3)      ;character is alive with 3 extra lives
(define Health3 "dead") ;chacracter is dead
#;
(define (health-of-character h)
  (cond [(and (number? h) (<= 0 h)) (... h)]
        [else (...)]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic non-distinct: Natural
;; - atomic distinct: "dead"

;; Functions:
;; Health -> Health
;; Increase the lives of a character unless it is already dead
(check-expect (increase-health 0) 1)
(check-expect (increase-health 10) 11)
(check-expect (increase-health "dead") "dead")

; (define (increase-heealth h) 0) ;stub
(define (increase-health h)
  (cond [(and (number? h) (<= 0 h)) (+ h 1)]
        [else "dead"]))
