; 
; PROBLEM:
; 
; DESIGN a function called yell that consumes strings like "hello" 
; and adds "!" to produce strings like "hello!".
; 
; Remember, when we say DESIGN, we mean follow the recipe.
; 
; Leave behind commented out versions of the stub and template.
; 
;; ==================================================================

;; String -> String
;; Adds "!" at the end of the string
(check-expect (add-string "Hello World") "Hello World!")
(check-expect (add-string "Welcome") "Welcome!")
(check-expect (add-string "Thank you") "Thank you!")

(define (add-string s)
  (string-append s "!"))
