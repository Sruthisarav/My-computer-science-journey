
; 
; PROBLEM:
; 
; Using the following data definition, design a function that produces the room to which the greatest 
; number of other rooms have exits (in the case of a tie you can produce any of the rooms in the tie).
; 
; (Sruthi's NOTE): I modified the example to produce the room name to which the greatest number of other rooms
; have exits to, instead of the room so it looks neater
; 
;; =============================================================================================================

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


;; (listof Room) -> String
;; Produces the name of the room to which the greatest number of other rooms have exits to
(check-expect (frequented-room H2) "A")
(check-expect (frequented-room H3) "A")
(check-expect (frequented-room H4) "B")
(check-expect (frequented-room H5) "B")

(define (frequented-room r0)
  ;; todo is (listof Room); a worklist accumulator
  ;; visited is (listof String); context preserving accumulator, names of rooms already visited
  (local [(define (fn-for-room r todo visited froom number) 
            (cond [(member (room-name r) visited) (fn-for-lor todo visited froom number)]
                  [(> (rnumber r0 (room-name r)) number)
                   (fn-for-lor (append (room-exits r) todo)
                               (cons (room-name r) visited)
                               (room-name r)
                               (rnumber r0 (room-name r)))]
                  [else
                   (fn-for-lor (append (room-exits r) todo)
                               (cons (room-name r) visited)
                               froom
                               number)]))
          (define (fn-for-lor todo visited froom number)
            (cond [(empty? todo) froom]
                  [else
                   (fn-for-room (first todo) 
                                (rest todo)
                                visited
                                froom
                                number)]))]
    (fn-for-room r0 empty empty "" 0)))

;; (listof Room) String -> Number
;; procudes the name of the room
(check-expect (rnumber H2 "B") 1)
(check-expect (rnumber H3 "B") 1)
(check-expect (rnumber H4 "B") 2)

(define (rnumber r0 rname)
  (room-no (visited-no r0) rname))

;; (listof String) String -> Number
;; produces the number of times the given string appears in the list
(check-expect (room-no (list "A" "B" "A" "A") "B") 1)
(check-expect (room-no (list "B" "B" "A" "A") "B") 2)
(check-expect (room-no (list "B" "B" "A" "A" "C" "B" "C") "B") 3)
(check-expect (room-no (list "A" "B" "A" "A" "C" "B" "C") "A") 3)

(define (room-no list room)
  ;; todo is (listof Room); a worklist accumulator
  ;; visited is (listof String); context preserving accumulator, names of rooms already visited
  (local [(define (fn-for-room list rname room number) 
            (cond [(empty? list)
                   (if (string=? rname room)
                       (add1 number)
                       number)]
                  [(string=? rname room)
                   (fn-for-room (rest list) (first list) room (add1 number))]
                  [else
                   (fn-for-room (rest list) (first list) room number)]))]
    (fn-for-room list "" room 0)))

;; Room -> (listof String)
;; produces a list of exits in a room
(check-expect (visited-no H1) (list "B"))
(check-expect (visited-no H2) (list "A" "B"))

(define (visited-no r0)
  ;; todo is (listof Room); a worklist accumulator
  ;; visited is (listof String); context preserving accumulator, names of rooms already visited
  (local [(define (fn-for-room r todo visited exits) 
            (if (member (room-name r) visited)
                (fn-for-lor todo visited exits)
                (fn-for-lor (append (room-exits r) todo)
                            (cons (room-name r) visited)
                            (append (room-exits r) exits))))
          (define (fn-for-lor todo visited exits)
            (cond [(empty? todo) (exit-name exits)]
                  [else
                   (fn-for-room (first todo) 
                                (rest todo)
                                visited
                                exits)]))]
    (fn-for-room r0 empty empty empty)))

;; (listof Room) -> (listof String)
;; produces a list of names of rooms 

(define (exit-name exits)
  (cond [(empty? exits) empty]
        [else
         (cons (room-name (first exits))
               (exit-name (rest exits)))]))

