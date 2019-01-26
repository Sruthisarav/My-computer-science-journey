;; String -> Boolean
;; Checks if length of string is less than 5
(check-expect (stringLength "four") true)
(check-expect (stringLength "vixen") false)
(check-expect (stringLength "fives") false)
;; (define (stringLength s) False)
;; (define (stringLength s)
;;   (...s))
(define (stringLength s)
  (if (< (string-length s) 5)
      true
      false))
