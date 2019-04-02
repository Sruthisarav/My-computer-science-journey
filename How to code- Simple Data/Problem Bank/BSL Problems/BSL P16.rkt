; 
; PROBLEM:
; 
; Given the following function definition:
; 
; (define (foo s)
;   (if (string=? (substring s 0 1) "a")
;       (string-append s "a")
;       s))
; 
; Write out the step-by-step evaluation of the expression: 
; 
; (foo (substring "abcde" 0 3))
; 
; Be sure to show every intermediate evaluation step.
; 
;; =========================================================

(foo (substring "abcde" 0 3))

(foo ("abc"))

(define (foo "abc")
  (if (string=? (substring "abc" 0 1) "a")
      (string-append "abc" "a")
      s))

(define (foo "abc")
  (if (string=? "a" "a")
      (string-append "abc" "a")
      s))

(define (foo "abc")
  (if true
      (string-append "abc" "a")
      s))

(string-append "abc" "a")

("abca")
