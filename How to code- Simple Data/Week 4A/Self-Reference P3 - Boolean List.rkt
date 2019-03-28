;; boolean-list-starter.rkt
;; ===================================================
; 
; PROBLEM A:
; 
; Design a data definition to represent a list of booleans. Call it ListOfBoolean. 
; 
;; ===================================================

;; Data definitions:
;
;;  ListOfBoolean is one of:
;; - empty
;; - (cons Boolean ListOfBoolean)
;; interpret. a list of Booleans

(define LOB1 empty)
(define LOB2 (cons true (cons false empty)))

#;
(define (fn-for-lon lon)
  (cond [(empty? lon) (...)]
        [else
         (... (first lon)
              (fn-for-lon (rest lon)))]))

;;Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons Boolean ListOfBoolean)
;; - self-reference: (rest lon) is ListOfBoolean

;; ===================================================
; 
; PROBLEM B:
; 
; Design a function that consumes a list of boolean values and produces true 
; if every value in the list is true. If the list is empty, your function 
; should also produce true. Call it all-true?
; 
;; ===================================================

;; Functions:
;; ListOfBoolean -> Boolean
;; Checks if all boolean values are true/empty or false

; (define (all-true? lon) false) ;stub
(check-expect (all-true? LOB1) true)
(check-expect (all-true? LOB2) false)
(check-expect (all-true? (cons true empty)) true)
(check-expect (all-true? (cons true (cons true empty))) true)
(check-expect (all-true? (cons false empty)) false)
(check-expect (all-true? (cons false (cons true empty))) false)
(check-expect (all-true? (cons false (cons false empty))) false)

;; <Template taken from ListOfBoolean>
(define (all-true? lon)
  (cond [(empty? lon)
         true]
        [(false? (first lon))
         false]
        [else (all-true? (rest lon))]))
