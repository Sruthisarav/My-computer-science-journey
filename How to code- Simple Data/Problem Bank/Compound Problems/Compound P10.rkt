;  
;  In this problem, you will be designing a simple one-line text editor.
;  
;  The constants and data definitions are provided for you, so make sure 
;  to take a look through them after completing your own Domain Analysis. 
;  
;  Your text editor should have the following functionality:
;  - when you type, characters should be inserted on the left side of the cursor 
;  - when you press the left and right arrow keys, the cursor should move accordingly  
;  - when you press backspace (or delete on a mac), the last character on the left of 
;    the cursors should be deleted
;  
;; ====================================================================================================

(require 2htdp/image)
(require 2htdp/universe)

;; A simple editor

;; Constants:

(define WIDTH 300)
(define HEIGHT 20)
(define CTR-Y (/ HEIGHT 2))
(define CTR-X (/ WIDTH 2))
(define MTS (empty-scene WIDTH HEIGHT))

(define CURSOR (rectangle 2 14 "solid" "red"))

(define TEXT-SIZE 14)
(define TEXT-COLOUR "black")

;; Data Definitions:

(define-struct editor (pre post))
;; Editor is (make-editor String String)
;; interp. pre is the text before the cursor, post is the text after
(define E0 (make-editor "" ""))
(define E1 (make-editor "a" ""))
(define E2 (make-editor "" "b"))

#;
(define (fn-for-editor e)
  (... (editor-pre e)
       (editor-post e))) ;template

;; Template rules used:
;; Compound: 2 fields

;; Functions:

;; Editor -> Editor
;; Starts off with a blank screen and a cursor on the left; (main (make-editor "" ""))

(define (main e)
  (big-bang e               ;; Editor
    (to-draw render-editor) ;; Editor -> Image
    (on-key new-editor))) ;; Editor KeyEvent -> Editor

;; Editor -> Image
;; Place the appropriate text at the appropriate place on MTS
(check-expect (render-editor (make-editor "hello " "world"))
              (place-image (beside (text "hello " TEXT-SIZE TEXT-COLOUR)
                                   CURSOR
                                   (text "world" TEXT-SIZE TEXT-COLOUR))
                           CTR-X
                           CTR-Y
                           MTS))
(check-expect (render-editor (make-editor "my name is " "idk"))
              (place-image (beside (text "my name is " TEXT-SIZE TEXT-COLOUR)
                                   CURSOR
                                   (text "idk" TEXT-SIZE TEXT-COLOUR))
                           CTR-X
                           CTR-Y
                           MTS))

; (define (render-editor e) MTS) ;stub

(define (render-editor e)
  (place-image (beside (text (editor-pre e) TEXT-SIZE TEXT-COLOUR)
                       CURSOR
                       (text (editor-post e) TEXT-SIZE TEXT-COLOUR))
               CTR-X
               CTR-Y
               MTS))


;; Editor KeyEvent -> Editor
;; when you press the left and right arrow keys, the cursor should move accordingly  
;; when you press backspace (or delete on a mac), the last character on the left of 
;; the cursors should be deleted
(check-expect (new-editor (make-editor "hello" "world") " ") (make-editor "hello " "world"))
(check-expect (new-editor (make-editor "hello " "world") "left") (make-editor "hello" " world"))
(check-expect (new-editor (make-editor "hello " "world") "right") (make-editor "hello w" "orld"))
(check-expect (new-editor (make-editor "hello s" "world") "\b") (make-editor "hello " "world"))
(check-expect (new-editor (make-editor "hell" " world") "o") (make-editor "hello" " world"))


; (define (new-editor e key) e) ;stub


(define (new-editor e key)
  (cond [(key=? "right" key)
         (make-editor (string-append (editor-pre e) (substring (editor-post e) 0 1))
                      (substring (editor-post e) 1 (string-length (editor-post e))))]
        [(key=? "left" key)
         (make-editor (substring (editor-pre e) 0 (- (string-length (editor-pre e)) 1))
                      (string-append
                       (substring (editor-pre e) (- (string-length (editor-pre e)) 1) (string-length (editor-pre e)))
                       (editor-post e)))]
        [(key=? "\b" key)
         (make-editor (substring (editor-pre e) 0 (- (string-length (editor-pre e)) 1))
                      (editor-post e))]
        [(= (string-length key) 1)
         (make-editor (string-append (editor-pre e) key)
                      (editor-post e))]
        [else e]))
