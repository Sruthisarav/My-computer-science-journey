; In this problem set you will represent information about descendant family 
; trees from Harry Potter and design functions that operate on those trees.
; 
; To make your task much easier we suggest two things:
;   - you only need a DESCENDANT family tree
;   - read through this entire problem set carefully to see what information 
;     the functions below are going to need. Design your data definitions to
;     only represent that information.
;   - you can find all the information you need by looking at the individual 
;     character pages like the one we point you to for Arthur Weasley.
; 


; PROBLEM 1:
; 
; Design a data definition that represents a family tree from the Harry Potter 
; wiki, which contains all necessary information for the other problems.  You 
; will use this data definition throughout the rest of the homework.
; 
;; ================================================================================

;; Data definitions:

(define-struct wizard (name patronus wand children))
;; Person is (make-wizard String String String ListOfWizard)
;; interp. a Wizard in the family tree
;;         name is the first name of the wizard
;;         patronus is a defensive charm ("" if none)
;;         wand is the material of the wand ("" if none)
;;         children is the children of the wizard (empty if none)

;; ListOfWizard is one of:
;; - empty
;; - (cons wizard ListOfWizard)
;; interp. a list of people in the family tree

#;
(define (fn-for-wizard w)
  (... (wizard-name w)
       (wizard-patronus w)
       (wizard-wand w)
       (fn-for-low (wizard-children w))))
#;
(define (fn-for-low low)
  (cond [(empty? low) (...)]
        [else
         (... (fn-for-wizard (first low))
              (fn-for-low (rest low)))]))

;; ================================================================================
; PROBLEM 2: 
; 
; Define a constant named ARTHUR that represents the descendant family tree for 
; Arthur Weasley. You can find all the infomation you need by starting 
; at: http://harrypotter.wikia.com/wiki/Arthur_Weasley.
; 
; You must include all of Arthur's children and these grandchildren: Lily, 
; Victoire, Albus, James.
; 
; 
; Note that on the Potter wiki you will find a lot of information. But for some 
; people some of the information may be missing. Enter that information with a 
; special value of "" (the empty string) meaning it is not present. Don't forget
; this special value when writing your interp.
; 
;; ================================================================================

(define VICTOIRE (make-wizard "Victoire" "" "" empty))
(define LILY (make-wizard "Lily" "" "" empty))
(define ALBUS (make-wizard "Albus" "" "wood" empty))
(define JAMES (make-wizard "James" "" "" empty))
(define BILL (make-wizard "Bill" "" "wood" (cons VICTOIRE empty)))
(define CHARLES (make-wizard "Charles" "" "Ash" empty))
(define PERCY (make-wizard "Percy" "" "" empty))
(define FRED (make-wizard "Fred" "" "" empty))
(define GEORGE (make-wizard "George" "" "" empty))
(define RON (make-wizard "Ronald" "Jack Russell terrier" "Ash" empty))
(define GINNY (make-wizard "Ginny" "Horse" "Yew" (list JAMES ALBUS LILY)))
(define ARTHUR (make-wizard "Arthur" "Weasel" "wood" (list BILL CHARLES PERCY FRED GEORGE RON GINNY)))

;; ================================================================================
; PROBLEM 3:
; 
; Design a function that produces a pair list (i.e. list of two-element lists)
; of every person in the tree and his or her patronus. For example, assuming 
; that HARRY is a tree representing Harry Potter and that he has no children
; (even though we know he does) the result would be: (list (list "Harry" "Stag")).
; 
; You must use ARTHUR as one of your examples.
; 
;; ================================================================================

;; ListOfPair is one of:
;; - empty
;; - (cons (list String String) ListOfPair)
;; interp. a list of arbitrary number of pairs of strings
(define LOP0 empty)
(define LOP1 (cons (list "Harry" "Stag") empty))
(define LOP2 (list (list "Arthur" "weasel") (list "Ginny" "Horse")))

#;
(define (fn-for-lop lop)
  (cond [(empty? lop) (...)]
        [else
         (... (first (first lop))
              (second (first lop))
              (fn-for-lop (rest lop)))]))

;; Wizard -> ListOfPair
;; ListOfWizard -> ListOfPair
;; Produces a pair list of every wizard in the tree
(check-expect (patronus--wizard LILY) (list (list "Lily" "")))
(check-expect (patronus--wizard GINNY) (list (list "Ginny" "Horse")
                                             (list "James" "")
                                             (list "Albus" "")
                                             (list "Lily" "")))
(check-expect (patronus--low empty) empty)
(check-expect (patronus--wizard BILL) (list (list "Bill" "")
                                            (list "Victoire" "")))

; (define (patronus--wizard w) empty) ;stub
; (define (patronus--low low) empty)  ;stub


(define (patronus--wizard w)
  (cons (list (wizard-name w)
              (wizard-patronus w))
        (patronus--low (wizard-children w))))

(define (patronus--low low)
  (cond [(empty? low) empty]
        [else
         (append (patronus--wizard (first low))
                 (patronus--low (rest low)))]))

;; ================================================================================
; PROBLEM 4:
; 
; Design a function that produces the names of every person in a given tree 
; whose wands are made of a given material. 
; 
; You must use ARTHUR as one of your examples.
; 
;; ================================================================================

;; ListOfName is one of:
;; - empty
;; - (cons String ListOfName)
;; interp. an arbitrary number of names

#;
(define (fn-for-lon lon)
  (cond [(empty? lon) (...)]
        [else
         (... (first (first lon))
              (fn-for-lon (rest lon)))]))

;; Wizard String -> ListOfName
;; ListOfWizard String -> ListOfName
;; Produces the names of every person in a given tree whose wands are made of a given material
(check-expect (wand--wizard VICTOIRE "") (list "Victoire"))
(check-expect (wand--wizard VICTOIRE "ash") empty)
(check-expect (wand--wizard ARTHUR "wood") (list "Arthur" "Bill" "Albus"))

; (define (wand--wizard w m) empty) ;stub
; (define (wand--low low m) empty)  ;stub

(define (wand--wizard w m)
  (if (string=? (wizard-wand w) m)
      (cons (wizard-name w)
            (wand--low (wizard-children w) m))
      (wand--low (wizard-children w) m)))

(define (wand--low low m)
  (cond [(empty? low) empty]
        [else
         (append (wand--wizard (first low) m)
                 (wand--low (rest low) m))]))
