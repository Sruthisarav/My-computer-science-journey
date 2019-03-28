;; largest-starter.rkt

;; ====================================================================
;; Data definitions:

; 
; Remember the data definition for a list of numbers we designed in Lecture 5f:
; (if this data definition does not look familiar, please review the lecture)
; 
;; ====================================================================

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

;; ====================================================================
; 
; PROBLEM:
; 
; Design a function that consumes a list of numbers and produces the largest number 
; in the list. You may assume that all numbers in the list are greater than 0. If
; the list is empty, produce 0.
; 
;; ====================================================================

;; Functions:
;; ListOfNumber -> Number
;; Finds the largest number in the list

;(define (largestnumber? lon) 0) ;stub

(check-expect (largest-number LON1) 0)
(check-expect (largest-number LON2) 60)
(check-expect (largest-number (cons 10 (cons 30 empty))) 30)

(define LargestNumber 0)
;; <Template taken from ListOfNumber>

(define (largest-number lon)
  (cond [(empty? lon) 0]
        [else
         (if (> (first lon) (largest-number (rest lon)))
             (first lon)
             (largest-number (rest lon)))]))

;; ====================================================================
