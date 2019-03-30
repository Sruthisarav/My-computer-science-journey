(require 2htdp/image)
(require 2htdp/universe)

;; making-rain-filtered-starter.rkt

; 
; PROBLEM:
; 
; Design a simple interactive animation of rain falling down a screen. Wherever we click,
; a rain drop should be created and as time goes by it should fall. Over time the drops
; will reach the bottom of the screen and "fall off". You should filter these excess
; drops out of the world state - otherwise your program is continuing to tick and
; and draw them long after they are invisible.
; 
; In your design pay particular attention to the helper rules. In our solution we use
; these rules to split out helpers:
;   - function composition
;   - reference
;   - knowledge domain shift
;   
;   
; NOTE: This is a fairly long problem.  While you should be getting more comfortable with 
; world problems there is still a fair amount of work to do here. Our solution has 9
; functions including main. If you find it is taking you too long then jump ahead to the
; next homework problem and finish this later.
; 
; 
;; =================================================================================================

;; Make it rain where we want it to.

;; =================
;; Constants:

(define WIDTH  1400)
(define HEIGHT 820)

(define SPEED 10)

(define DROP (ellipse 4 8 "solid" "blue"))

(define MTS (rectangle WIDTH HEIGHT "solid" "light blue"))

;; =================
;; Data definitions:

(define-struct drop (x y))
;; Drop is (make-drop Integer Integer)
;; interp. A raindrop on the screen, with x and y coordinates.

(define D1 (make-drop 10 30))

#;
(define (fn-for-drop d)
  (... (drop-x d) 
       (drop-y d)))

;; Template Rules used:
;; - compound: 2 fields


;; ListOfDrop is one of:
;;  - empty
;;  - (cons Drop ListOfDrop)
;; interp. a list of drops

(define LOD1 empty)
(define LOD2 (cons (make-drop 10 20) (cons (make-drop 3 6) empty)))

#;
(define (fn-for-lod lod)
  (cond [(empty? lod) (...)]
        [else
         (... (fn-for-drop (first lod))
              (fn-for-lod (rest lod)))]))

;; Template Rules used:
;; - one-of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons Drop ListOfDrop)
;; - reference: (first lod) is Drop
;; - self reference: (rest lod) is ListOfDrop

;; =================
;; Functions:

;; ListOfDrop -> ListOfDrop
;; start rain program by evaluating (main empty)
(define (main lod)
  (big-bang lod
            (on-mouse handle-mouse)   ; ListOfDrop Integer Integer MouseEvent -> ListOfDrop
            (on-tick  next-drops)     ; ListOfDrop -> ListOfDrop
            (to-draw  render-drops))) ; ListOfDrop -> Image


;; ListOfDrop Integer Integer MouseEvent -> ListOfDrop
;; if mevt is "button-down" add a new drop at that position
(check-expect (handle-mouse (cons D1 empty) 30 30 "button-down") (cons (make-drop 30 30) (cons D1 empty)))
(check-expect (handle-mouse (cons D1 empty) 50 40 "button-up") (cons D1 empty))

; (define (handle-mouse lod x y mevt) empty) ; stub

(define (handle-mouse lod x y mevt)
  (cond [(mouse=? mevt "button-down") (cons (make-drop x y) lod)]
        [else lod]))


;; ListOfDrop -> ListOfDrop
;; produce filtered and ticked list of drops
(check-expect (next-drops LOD1) empty)
(check-expect (next-drops LOD2) (cons (make-drop 10 (+ 20 SPEED))
                                      (cons (make-drop 3 (+ 6 SPEED)) empty)))
(check-expect (next-drops (cons (make-drop 20 HEIGHT)
                                  (cons (make-drop 10 10) empty)))
              (cons (make-drop 10 (+ 10 SPEED)) empty))
(check-expect (next-drops (cons (make-drop 50 HEIGHT)
                                  (cons (make-drop 20 HEIGHT)
                                        (cons (make-drop 20 20) empty))))
              (cons (make-drop 20 (+ 20 SPEED)) empty))

; (define (next-drops lod) empty) ; stub

(define (next-drops lod)
  (filter-drops (increase-speed lod)))


;; ListOfDrop -> ListOfDrop
;; Remove drops that have reached the bottom of the screen
(check-expect (filter-drops LOD1) empty)
(check-expect (filter-drops LOD2) (cons (make-drop 10 20)
                                        (cons (make-drop 3 6)
                                              empty)))
(check-expect (filter-drops (cons (make-drop 20 HEIGHT)
                                  (cons (make-drop 10 10) empty)))
              (cons (make-drop 10 10) empty))
(check-expect (filter-drops (cons (make-drop 50 HEIGHT)
                                  (cons (make-drop 20 HEIGHT)
                                        (cons (make-drop 20 20) empty))))
              (cons (make-drop 20 20) empty))

; (define (filter-drops lod) empty) ;stub

; <Template from ListOfDrop>
(define (filter-drops lod)
  (cond [(empty? lod) lod]
        [(larger? (first lod) HEIGHT)
           (remove (first lod) (filter-drops (rest lod)))]
        [else
         (cons (first lod) (filter-drops (rest lod)))]))

;; Drop Natural -> Boolean
;; Check whether the drop has reached the bottom
(check-expect (larger? (make-drop 50 HEIGHT) HEIGHT) true)
(check-expect (larger? (make-drop 0 0) HEIGHT) false)
(check-expect (larger? (make-drop 100 HEIGHT) HEIGHT) true)
(check-expect (larger? (make-drop 50 50) HEIGHT) false)

;(define (larger? drop h) false) ;stub
; <Template from Drop>

(define (larger? drop h)
  (if (>= (drop-y drop) h)
      true
      false))

;; ListOfDrop -> ListOfDrop
;; Increase the y-coordinates of all drops by SPEED
(check-expect (increase-speed LOD1) empty)
(check-expect (increase-speed LOD2)
              (cons (make-drop 10 (+ 20 SPEED))
                                      (cons (make-drop 3 (+ 6 SPEED)) empty)))

(define (increse-speed lod) empty) ;stub
; <Template from ListOfDrop>
(define (increase-speed lod)
  (cond [(empty? lod) lod]
        [else
         (cons (make-drop (drop-x (first lod)) (+ (drop-y (first lod)) SPEED))
              (increase-speed (rest lod)))]))


;; ListOfDrop -> Image
;; Render the drops onto MTS
(check-expect (render-drops LOD1) MTS)
(check-expect (render-drops LOD2) (place-image DROP
                                               10
                                               20
                                               (place-image DROP
                                                            3
                                                            6
                                                            MTS)))

; (define (render-drops lod) MTS) ; stub
; <Template from ListOfDrop>

(define (render-drops lod)
  (cond [(empty? lod) MTS]
        [else
         (render-drop (first lod)
              (render-drops (rest lod)))]))

;; Bear Image -> Image
;; Place appropriate image of drop on MTS at the respective x and y coordinates
(check-expect (render-drop D1 MTS) (place-image DROP
                                            10
                                            30
                                            MTS))
(check-expect (render-drop (make-drop 3 6) (place-image DROP
                                                        10
                                                        20
                                                        MTS)) (place-image DROP
                                                                           10
                                                                           20
                                                                           (place-image DROP
                                                                                        3
                                                                                        6
                                                                                        MTS)))

;(define (render-drop d) MTS) ;stub

; <Template from Drop>

(define (render-drop d image)
  (place-image DROP
       (drop-x d) 
       (drop-y d)
       image))
