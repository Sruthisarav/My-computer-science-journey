(require 2htdp/image)
;; alternative-tuition-graph-starter.rkt

; 
; Consider the following alternative type comment for Eva's school tuition 
; information program. Note that this is just a single type, with no reference, 
; but it captures all the same information as the two types solution in the 
; videos.
; 
; (define-struct school (name tuition next))
; ;; School is one of:
; ;;  - false
; ;;  - (make-school String Natural School)
; ;; interp. an arbitrary number of schools, where for each school we have its
; ;;         name and its tuition in USD
; 
; (A) Confirm for yourself that this is a well-formed self-referential data 
;     definition.
; 
; (B) Complete the data definition making sure to define all the same examples as 
;     for ListOfSchool in the videos.
; 
; (C) Design the chart function that consumes School. Save yourself time by 
;     simply copying the tests over from the original version of chart.
; 
; (D) Compare the two versions of chart. Which do you prefer? Why?
; 
; ===================================================================================================================

;; Data definitions:

(define-struct school (name tuition next))
;; School is one of:
;;  - false
;;  - (make-school String Natural School)
;; interp. an arbitrary number of schools, where for each school we have its
;;         name and its tuition in USD
(define S1 (make-school "School1" 27797 false))
(define S2 (make-school "School1" 27797
                        (make-school "School2" 23300 false)))
(define S3 (make-school "School1" 27797
                        (make-school "School2" 23300
                                     (make-school "School3" 28500 false))))
(define S4 false)

#;
(define (fn-for-school s)
  (cond [(false? s) (...)]
        [else
         (... (school-name s)
              (school-tuition s)
              (fn-for-school (school-next s)))]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: false
;; - compound: (make-school String Natural School)
;; - atomic non-distinct: (school-name s) is String
;; - atomic non-distinct: (school-tuition s) is Natural
;; - self-reference (school-next s) is School


;; Constants:

(define FONT-SIZE 20)
(define FONT-COLOR "purple")

(define Y-SCALE 1/300)
(define BAR-WIDTH 30)
(define BAR-COLOR "lightblue")

;; Functions:

;; School -> Image
;; Produces a bar chart that shows the names and tuitions of schools listed
(check-expect (plot S1)
              (beside/align "bottom"
                      (overlay/align "center" "bottom"
                                     (rotate 90 (text (school-name S1) FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* (school-tuition S1) Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* (school-tuition S1) Y-SCALE) "solid" BAR-COLOR))
                      (square 0 "solid" "white")))
(check-expect (plot S2)
              (beside/align "bottom"
                      (overlay/align "center" "bottom"
                                     (rotate 90 (text "School1" FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* 27797 Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* 27797 Y-SCALE) "solid" BAR-COLOR))
                      (overlay/align "center" "bottom"
                                     (rotate 90 (text "School2" FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* 23300 Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* 23300 Y-SCALE) "solid" BAR-COLOR))
                      (square 0 "solid" "white")))
(check-expect (plot S3)
              (beside/align "bottom"
                      (overlay/align "center" "bottom"
                                     (rotate 90 (text "School1" FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* 27797 Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* 27797 Y-SCALE) "solid" BAR-COLOR))
                      (overlay/align "center" "bottom"
                                     (rotate 90 (text "School2" FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* 23300 Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* 23300 Y-SCALE) "solid" BAR-COLOR))
                      (overlay/align "center" "bottom"
                                     (rotate 90 (text "School3" FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* 28500 Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* 28500 Y-SCALE) "solid" BAR-COLOR))
                      (square 0 "solid" "white")))
(check-expect (plot S4) (square 0 "solid" "white"))

; (define (plot los) (square 0 "solid" "white")) ;stub
; <Take template from School>

(define (plot s)
  (cond [(false? s) (square 0 "solid" "white")]
        [else
         (beside/align "bottom"
              (create-bar s)
              (plot (school-next s)))]))

;; School -> Image
;; produce the bar for a single school in the bar chart
(check-expect (create-bar S1)
                      (overlay/align "center" "bottom"
                                     (rotate 90 (text (school-name S1) FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* (school-tuition S1) Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* (school-tuition S1) Y-SCALE) "solid" BAR-COLOR)))
(check-expect (create-bar (make-school "School2" 23300 false))
                      (overlay/align "center" "bottom"
                                     (rotate 90 (text "School2" FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* 23300 Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* 23300 Y-SCALE) "solid" BAR-COLOR)))

; (define (create-bar s) (square 0 "solid" "white")) ;stub

(define (create-bar s)
  (overlay/align "center" "bottom"
                 (rotate 90 (text (school-name s) FONT-SIZE FONT-COLOR))
                 (rectangle BAR-WIDTH (* (school-tuition s) Y-SCALE) "outline" "black")
                 (rectangle BAR-WIDTH (* (school-tuition s) Y-SCALE) "solid" BAR-COLOR)))
