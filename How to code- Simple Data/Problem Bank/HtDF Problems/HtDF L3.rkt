; 
; PROBLEM:
; 
; DESIGN a function called image-area that consumes an image and produces the 
; area of that image. For the area it is sufficient to just multiple the image's 
; width by its height.  Follow the HtDF recipe and leave behind commented 
; out versions of the stub and template.
; 
;; ==============================================================================

(require 2htdp/image)

;; Image -> Integer
;; Find the area of a given image
(check-expect (image-area (rectangle 20 15 "solid" "grey")) (* 20 15))
(check-expect (image-area (rectangle 20 10 "solid" "black")) (* 20 10))
(check-expect (image-area (square 10 "solid" "green")) (* 10 10))

; (define (image-area i) 0) ;stub

(define (image-area i)
  (* (image-height i) (image-width i)))
