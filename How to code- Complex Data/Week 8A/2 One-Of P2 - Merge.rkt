; Problem:
; 
; Design the function merge. It consumes two lists of numbers, which it assumes are 
; each sorted in ascending order. It produces a single list of all the numbers, 
; also sorted in ascending order. 
; 
; Your solution should explicitly show the cross product of type comments table, 
; filled in with the values in each case. Your final function should have a cond 
; with 3 cases. You can do this simplification using the cross product table by 
; recognizing that there are subtly equal answers. 
; 
; Hint: Think carefully about the values of both lists. You might see a way to 
; change a cell content so that 2 cells have the same value.
; 
;; ===================================================================================

;; Data definitions:

;; ListOfNumber is one of:
;; - empty
;; - (cons Integer ListOfNumber)
;; interp. a list of numbers

(define LON0 empty)
(define LON1 (cons 1 (cons 2 empty)))
(define LON2 (cons 3 (cons 5 (cons 7 empty))))
(define LON3 (cons 2 (cons 4 (cons 6 (cons 8 empty)))))

#;
(define (fn-for-lon lon)
  (cond [(empty? lon) (...)]
        [else
         (... (first lon)
              (fn-for-lon (rest lon)))]))

;; Functions:

;; ListOfNumber ListOfNumber -> ListOfNumber
;; produces a single list of all numbers, sorted in ascending order, given two lists
(check-expect (merge-list LON0 LON1) LON1)
(check-expect (merge-list LON0 LON0) empty)
(check-expect (merge-list LON1 LON2) (cons 1 (cons 2 (cons 3 (cons 5 (cons 7 empty))))))
(check-expect (merge-list LON2 LON3) (cons 2 (cons 3 (cons 4 (cons 5 (cons 6 (cons 7 (cons 8 empty))))))))

; (define (merge-list lon1 lon2) empty) ;stub

(define (merge-list lon1 lon2)
  (cond [(empty? lon1) lon2]
        [(empty? lon2) lon1]
        [else (if (< (first lon1) (first lon2))
                  (cons (first lon1) (merge-list (rest lon1) lon2))
                  (cons (first lon2) (merge-list lon1 (rest lon2))))]))
