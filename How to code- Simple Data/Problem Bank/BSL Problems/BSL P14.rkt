; 
; PROBLEM:
; 
; Write an expression that uses star and overlay to produce an image similar to this:
; 
;                                   .
; You can consult the DrRacket help desk for information on how to use star and overlay. 
; Don't worry about the exact size of the stars.
; 
;; =======================================================================================

(require 2htdp/image)
(overlay (star 10 "solid" "blue")
         (star 25 "solid" "yellow")
         (star 40 "solid" "blue"))
