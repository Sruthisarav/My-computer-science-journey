
;  PROBLEM 1:
;  
;  Consider a social network similar to Twitter called Chirper. Each user has a name, a note about
;  whether or not they are a verified user, and follows some number of people. 
;  
;  Design a data definition for Chirper, including a template that is tail recursive and avoids 
;  cycles. 
;  
;  Then design a function called most-followers which determines which user in a Chirper Network is 
;  followed by the most people.
;  
;; ==================================================================================================

;; Data definitions:

(define-struct user (name verified? follow))
;; Chirper is (make-chirper String boolean (listof Chirper))
;; interp. chirper's name, whether he's a verified user, and the list of people he's following

(define C1
  (shared ((-A- (make-user "A" true (list -B-)))
           (-B- (make-user "B" false (list -A- -C-)))
           (-C- (make-user "C" true (list -A- -D-)))
           (-D- (make-user "D" false (list))))
    -A-))

(define C2
  (shared ((-A- (make-user "A" true (list -B- -D-)))
           (-B- (make-user "B" false (list -C- -E-)))
           (-C- (make-user "C" false (list -B-)))
           (-D- (make-user "D" true (list -E-)))
           (-E- (make-user "E" true (list -F- -A-)))
           (-F- (make-user "F" false (list))))
    -A-))

(define C3
  (shared ((-A- (make-user "A" true (list -B-)))
           (-B- (make-user "B" false (list -A-))))
    -A-))

;; template: structural recursion, encapsulate w/ local, tail-recursive w/ worklist, 
;;           context-preserving accumulator what rooms have we already visited

#;
(define (fn-for-chirper c0)
  ;; todo is (listof Chirper); a worklist accumulator
  ;; visited is (listof String); context preserving accumulator, names of Chirpers already visited
  (local [(define (fn-for-user u todo visited)
            (fn-for-lou todo visited)
            (fn-for-lou (append (user-follow u) todo)
                        (cons (user-name u) visited)))
          (define (fn-for-lou todo visited)
            (cond [(empty? todo) (...)]
                  [else
                   (fn-for-user (first todo)
                                (rest todo)
                                visited)]))]
    (fn-for-user c0 empty empty)))


(check-expect (most-followers C1) (shared ((-A- (make-user "A" true (list -B-)))
                                           (-B- (make-user "B" false (list -A- -C-)))
                                           (-C- (make-user "C" true (list -A- -D-)))
                                           (-D- (make-user "D" false (list))))
                                    -A-))

(check-expect (most-followers C2) (shared ((-A- (make-user "A" true (list -B- -D-)))
                                           (-B- (make-user "B" false (list -C- -E-)))
                                           (-C- (make-user "C" false (list -B-)))
                                           (-D- (make-user "D" true (list -E-)))
                                           (-E- (make-user "E" true (list -F- -A-)))
                                           (-F- (make-user "F" false (list))))
                                    -E-))

(define (most-followers c0)
  (local [;; Userfollowers is (make-ue User Natural)
          ;; interp. the number of followers each given user has
          (define-struct ue (u n))
          
          ;; todo is (listof User); a worklist accumulator
          ;; visited is (listof String); context preserving accumulator, names of users already visited
          ;; rsf is (listof follows); the number of people being followed so far
          (define (fn-for-user u todo visited rsf) 
            (if (member (user-name u) visited)
                (fn-for-lou todo visited rsf)
                (fn-for-lou (append (user-follow u) todo)
                            (cons (user-name u) visited)
                            (merge-user u rsf))))
          (define (fn-for-lou todo visited rsf)
            (cond [(empty? todo) rsf]
                  [else
                   (fn-for-user (first todo)  
                                (rest todo)
                                visited
                                rsf)]))
          ;; add one new user to rsf
          (define (merge-user u rsf)
            (foldr merge-follow rsf (user-follow u)))
          ;; add one new follow to rsf
          (define (merge-follow u loue)
            (cond [(empty? loue) (list (make-ue u 1))]
                  [else
                   (if (string=? (user-name u) (user-name (ue-u (first loue))))
                       (cons (make-ue u
                                      (add1 (ue-n (first loue))))
                             (rest loue))
                       (cons (first loue)
                             (merge-follow u (rest loue))))]))
          ;; pick the user from rsf that has the most followers to it
          (define (pick-max rsf)
            (ue-u
             (foldr (λ (e1 e2)
                      (if (> (ue-n e1) (ue-n e2))
                          e1
                          e2))
                    (first rsf)
                    (rest rsf))))]
    ;; function composition
    (pick-max (fn-for-user c0 empty empty empty))))

;; ================================================================================================
;  PROBLEM 2:
;  
;  In UBC's version of How to Code, there are often more than 800 students taking 
;  the course in any given semester, meaning there are often over 40 Teaching Assistants. 
;  
;  Designing a schedule for them by hand is hard work - luckily we've learned enough now to write 
;  a program to do it for us! 
;  
;  Below are some data definitions for a simplified version of a TA schedule. There are some 
;  number of slots that must be filled, each represented by a natural number. Each TA is 
;  available for some of these slots, and has a maximum number of shifts they can work. 
;  
;  Design a search program that consumes a list of TAs and a list of Slots, and produces one
;  valid schedule where each Slot is assigned to a TA, and no TA is working more than their 
;  maximum shifts. If no such schedules exist, produce false. 
; 
;  You should supplement the given check-expects and remember to follow the recipe!
;; =================================================================================================

;; Slot is Natural
;; interp. each TA slot has a number, is the same length, and none overlap

(define-struct ta (name max avail))
;; TA is (make-ta String Natural (listof Slot))
;; interp. the TA's name, number of slots they can work, and slots they're available for

(define SOBA (make-ta "Soba" 2 (list 1 3)))
(define UDON (make-ta "Udon" 1 (list 3 4)))
(define RAMEN (make-ta "Ramen" 1 (list 2)))

(define NOODLE-TAs (list SOBA UDON RAMEN))

(define-struct assignment (ta slot))
;; Assignment is (make-assignment TA Slot)
;; interp. the TA is assigned to work the slot

;; Schedule is (listof Assignment)


;; FUNCTIONS:

;; (listof TA) (listof Slot) -> Schedule or false
;; produce valid schedule given TAs and Slots; false if impossible

(check-expect (schedule-tas empty empty) empty)
(check-expect (schedule-tas empty (list 1 2)) false)
(check-expect (schedule-tas (list SOBA) empty) empty)

(check-expect (schedule-tas (list SOBA) (list 1)) (list (make-assignment SOBA 1)))
(check-expect (schedule-tas (list SOBA) (list 2)) false)
(check-expect (schedule-tas (list SOBA) (list 1 3)) (list (make-assignment SOBA 3)
                                                          (make-assignment SOBA 1)))

(check-expect (schedule-tas NOODLE-TAs (list 1 2 3 4)) 
              (list
               (make-assignment UDON 4)
               (make-assignment SOBA 3)
               (make-assignment RAMEN 2)
               (make-assignment SOBA 1)))

(check-expect (schedule-tas NOODLE-TAs (list 1 2 3 4 5)) false)

; (define (schedule-tas lota slots) empty) ;stub

(define (schedule-tas lota slots)
  (cond [(empty? slots) empty]
        [(empty? lota) false]
        [else
         (local [(define (fn-for-schedule todo schedule)
                   (if (empty? todo)
                       schedule
                       (fn-for-los (rest todo) (valid-schedules (first todo) lota schedule))))
                 (define (fn-for-los todo los)
                   (cond [(empty? los) false]
                         [else
                          (if (not (false? (fn-for-schedule todo (first los))))
                              (fn-for-schedule todo (first los))
                              (fn-for-los todo (rest los)))]))]
           (fn-for-schedule slots empty))]))

(define (valid-schedules slot lota schedule)
  (keep-valid-schedules lota (create-schedule slot lota schedule)))

;; Number (listof TA) Schedule -> (listof Schedule)
;; produces a list of all the possible schedules regardless of validity
(check-expect (create-schedule 2 NOODLE-TAs empty) (list
                                                    (list (make-assignment RAMEN 2))))
(check-expect (create-schedule 1 NOODLE-TAs (list (make-assignment RAMEN 2)))
              (list
               (list (make-assignment SOBA 1) (make-assignment RAMEN 2))))


(define (create-schedule slot lota schedule)
  (cond [(empty? lota) empty]
        [else
         (if (member? slot (ta-avail (first lota)))
             (cons (cons (make-assignment (first lota) slot) schedule)
                   (create-schedule slot (rest lota) schedule))
             (create-schedule slot (rest lota) schedule))]))

;; (listof TA) (listof Schedule) -> (listof Schedule)
;; Only keep valid schedules
(check-expect (keep-valid-schedules NOODLE-TAs
                                    (list
                                     (list (make-assignment SOBA 3) (make-assignment RAMEN 2) (make-assignment SOBA 1))
                                     (list (make-assignment UDON 3) (make-assignment RAMEN 2) (make-assignment SOBA 1))))
              (list
               (list (make-assignment SOBA 3) (make-assignment RAMEN 2) (make-assignment SOBA 1))
               (list (make-assignment UDON 3) (make-assignment RAMEN 2) (make-assignment SOBA 1))))
(check-expect (keep-valid-schedules NOODLE-TAs
                                    (list
                                     (list (make-assignment SOBA 1) (make-assignment UDON 3) (make-assignment UDON 4))
                                     (list (make-assignment UDON 3) (make-assignment RAMEN 2) (make-assignment SOBA 1))))
              (list
               (list (make-assignment UDON 3) (make-assignment RAMEN 2) (make-assignment SOBA 1))))

(define (keep-valid-schedules lota los)
  (local [(define (valid? schedule)
            (local [(define (ta-available? ta)
                      (if (< (ta-max ta) (count ta schedule))
                          false
                          true))
                    (define (count ta schedule)
                      (local [(define (counted name num)
                                (if (equal? (assignment-ta name) ta)
                                    (add1 num)
                                    num))]
                        (foldr counted 0 schedule)))]
              (andmap ta-available? lota)))]
    (filter valid? los)))
