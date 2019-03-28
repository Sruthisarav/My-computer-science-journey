(require 2htdp/image)

;; image-list-starter.rkt

;; ====================================================================
; 
; PROBLEM A:
; 
; Design a data definition to represent a list of images. Call it ListOfImage. 
;
;; ====================================================================

;; Data definitions:
;
;; ListOfImage is one of:
;; - empty
;; - (cons Image ListOfImage)
;; interp. a list of images
(define LOI1 empty)
(define LOI2 (cons (rectangle 30 40 "solid" "black") empty))
(define LOI3 (cons (rectangle 30 30 "solid" "green") empty))
(define LOI4 (cons (rectangle 30 2 "solid" "green") empty))
(define LOI5 (cons (rectangle 30 40 "solid" "purple") (cons (rectangle 20 2 "solid" "blue") empty)))
#;
(define (fn-for-image lon)
  (cond [(empty? lon) (...)]
        [else
         (... (first lon)
              (fn-for-image (rest lon)))]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cond Image ListOfImage)
;; - self-reference: (rest lon) is ListOfImage 

;; ====================================================================
; 
; PROBLEM B:
; 
; Design a function that consumes a list of images and produces a number 
; that is the sum of the areas of each image. For area, just use the image's 
; width times its height.
; 

;; ====================================================================

;; Functions:
;; ListOfImage -> Number
;; Sum of areas of all images in the list

;(define (all-area lon) 0) ;stub
(check-expect (all-area LOI1) 0)
(check-expect (all-area LOI2) (* 30 40))
(check-expect (all-area LOI3) (* 30 30))
(check-expect (all-area LOI4) (* 30 2))
(check-expect (all-area LOI5) (+ (* 30 40) (* 20 2)))

;; <Template taken from ListOfImage>
(define (all-area lon)
  (cond [(empty? lon) 0]
        [else
         (+ (* (image-width (first lon)) (image-height (first lon)))
              (all-area (rest lon)))]))
              
;; ====================================================================
