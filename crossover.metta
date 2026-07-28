;; ============================================================================
;; GENERIC CROSSOVER MASK GENERATOR (Infinite Scale, Let-Free)
;; ============================================================================

;; Generates a perfectly sized Cons mask dynamically based on runtime item length
(= (generate-crossover-mask Nil $idx) Nil)

;; FIXED: Inlined the alternating modulo math directly to completely eliminate let-blocks
(= (generate-crossover-mask (Cons $x $xs) $idx)
   (Cons (if (== (% $idx 2) 0) 1 0) (generate-crossover-mask $xs (+ $idx 1))))

;; ============================================================================
;; DETERMINISTIC UNIFORM CROSSOVER OPERATOR (Strict Cons/Nil Alignment)
;; ============================================================================

;; Base Case: When the end of the parent strings is reached, return Nil
(= (uniform-crossover Nil Nil Nil) 
   Nil)

;; Condition 1: Mask bit is 1 -> Inherit gene strictly from Parent 1 ($p1)
(= (uniform-crossover (Cons $p1 $r1) (Cons $p2 $r2) (Cons 1 $m-rest))
   (Cons $p1 (uniform-crossover $r1 $r2 $m-rest)))

;; Condition 2: Mask bit is 0 -> Inherit gene strictly from Parent 2 ($p2)
(= (uniform-crossover (Cons $p1 $r1) (Cons $p2 $r2) (Cons 0 $m-rest))
   (Cons $p2 (uniform-crossover $r1 $r2 $m-rest)))
