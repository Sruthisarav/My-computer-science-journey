; 
; PROBLEM:
; 
; Design a function called average that consumes (listof Number) and produces the
; average of the numbers in the list.
; 
;; ================================================================================

;; (listof Number) -> Number
;; produces the average of numbers in the list
(check-expect (average (list 1 2 3 4)) 2.5)
(check-expect (average (list 2 3 4 5 6)) 4)

; (define (average lon) 0) ;stub

(define (average lon)
  ;; count: the position of the number in the list
  ;; sum: sum of the numbers so far
  ;; (average (list 1 2 3 4) 0 0)
  ;; (average (list   2 3 4) 1 1)
  ;; (average (list     3 4) 2 3)
  ;; (average (list       4) 3 6)
  ;; (average (list        ) 4 10)
  (local [(define (average lon count sum)
            (cond [(empty? lon) (/ sum count)]
                  [else
                   (average (rest lon)
                            (add1 count)
                            (+ (first lon) sum))]))]
    (average lon 0 0)))
