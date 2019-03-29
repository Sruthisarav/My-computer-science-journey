;; odd-from-n-starter.rkt

;  PROBLEM:
;  
;  Design a function called odd-from-n that consumes a natural number n, and produces a list of all 
;  the odd numbers from n down to 1. 
;  
;  Note that there is a primitive function, odd?, that produces true if a natural number is odd.
;  
;; =====================================================================================================

;; Functions
;; Natural -> ListOfOddNumbers
;; produces all the odd numbers from n down to 1
(check-expect (odd-from-n 10) (cons 9
                                    (cons 7
                                          (cons 5
                                                (cons 3
                                                      (cons 1 empty))))))
(check-expect (odd-from-n 2) (cons 1 empty))
(check-expect (odd-from-n 0) empty)

; (define (odd-from-n n) empty) ;stub

(define (odd-from-n n)
  (cond [(zero? n) empty]
        [(odd? n) (cons n (odd-from-n (- n 1)))]
        [else
         (odd-from-n (- n 1))]))
