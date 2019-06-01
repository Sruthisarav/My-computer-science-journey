(require 2htdp/image)
;; INCOMPLETE

;  PROBLEM 1:
;  
;  In the lecture videos we designed a function to make a Sierpinski triangle fractal. 
;  
;  Here is another geometric fractal that is made of circles rather than triangles:
;  
;  .
;  
;  Design a function to create this circle fractal of size n and colour c.
;  
;; =======================================================================================

(define CUT-OFF 5)

;; Natural String -> Image
;; produce a circle fractal of size n and colour c
(check-expect (circle-fractal 5 "blue")
              (circle 5 "outline" "blue"))
(check-expect (circle-fractal 10 "red")
              (overlay (circle 10 "outline" "red")
                       (beside (circle 5 "outline" "red")
                               (circle 5 "outline" "red"))))

(check-expect (circle-fractal 20 "yellow")
              (local [(define main (circle 20 "outline" "yellow"))
                      (define small (circle 10 "outline" "yellow"))
                      (define smaller (circle 5 "outline" "yellow"))]
                (overlay main
                         (beside
                          (overlay small
                                   (beside smaller smaller))
                          (overlay small
                                   (beside smaller smaller))))))


; (define (circle-fractal n c) empty-image) ;stub

(define (circle-fractal n c)
  (if (<= n CUT-OFF)
      (circle n "outline" c)
      (local [(define main (circle n "outline" c))
              (define small (circle-fractal (/ n 2) c))]
        (overlay main
                 (beside small small)))))

;; =======================================================================================
;  PROBLEM 2:
;  
;  Below you will find some data definitions for a tic-tac-toe solver. 
;  
;  In this problem we want you to design a function that produces all 
;  possible filled boards that are reachable from the current board. 
;  
;  In actual tic-tac-toe, O and X alternate playing. For this problem
;  you can disregard that. You can also assume that the players keep 
;  placing Xs and Os after someone has won. This means that boards that 
;  are completely filled with X, for example, are valid.
;  
;  Note: As we are looking for all possible boards, rather than a winning 
;  board, your function will look slightly different than the solve function 
;  you saw for Sudoku in the videos, or the one for tic-tac-toe in the 
;  lecture questions. 
;  
;; =======================================================================================

;; Value is one of:
;; - false
;; - "X"
;; - "O"
;; interp. a square is either empty (represented by false) or has and "X" or an "O"

(define (fn-for-value v)
  (cond [(false? v) (...)]
        [(string=? v "X") (...)]
        [(string=? v "O") (...)]))

;; Board is (listof Value)
;; a board is a list of 9 Values
(define B0 (list false false false
                 false false false
                 false false false))

(define B1 (list false "X"   "O"   ; a partly finished board
                 "O"   "X"   "O"
                 false false "X")) 

(define B2 (list "X"  "X"  "O"     ; a board where X will win
                 "O"  "X"  "O"
                 "X" false "X"))

(define B3 (list "X" "O" "X"       ; a board where Y will win
                 "O" "O" false
                 "X" "X" false))

(define B4 (list "X" "O" "X"       ; a filled board
                 "O" "O" "X"
                 "X" "X" "O"))

#;
(define (fn-for-board b)
  (cond [(empty? b) (...)]
        [else 
         (... (fn-for-value (first b))
              (fn-for-board (rest b)))]))

(define (solve-board b)
  (local [(define (solve--b b)
            (if (solved? b)
                b
                (solve--lob (next-boards b))))
          (define (solve--lob lob)
            (cond [(empty? lob) false]
                  [else
                   (local [(define try (solve--b (first lob)))]
                     (if (not (false? try))
                         try
                         (solve--lob (rest lob))))]))]
    (solve--b b)))

;; Board -> Boolean
;; Produce true if board is solved
;; Assume: Board is valid, so it is solved if it is full
(check-expect (solved? B1) false)
(check-expect (solved? B2) false)
(check-expect (solved? B4) true)

(define (solved? b)
  (andmap string? b))

;; Board -> (listof Board)
;; produce list of valid next boards from board
;; finds first empty space, fills it with String "X" or "O", keeps only valid boards
(check-expect (next-boards B1) (list (list "X" "X"   "O"  
                                           "O"   "X"   "O"
                                           false false "X")
                                     (list "O" "X"   "O"  
                                           "O"   "X"   "O"
                                           false false "X")))

(define (next-boards b) empty) ;stub

(define (next-boards b)
  (keep-only-valid (fill-with-string (find-blank b) b)))

;; Board -> Position
;; Produces the position of the first blank space
;; Assume: the board has at least one blank space
(check-expect (find-blank B1) 0)

(define (find-blank b) 0) ;stub

;; Position Board -> (listof Board)
;; produces 2 boards, with spaces filled with String "X" or "O"
;; !!!

(define (fill-with-string b) empty) ;stub

;; (listof Board) -> (listof Board)
;; produces list containing only valid boards
;; !!!

(define (keep-only-valid lob) empty) ;stub

;; =======================================================================================
;  PROBLEM 3:
;  
;  Now adapt your solution to filter out the boards that are impossible if 
;  X and O are alternating turns. You can continue to assume that they keep 
;  filling the board after someone has won though. 
;  
;  You can assume X plays first, so all valid boards will have 5 Xs and 4 Os.
;  
;  NOTE: make sure you keep a copy of your solution from problem 2 to answer 
;  the questions on edX.
;  
