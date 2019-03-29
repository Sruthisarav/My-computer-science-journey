(require 2htdp/image)

;; decreasing-image-starter.rkt

;  PROBLEM:
;  
;  Design a function called decreasing-image that consumes a Natural n and produces an image of all the numbers 
;  from n to 0 side by side. 
;  
;  So (decreasing-image 3) should produce .

;; ==============================================================================================================

;; Constants:

(define TEXT-COLOR "purple")
(define TEXT-SIZE 50)
(define SPACE (text " " TEXT-SIZE TEXT-COLOR))

;; Function:
;; Natural -> Image
;; produces images of numbers in decreasing order
(check-expect (decreasing-image 0) (text "0" TEXT-SIZE TEXT-COLOR))
(check-expect (decreasing-image 2) (beside (text "2" TEXT-SIZE TEXT-COLOR)
                                           (text "1" TEXT-SIZE TEXT-COLOR)
                                           (text "0" TEXT-SIZE TEXT-COLOR)))

; (define (decreasing-image n) empty-image) ;stub

(define (decreasing-image n)
  (cond [(zero? n) (text "0" TEXT-SIZE TEXT-COLOR)]
        [else
         (beside (text (number->string n) TEXT-SIZE TEXT-COLOR)
                 (decreasing-image (sub1 n)))]))
