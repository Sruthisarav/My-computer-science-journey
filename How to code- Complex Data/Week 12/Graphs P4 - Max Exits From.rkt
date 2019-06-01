
; 
; PROBLEM:
; 
; Using the following data definition, design a function that produces the room with the most exits 
; (in the case of a tie you can produce any of the rooms in the tie).
; 
;; ===============================================================================================

;; Data Definitions: 

(define-struct room (name exits))
;; Room is (make-room String (listof Room))
;; interp. the room's name, and list of rooms that the exits lead to

; .
 
(define H1 (make-room "A" (list (make-room "B" empty))))

; .
 
(define H2 
  (shared ((-0- (make-room "A" (list (make-room "B" (list -0-))))))
    -0-)) 


; .

(define H3
  (shared ((-A- (make-room "A" (list -B-)))
           (-B- (make-room "B" (list -C-)))
           (-C- (make-room "C" (list -A-))))
    -A-))
           


; .

(define H4
  (shared ((-A- (make-room "A" (list -B- -D-)))
           (-B- (make-room "B" (list -C- -E-)))
           (-C- (make-room "C" (list -B-)))
           (-D- (make-room "D" (list -E-)))
           (-E- (make-room "E" (list -F- -A-)))
           (-F- (make-room "F" (list))))
    -A-))

(define H5
  (shared ((-A- (make-room "A" (list -B- -D-)))
           (-B- (make-room "B" (list -C- -E-)))
           (-C- (make-room "C" (list -B-)))
           (-D- (make-room "D" (list -E-)))
           (-E- (make-room "E" (list -F- -A- -D-)))
           (-F- (make-room "F" (list))))
    -A-))

;; template: structural recursion, encapsulate w/ local, tail-recursive w/ worklist, 
;;           context-preserving accumulator what rooms have we already visited

#;
(define (fn-for-house r0)
  ;; todo is (listof Room); a worklist accumulator
  ;; visited is (listof String); context preserving accumulator, names of rooms already visited
  (local [(define (fn-for-room r todo visited) 
            (if (member (room-name r) visited)
                (fn-for-lor todo visited)
                (fn-for-lor (append (room-exits r) todo)
                            (cons (room-name r) visited)))) ; (... (room-name r))
          (define (fn-for-lor todo visited)
            (cond [(empty? todo) (...)]
                  [else
                   (fn-for-room (first todo) 
                                (rest todo)
                                visited)]))]
    (fn-for-room r0 empty empty)))

;; Room -> String
;; Produces the room with the most exits
(check-expect (most-exits H1) "A")
(check-expect (most-exits H2) "A")
(check-expect (most-exits H3) "A")
(check-expect (most-exits H4) "A")
(check-expect (most-exits H5) "E")

(define (most-exits r0)
  ;; todo is (listof Room); a worklist accumulator
  ;; visited is (listof String); context preserving accumulator, names of rooms already visited
  (local [(define (fn-for-room r todo visited exits name) 
            (cond [(member (room-name r) visited)
                   (fn-for-lor todo visited exits name)]
                  [(> (list-length (room-exits r)) exits)
                   (fn-for-lor (append (room-exits r) todo)
                               (cons (room-name r) visited)
                               (list-length (room-exits r))
                               (room-name r))]
                  [else
                   (fn-for-lor (append (room-exits r) todo)
                               (cons (room-name r) visited)
                               exits
                               name)])) 
            (define (fn-for-lor todo visited exits name)
              (cond [(empty? todo) name]
                    [else
                     (fn-for-room (first todo) 
                                  (rest todo)
                                  visited
                                  exits
                                  name)]))]
    (fn-for-room r0 empty empty 0 "")))

;; (listof Room) -> Number
;; Produces the length of the list
(check-expect (list-length (list 1 2 3 4)) 4)

(define (list-length l)
  (cond [(empty? l) 0]
        [else
         (add1 (list-length (rest l)))]))
