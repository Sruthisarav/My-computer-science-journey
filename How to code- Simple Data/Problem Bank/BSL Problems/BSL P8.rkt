; 
; PROBLEM:
; 
; The background for the Canadian Flag (without the maple leaf) is this:
;          .
;          
; Write an expression to produce that background. (If you want to get the
; details right, officially the overall flag has proportions 1:2, and the 
; band widths are in the ratio 1:2:1.)
; 
; 
;; =======================================================================

(require 2htdp/image)
(beside
 (rectangle 30 60 "solid" "red")
 (rectangle 60 60 "solid" "white")
 (rectangle 30 60 "solid" "red"))
