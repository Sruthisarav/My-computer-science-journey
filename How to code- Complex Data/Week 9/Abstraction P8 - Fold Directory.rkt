(require 2htdp/image)
; 
; In this exercise you will be need to remember the following DDs 
; for an image organizer.
; 


;; =================
;; Data definitions:

(define-struct dir (name sub-dirs images))
;; Dir is (make-dir String ListOfDir ListOfImage)
;; interp. An directory in the organizer, with a name, a list
;;         of sub-dirs and a list of images.

;; ListOfDir is one of:
;;  - empty
;;  - (cons Dir ListOfDir)
;; interp. A list of directories, this represents the sub-directories of
;;         a directory.

#;
(define (fn-for-dir d)
  (local [(define (fn-for-dir d)
            (... (dir-name d)
                 (dir-images d)
                 (fn-for-lod (dir-sub-dirs d))))
          (define (fn-for-lod lod)
            (cond [(empty? lod) (...)]
                  [else
                   (... (fn-for-dir (first lod))
                        (fn-for-lod (rest lod)))]))]
    (fn-for-dir d)))

;; ListOfImage is one of:
;;  - empty
;;  - (cons Image ListOfImage)
;; interp. a list of images, this represents the sub-images of a directory.
;; NOTE: Image is a primitive type, but ListOfImage is not.

(define I1 (square 10 "solid" "red"))
(define I2 (square 12 "solid" "green"))
(define I3 (rectangle 13 14 "solid" "blue"))
(define D4 (make-dir "D4" empty (list I1 I2)))
(define D5 (make-dir "D5" empty (list I3)))
(define D6 (make-dir "D6" (list D4 D5) empty))

;; =================
;; Functions:

; 
; PROBLEM A:
; 
; Design an abstract fold function for Dir called fold-dir. 
; 
;; =============================================================

;; (String Y Z -> X) (X Y -> Y) (Image Z -> Z) Y Z Dir -> X
;; the abstract fold function for Dir (and ListOfDir)

(define (fold-dir f1 f2 f3 b1 b2 d)
  (local [(define (fn-for-dir d)          ;->X
            (f1 (dir-name d)
                (fn-for-lod (dir-sub-dirs d))
                (fn-for-loi (dir-images d))))
          (define (fn-for-lod lod)        ;->Y
            (cond [(empty? lod) b1]
                  [else
                   (f2 (fn-for-dir (first lod))
                       (fn-for-lod (rest lod)))]))
          (define (fn-for-loi loi)        ;->Z
            (cond [(empty? loi) b2]
                  [else
                   (f3 (first loi)
                       (fn-for-loi (rest loi)))]))]
    (fn-for-dir d)))

;; =============================================================
; 
; PROBLEM B:
; 
; Design a function that consumes a Dir and produces the number of 
; images in the directory and its sub-directories. 
; Use the fold-dir abstract function.
; 
;; =============================================================

;; Dir -> Natural
;; Produces the number of images in the directory and sub-directories of a Dir
(check-expect (count-image D4) 2)
(check-expect (count-image D5) 1)
(check-expect (count-image D6) 3)

(define (count-image d)
  (local [(define (f1 n flod floi) (+ flod floi))
          (define (f2 fd flod) (+ fd flod))
          (define (f3 i floi) (+ 1 floi))]
    (fold-dir f1 f2 f3 0 0 d)))

;; =============================================================
; 
; PROBLEM C:
; 
; Design a function that consumes a Dir and a String. The function looks in
; dir and all its sub-directories for a directory with the given name. If it
; finds such a directory it should produce true, if not it should produce false. 
; Use the fold-dir abstract function.
; 
;; =============================================================

;; Dir String -> Boolean
;; Produces true if it finds a directory with the given name
(check-expect (dir-name? "D5" D6) true)
(check-expect (dir-name? "D1" D5) false)


(define (dir-name? s d)
  (local [(define (f1 n flod floi) (or (string=? n s)
                                       flod
                                       floi))
          (define (f2 fd flod) (or fd flod))
          (define (f3 i floi) false)]
    (fold-dir f1 f2 f3 false false d)))


;; =============================================================
; 
; PROBLEM D:
; 
; Is fold-dir really the best way to code the function from part C? Why or 
; why not?
; 
;; =============================================================

;; No. Even when the function finds the directory, it will still continue searching
;; the rest of the tree for another directory with the same name, which doesn't exist.
