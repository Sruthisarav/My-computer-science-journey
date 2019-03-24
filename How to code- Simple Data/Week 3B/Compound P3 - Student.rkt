
;; student-starter.rkt

;; =====================================================================================
; 
; PROBLEM A:
; 
; Design a data definition to help a teacher organize their next field trip. 
; On the trip, lunch must be provided for all students. For each student, track 
; their name, their grade (from 1 to 12), and whether or not they have allergies.
; 
;; =====================================================================================

;; Data definitions:
(define-struct student (name grade allergy))
;; Student is (make-student String Natural[1,12] Boolean)
;; interp. (make-student name grade allergy) is a student with:
;;         name is the name of student
;;         grade is the grade of student from grade 1 to 12
;;         allergy is whether or not the student has allergies
(define S1 (make-student "Alex" 5 true))
(define S2 (make-student "Bella" 1 false))
(define S3 (make-student "Catherine" 12 true))

(define (fn-for-student s)
  (... (student-name s)      ;String
       (student-grade s)     ;Natural[1,12]
       (student-allergy s))) ;Boolean

;; Template rules used:
;; - Compound: 3 fields

;; =====================================================================================
; 
; PROBLEM B:
; 
; To plan for the field trip, if students are in grade 6 or below, the teacher 
; is responsible for keeping track of their allergies. If a student has allergies, 
; and is in a qualifying grade, their name should be added to a special list. 
; Design a function to produce true if a student name should be added to this list.
; 
;; =====================================================================================

;; Functions:

;; Student Student -> Boolean
;; produces true if a student has allergy and is in grade 6 or below
(check-expect (special? S1) true)
(check-expect (special? S2) false)
(check-expect (special? S3) false)

; (define (special? s) false) ;stub
#;
(define (special? s)
  (... (student-name s)
       (student-grade s)
       (student-allergy s))) ;template

(define (special? s)
  (if (and (<= (student-grade s) 6) (student-allergy s))
  true
  false))
