; 
; PROBLEM:
; 
; Design a function that consumes a list of elements lox and a natural number
; n and produces the list formed by dropping every nth element from lox.
; 
; (dropn (list 1 2 3 4 5 6 7) 2) should produce (list 1 2 4 5 7)
; 
;; ============================================================================

;; (listof X) Natural -> (listof X)
;; produce list without the nth element
(check-expect (dropn (list 1 2 3 4 5 6 7) 2) (list 1 2 4 5 7))
(check-expect (dropn (list 1 2 3 4 5 6 7) 3) (list 1 2 3 5 6 7))

; (define (dropn lox n) empty) ;stub

(define (dropn lox0 n)
  ;; acc: Natural; 1-based position of (first lox) in lox0
  ;; (dropn (list 1 2 3 4 5 6 7) 2)
  ;; (dropn (list   2 3 4 5 6 7) 2)
  ;; (dropn (list     3 4 5 6 7) 2)
  (local [(define (dropn lox acc)
            (cond [(empty? lox) empty]
                  [else
                   (if (not (= acc n))
                       (cons (first lox)
                             (dropn (rest lox)
                                    (add1 acc)))
                       (dropn (rest lox)
                              0))]))]
    (dropn lox0 0)))
