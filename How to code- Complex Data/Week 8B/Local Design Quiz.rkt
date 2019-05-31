; Problem 1:
; 
; Suppose you have rosters for players on two opposing tennis team, and each
; roster is ordered by team rank, with the best player listed first. When both 
; teams play, the best players of each team play one another,
; and the second-best players play one another, and so on down the line. When
; one team has more players than the other, the lowest ranking players on
; the larger team do not play.
; 
; Design a function that consumes two rosters, and produces true if all players 
; on both teams will play if the teams play each other. 
; No marks will be given to solution that do not use a cross product table. 
; 
;; ==============================================================================

;; Player is String
;; interp.  the name of a tennis player.
(define P0 "Maria")
(define P2 "Serena")

#;
(define (fn-for-player p)
  (... p))



;; Roster is one of:
;; - empty
;; - (cons Player Roster)
;; interp.  a team roster, ordered from best player to worst.
(define R0 empty)
(define R1 (list "Eugenie" "Gabriela" "Sharon" "Aleksandra"))
(define R2 (list "Maria" "Nadia" "Elena" "Anastasia" "Svetlana"))

#;
(define (fn-for-roster r)
  (cond [(empty? r) (...)]
        [else 
         (... (fn-for-player (first r))
              (fn-for-roster (rest r)))]))



(define-struct match (p1 p2))
;; Match is (make-match Player Player)
;; interp.  a match between player p1 and player p2, with same team rank
(define M0 (make-match "Eugenie" "Maria"))
(define M1 (make-match "Gabriela" "Nadia"))

#;
(define (fn-for-match m)
  (... (match-p1 m) (match-p2 m)))



;; ListOfMatch is one of:
;; - empty
;; - (cons Match ListOfMatch)
;; interp. a list of matches between one team and another.
(define LOM0 empty)
(define LOM1 (list (make-match "Eugenie" "Maria")
                   (make-match "Gabriela" "Nadia")))

#;
(define (fn-for-lom lom)
  (cond [(empty? lom) (...)]
        [else
         (... (fn-for-match (first lom))
              (fn-for-lom (rest lom)))]))

;; Functions:
;; Roster Roster -> Boolean
;; Produces true if all players on both teams will play if the teams play each other
(check-expect (all-players? R1 R2) false)
(check-expect (all-players? empty empty) true)
(check-expect (all-players? empty R1) false)
(check-expect (all-players? R2 empty) false)
(check-expect (all-players? R1 (list "A" "B" "C" "D")) true)
(check-expect (all-players? (list "A" "B" "C" "D" "E") R2) true)

; (define (all-players? r1 r2) false) ;stub

(define (all-players? r1 r2)
  (cond [(and (empty? r1) (empty? r2)) true]
        [(empty? r1) false]
        [(empty? r2) false]
        [else (all-players? (rest r1) (rest r2))]))
        
;; ==================================================================================
; Problem 2:
; 
; Now write a function that, given two teams, produces the list of tennis matches
; that will be played. 
; 
; Assume that this function will only be called if the function you designed above
; produces true. In other words, you can assume the two teams have the same number
; of players. 
; 
;; ==================================================================================

;; Roster Roster -> ListOfMatch
;; Produces the list of tennis matches that will be played given two rosters
(check-expect (tennis-matches (list "A" "B" "C" "D" "E") R2) (list (make-match "A" "Maria")
                                                                   (make-match "B" "Nadia")
                                                                   (make-match "C" "Elena")
                                                                   (make-match "D" "Anastasia")
                                                                   (make-match "E" "Svetlana")))
(check-expect (tennis-matches (list "A" "B") (list "C" "D")) (list (make-match "A" "C")
                                                                   (make-match "B" "D")))
(check-expect (tennis-matches empty R1) empty)
(check-expect (tennis-matches empty empty) empty)

; (define (tennis-matches r1 r2) empty) ;stub

(define (tennis-matches r1 r2)
  (cond [(or (empty? r1) (empty? r2)) empty]
        [else (cons (make-match (first r1) (first r2))
                    (tennis-matches (rest r1) (rest r2)))]))
