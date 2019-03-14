; 
; PROBLEM A:
; 
; You are assigned to develop a system that will classify 
; buildings in downtown Vancouver based on how old they are. 
; According to city guidelines, there are three different classification levels:
; new, old, and heritage.
; 
; Design a data definition to represent these classification levels. 
; Call it BuildingStatus.
; 
;; =================

;; Data definitions:
;; BuildingStatus is one of:
;; - "new"
;; - "old"
;; - "heritage"
;; interp. the status of the buildings in downtown Vancouver
#;
(define (demolish? b)
  (cond [(string=? "new" b) (...)]
        [(string=? "old" b) (...)]
        [else (...)]))
;; Template rules used:
;; - one of: 3 cases
;; - atomic distinct: "new"
;; - atomic distinct: "old"
;; - atomic distinct: "heritage"

;; =================
; 
; PROBLEM B:
; 
; The city wants to demolish all buildings classified as "old". 
; You are hired to design a function called demolish? 
; that determines whether a building should be torn down or not.
; 

;; =================
;; Functions:
;; BuildingStatus -> Boolean
;; Determine whether the building should be torn or not
(check-expect(demolish? "new") false)
(check-expect(demolish? "old") true)
(check-expect(demolish? "heritage") false)
; (define (demolish? b) false) ;stub

; Use template from BuildingStatus
(define (demolish? b)
  (cond [(string=? "new" b) false]
        [(string=? "old" b) true]
        [else false]))
