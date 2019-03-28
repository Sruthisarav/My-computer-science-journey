;; double-starter.rkt

;; =====================================================================================
;; Data definitions:
; 
; Remember the data definition for a list of numbers we designed in Lecture 5f:
; (if this data definition does not look familiar, please review the lecture)
; 
;; ListOfNumber is one of:
;;  - empty
;;  - (cons Number ListOfNumber)
;; interp. a list of numbers
(define LON1 empty)
(define LON2 (cons 60 (cons 42 empty)))
#;
(define (fn-for-lon lon)
  (cond [(empty? lon) (...)]
        [else
         (... (first lon)
              (fn-for-lon (rest lon)))]))

;; Template rules used:
;;  - one of: 2 cases
;;  - atomic distinct: empty
;;  - compound: (cons Number ListOfNumber)
;;  - self-reference: (rest lon) is ListOfNumber

;; =====================================================================================
; 
; PROBLEM:
; 
; Design a function that consumes a list of numbers and doubles every number 
; in the list. Call it double-all.
; 
;; =====================================================================================

;; Functions:
;; ListOfNumber -> Number
;; Doubles every number in the list

; (define (double-lon lon) 0) ;stub
(check-expect (double-lon LON1) empty)
(check-expect (double-lon LON2) (cons (* 2 60) (cons (* 2 42) empty)))
(check-expect (double-lon (cons 50 empty)) (cons (* 2 50) empty))

;; <Template taken from ListOfNumber>
(define (double-lon lon)
  (cond [(empty? lon) empty]
        [else
         (cons (* 2 (first lon))
              (double-lon (rest lon)))]))
              
;; =====================================================================================
