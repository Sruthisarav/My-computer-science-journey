(require 2htdp/image)
; 
; PROBLEM:
; 
; Use the built in version of filter to design a function called wide-only 
; that consumes a list of images and produces a list containing only those 
; images that are wider than they are tall.
; 
;; =========================================================================

;; (Image -> Boolean) (listof Image) -> (listof Image)
;; Produces a list of images that are wider than they are tall.
(check-expect (wide-only (list (square 10 "outline" "red")
                               (rectangle 10 20 "solid" "blue")))
              empty)
(check-expect (wide-only (list (square 10 "outline" "red")
                               (rectangle 30 20 "solid" "blue")))
              (list (rectangle 30 20 "solid" "blue")))
(check-expect (wide-only empty) empty)

; (define (wide-only loi) empty) ;stub

(define (wide-only loi)
  (local [(define (wide? i)
            (> (image-width i)
               (image-height i)))]
   (filter wide? loi)))
