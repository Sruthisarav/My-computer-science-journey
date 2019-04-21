(require 2htdp/image)
(require 2htdp/universe)

;; Constants:

(define BACKGROUND-COLOR "white")
(define WIDTH 400)
(define HEIGHT 800)
(define MTS (rectangle WIDTH HEIGHT "solid" BACKGROUND-COLOR))

(define TANK-IMAGE (above (rectangle 4 10 "solid" "black")
                          (overlay (ellipse 21 8 "solid" "black")
                                   (above
                                    (rectangle 15 10 "solid" "black")
                                    (rectangle 21 5 "solid" BACKGROUND-COLOR)))))

(define TANK-SPEED 5)
(define TANK-Y (- HEIGHT 10))

(define MISSILE-IMAGE (ellipse 5 15 "solid" "red"))
(define MISSILE-SPEED 10)

(define INVADER-IMAGE (overlay/xy (ellipse 10 16 "outline" "blue")
                                  -5 7
                                  (ellipse 21 10 "solid" "blue")))
(define INVADER-HOR-SPD 1.5)
(define INVADER-VERT-SPD 1.5)
(define INVADER-HIT 10)

;; Data definitions:
(define-struct tank (x d))
;; Tank is (make-tank Natural[0, WIDTH] Boolean)
;; interp. (make-tank x d) is a tank with x-coordinates, s and direction of tank, d
;;         x is the x-coordinates of the tank on the screen (in prixels)
;;         d is a boolean which determines whether the tank is moving to the right(true) or left(false)
(define T1 (make-tank 20 true)) ; tank with 20 x-coordinates is moving to the right
(define T2 (make-tank 50 false)); tank with 50 x-coordinates is moving to the left
#;
(define (fn-for-tank t)
  (... (tank-x t)
       (tank-d t))) ;template

(define-struct missile (x y next))
;; ListOfMissile is one of:
;; - false
;; - (make-missile Natural[0, WIDTH] Natural[0, HEIGHT] ListOfMissile)
;; interp. an arbitrary number of missiles, where for each missile we have its:
;;         x-coordinates on the screen, x
;;         y-coordinates on the screen, y
(define LOM0 false)
(define LOM1 (make-missile 10 20 false))
(define LOM2 (make-missile 30 80
                           (make-missile 50 100 false)))
(define LOM3 (make-missile 100 120
                           (make-missile 60 180
                                         (make-missile 70 150 false))))
#;
(define (fn-for-lon lom)
  (cond [(false? lom) (...)]
        [else
         (... (missile-x lom)
              (missle-y lom)
              (fn-for-missile (missle-next lom)))])) ; template for ListOfMissile

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: false
;; - compound: (make-missile Natural[0, WIDTH] Natural[0, HEIGHT] ListOfMissile)
;; - atomic non-distinct: (missile-x m) is Natural[0, WIDTH]
;; - atomic non-distinct: (missle-y m) is Natural[0, HEIGHT]
;; - self-reference (missle-next m) is Missile

(define-struct invader (x y d next))
;; ListOfInvader is one of:
;; - false
;; - (make-invader Natural[0, WIDTH] Natural[0, HEIGHT] ListOfInvader)
;; interp. an arbitrary number of invaders, where for each invader we have its:
;;         x-coordinates on the screen, x
;;         y-coordinates on the screen, y
;;         d is a boolean which determines whether the invader is moving to the right(true) or left(false)
(define LOI0 false)
(define LOI1 (make-invader 10 20 true false))
(define LOI2 (make-invader 30 80 true
                           (make-invader 50 100 true false)))
(define LOI3 (make-invader 100 120 false
                           (make-invader 60 180 true
                                         (make-invader 70 150 true false))))
#;
(define (fn-for-loi loi)
  (cond [(false? loi) (...)]
        [else
         (... (invader-x loi)
              (invader-y loi)
              (invader-d loi)
              (fn-for-invader (invader-next loi)))])) ; template for ListOfMissile

;; Template rules used:
;; Compound: 4 fields

(define-struct game (tank missiles invaders))
;; Game is (make-game Tank ListOfMissiles ListOfInvader)
;; interp. (make-game tank missiles invaders)
(define G1 (make-game T1 false false))
(define G2 (make-game T2 false false))
(define G3 (make-game T1 LOM1 LOI2))
(define G4 (make-game T2 LOM2 LOI1))

;; Functions:

;; Game -> Game
;; Starts off with a tank on the bottom left hand of the screen moving to the right; start with: (main (make-game (make-tank 0 true) false false))

(define (main g)
  (big-bang g             ;; Game
    (on-tick next-game)   ;; Game -> Game
    (to-draw render-game) ;; Game -> Image
    (stop-when game-over end-game) ;; Game -> Boolean
    (on-key new-game)))   ;; Game KeyEvent -> Game


;; Game -> Game
;; Increase tank-x by TANK-SPEED based on the direction the tank is moving in
;; Decrease missile-y by MISSILE-SPEED
;; Increase/Decrease invader-x by INVADER-HOR-SPD and Increase invader-y by INVADER-VERT-SPD
(check-expect (next-game G1) (make-game (make-tank (+ 20 TANK-SPEED) true) false false))
(check-expect (next-game G2) (make-game (make-tank (- 50 TANK-SPEED) false) false false))
(check-expect (next-game (make-game (make-tank WIDTH true) false false))
              (make-game (make-tank WIDTH true) false false))
(check-expect (next-game (make-game (make-tank 0 false) false false))
                         (make-game (make-tank 0 false) false false))
(check-expect (next-game (make-game (make-tank 20 true)
                                    (make-missile 10 20 false)
                                    false))
              (make-game (make-tank (+ 20 TANK-SPEED) true)
                         (make-missile 10 (- 20 MISSILE-SPEED) false)
                         false))
(check-expect (next-game G3)
              (make-game (make-tank (+ 20 TANK-SPEED) true)
                         (make-missile 10 (- 20 MISSILE-SPEED) false)
                         (make-invader (+ 30 INVADER-HOR-SPD) (+ 80 INVADER-VERT-SPD) true
                                       (make-invader (+ 50 INVADER-HOR-SPD) (+ 100 INVADER-VERT-SPD) true false))))


; (define (next-game g) g) ;stub

(define (next-game g)
  (make-game (next-tank (game-tank g))
             (filter-lom (next-missile (game-missiles g)))
             (filter-loi (next-invader (game-invaders g)) (game-missiles g))))

;; ListOfInvader ListOfMissile -> ListOfInvader
;; Remove invaders that were hit by missiles
(check-expect (filter-loi (make-invader 50 50 false false) (make-missile 50 45 false)) false)
(check-expect (filter-loi (make-invader 50 50 false false) (make-missile 50 65 false))
              (make-invader 50 50 false false))

; (define (filter-loi loi lom) loi) ;stub

(define (filter-loi loi lom)
  (cond [(false? loi) false]
        [(false? lom) loi]
        [else
         (if (locate-invader loi lom)
             (filter-loi (invader-next loi) lom)
             (make-invader (invader-x loi) (invader-y loi) (invader-d loi) (filter-loi (invader-next loi) lom)))]))

;; ListOfInvader ListOfMissile -> Boolean
;; Returns true if the invader is hit by a missile
(check-expect (filter-loi (make-invader 50 50 false false) (make-missile 50 45 false)) false)
(check-expect (filter-loi (make-invader 50 50 false false) (make-missile 50 65 false))
              (make-invader 50 50 false false))

; (define (locate-invader loi lom) false) ;stub

(define (locate-invader loi lom)
  (cond [(false? lom) false]
        [else
         (if (and (< (- (invader-x loi) INVADER-HIT) (missile-x lom) (+ (invader-x loi) INVADER-HIT))
                  (< (- (invader-y loi) INVADER-HIT) (missile-y lom) (+ (invader-y loi) INVADER-HIT)))
             true
             (locate-invader loi (missile-next lom)))]))

;; ListOfMissile -> ListOfMissile
;; Removes missiles that have left the screen
(check-expect (filter-lom LOM1) LOM1)
(check-expect (filter-lom (make-missile 50 0 false)) false)

; (define (filter-lom lom) lom) ;stub

(define (filter-lom lom)
  (cond [(false? lom) false]
        [else
         (if (<= (missile-y lom) 0)
             (filter-lom (missile-next lom))
             (make-missile (missile-x lom) (missile-y lom) (filter-lom (missile-next lom))))]))

;; Tank -> Tank
;; Increase tank-x by TANK-SPEED based on the direction the tank is moving in
;; !!!

; (define (next-tank t) t) ;stub

(define (next-tank t)
  (cond [(false? (tank-d t))
         (if (> (tank-x t) 0)
             (make-tank (- (tank-x t) TANK-SPEED) (tank-d t))
             (make-tank (tank-x t) (tank-d t)))]
        [(< (tank-x t) WIDTH)
         (make-tank (+ (tank-x t) TANK-SPEED) (tank-d t))]
        [else t]))

;; ListOfMissile -> ListOfMissile
;; Decrease missile-y by MISSILE-SPEED
(check-expect (next-missile LOM0) false)
(check-expect (next-missile LOM1) (make-missile 10 (- 20 MISSILE-SPEED) false))

; (define (next-missile lom) lom) ;stub

(define (next-missile lom)
  (cond [(false? lom) false]
        [(zero? (missile-y lom))
         (make-missile (missile-x lom) 0 (missile-next lom))]
        [else
         (make-missile (missile-x lom)
                       (- (missile-y lom) MISSILE-SPEED)
                       (next-missile (missile-next lom)))]))

;; ListOfInvaders -> ListOfInvaders
;; Increase/Decrease invader-x by INVADER-HOR-SPD and Increase invader-y by INVADER-VERT-SPD
(check-expect (next-invader LOI1) (make-invader (+ 10 INVADER-HOR-SPD) (+ 20 INVADER-VERT-SPD) true
                                                false))
(check-expect (next-invader LOI2) (make-invader (+ 30 INVADER-HOR-SPD) (+ 80 INVADER-VERT-SPD) true
                                                (make-invader (+ 50 INVADER-HOR-SPD) (+ 100 INVADER-VERT-SPD) true
                                                              false)))
(check-expect (next-invader (make-invader WIDTH 40 true false)) (make-invader (- WIDTH INVADER-HOR-SPD) (+ 40 INVADER-VERT-SPD) false false))
(check-expect (next-invader (make-invader 0 40 false false)) (make-invader (+ 0 INVADER-HOR-SPD) (+ 40 INVADER-VERT-SPD) true false))

; (define (next-invader loi) loi) ;stub

(define (next-invader loi)
  (cond [(false? loi) false]
        [(false? (invader-d loi))
         (if (> (invader-x loi) 0)
             (make-invader (- (invader-x loi) INVADER-HOR-SPD)
                           (+ (invader-y loi) INVADER-HOR-SPD)
                           false
                           (next-invader (invader-next loi)))
             (make-invader (+ 0 INVADER-HOR-SPD)
                           (+ (invader-y loi) INVADER-HOR-SPD)
                           true
                           (next-invader (invader-next loi))))]
        [else
         (if (< (invader-x loi) WIDTH)
             (make-invader (+ (invader-x loi) INVADER-HOR-SPD)
                           (+ (invader-y loi) INVADER-HOR-SPD)
                           true
                           (next-invader (invader-next loi)))
             (make-invader (- WIDTH INVADER-HOR-SPD)
                           (+ (invader-y loi) INVADER-HOR-SPD)
                           false
                           (next-invader (invader-next loi))))]))


;; Game -> Image
;; Renders the image of the tank, missiles and invaders on the MTS at the appropriate x-coordinates and y-coordinates
(check-expect (render-game G1) (place-image TANK-IMAGE 20 TANK-Y MTS))
(check-expect (render-game G2) (place-image TANK-IMAGE 50 TANK-Y MTS))
(check-expect (render-game (make-game (make-tank 20 true)
                                      (make-missile 10 20 false)
                                      false))
              (place-image TANK-IMAGE 20 TANK-Y
                           (place-image MISSILE-IMAGE 10 20 MTS)))
(check-expect (render-game (make-game (make-tank 50 false)
                                      (make-missile 30 80
                                                    (make-missile 50 100 false))
                                      false))
              (place-image TANK-IMAGE 50 TANK-Y
                           (place-image MISSILE-IMAGE 30 80
                                        (place-image MISSILE-IMAGE 50 100 MTS))))
(check-expect (render-game G3)
              (place-image TANK-IMAGE 20 TANK-Y
                           (place-image MISSILE-IMAGE 10 20
                                        (place-image INVADER-IMAGE 30 80
                                                     (place-image INVADER-IMAGE 50 100 MTS)))))

; (define (render-game g) MTS) ;stub

(define (render-game g)
  (place-image TANK-IMAGE (tank-x (game-tank g)) TANK-Y
                   (render-missile (game-missiles g) (game-invaders g))))

;; ListOfMissile -> Image
;; Renders the image of missiles on the screen
(check-expect (render-missile LOM0 false) MTS)
(check-expect (render-missile LOM1 false) (place-image MISSILE-IMAGE 10 20 MTS))
(check-expect (render-missile LOM2 false) (place-image MISSILE-IMAGE 30 80
                                                       (place-image MISSILE-IMAGE 50 100 MTS)))
(check-expect (render-missile LOM1 LOI2) (place-image MISSILE-IMAGE 10 20
                                                      (place-image INVADER-IMAGE 30 80
                                                                   (place-image INVADER-IMAGE 50 100 MTS))))

; (define (render-missile lom) MTS) ;stub

(define (render-missile lom loi)
  (cond [(false? lom) (render-invader loi)]
        [else
         (place-image MISSILE-IMAGE (missile-x lom) (missile-y lom)
                      (render-missile (missile-next lom) loi))]))

;; ListOfInvaders -> Image
;; Renders the image of invaders on the screen
(check-expect (render-invader LOI1) (place-image INVADER-IMAGE 10 20 MTS))
(check-expect (render-invader LOI2) (place-image INVADER-IMAGE 30 80
                                                 (place-image INVADER-IMAGE 50 100 MTS)))

; (define (render-invader loi) MTS) ;stub

(define (render-invader loi)
  (cond [(false? loi) MTS]
        [else
         (place-image INVADER-IMAGE (invader-x loi) (invader-y loi)
                      (render-invader (invader-next loi)))]))

;; Game -> Boolean
;; Game over when invader reaches the bottom of the screen
(check-expect (game-over G1) false)
(check-expect (game-over G3) false)
(check-expect (game-over (make-game T1 LOM1 (make-invader 70 HEIGHT true false))) true)

; (define (game-over g) false) ;stub

(define (game-over g)
  (cond [(false? (game-invaders g)) false]
        [(>= (invader-y (game-invaders g)) HEIGHT) true]
        [else
         (game-over (make-game (game-tank g)
                               (game-missiles g)
                               (invader-next (game-invaders g))))]))

(define (end-game g)
  (place-image (text "GAME OVER" 50 "black") (/ WIDTH 2) (/ HEIGHT 2) (render-game g)))

;; Game KeyEvent -> Game
;; Pressing left key will make the tank move to the left
;; Pressing right key will make the tank move to the right
;; Pressing space key will make the tank shoot
(check-expect (new-game G1 "right")
              (make-game
               (make-tank 20 true)
               false false))
(check-expect (new-game G1 "left")
              (make-game
               (make-tank 20 false)
               false false))
(check-expect (new-game G2 "right")
              (make-game (make-tank 50 true)
                         false false))
(check-expect (new-game G2 "left")
              (make-game (make-tank 50 false)
                         false false))

; (define (new-game g key) g) ;stub

; Template from KeyEvent
(define (new-game g key)
  (cond [(key=? "right" key) (make-game (make-tank (tank-x (game-tank g)) true)
                                        (game-missiles g)
                                        (game-invaders g))]
        [(key=? "left" key) (make-game (make-tank (tank-x (game-tank g)) false)
                                        (game-missiles g)
                                        (game-invaders g))]
        [(key=? " " key) (make-game (make-tank (tank-x (game-tank g)) (tank-d (game-tank g)))
                                    (make-missile (tank-x (game-tank g)) TANK-Y (game-missiles g))
                                    (make-invader (random WIDTH) 0 true (game-invaders g)))]
        [else g]))
