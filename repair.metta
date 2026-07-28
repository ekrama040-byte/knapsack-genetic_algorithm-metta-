;; ============================================================================
;; CLEAR FIRST ACTIVE BIT OPERATOR (Strict Cons/Nil Alignment)
;; ============================================================================
(= (clear-first Nil) Nil)
(= (clear-first (Cons 1 $rest)) (Cons 0 $rest))
(= (clear-first (Cons 0 $rest)) (Cons 0 (clear-first $rest)))

;; ============================================================================
;; RECURSIVE KNAPSACK REPAIR ENGINE (Let-Free & Non-Freezing)
;; ============================================================================
(= (repair Nil $items $capacity) Nil)
(= (repair $chromosome $items $capacity)
   (evaluate-and-repair $chromosome (calculate-total $chromosome $items) $items $capacity))

;; Helper: Performs weight bounding check using pure functional matching
(= (evaluate-and-repair $chromosome (Totals $total-w $total-v) $items $capacity)
   (if (<= $total-w $capacity)
       $chromosome                              
       (repair (clear-first $chromosome) $items $capacity)))
