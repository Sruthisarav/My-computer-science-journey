; Problem:
; 
; Starting with the following data definition for a binary tree (not a binary search tree) 
; design a tail-recursive function called contains? that consumes a key and a binary tree 
; and produces true if the tree contains the key.
; 
;; ======================================================================================

(define-struct node (k v l r))
;; BT is one of:
;;  - false
;;  - (make-node Integer String BT BT)
;; Interp. A binary tree, each node has a key, value and 2 children
(define BT1 false)
(define BT2 (make-node 1 "a"
                       (make-node 6 "f"
                                  (make-node 4 "d" false false)
                                  false)
                       (make-node 7 "g" false false)))

#;
(define (fn-for-bt bt)
  (cond [(false? bt) (...)]
        [else
         (... (node-k bt)
              (node-v bt)
              (node-l bt)
              (node-r bt))]))

;; Integer BT -> Boolean
;; Produces true if the given BT contains the given key
(check-expect (contains? 1 BT2) true)
(check-expect (contains? 5 BT2) false)

(define (contains? key bt)
  ;; todo is the sub trees that are unvisited
  (local [(define (fn-for-bt bt todo)
            (cond [(false? bt) (fn-for-btl todo)]
                  [else
                   (if (= (node-k bt) key)
                       true
                       (fn-for-btl (cons (node-l bt)
                                         (cons (node-r bt)
                                               todo))))]))
          (define (fn-for-btl todo)
            (cond [(empty? todo) false]
                  [else
                   (fn-for-bt (first todo)
                              (rest todo))]))]
    (fn-for-bt bt empty)))
