;; ============================================================================
;; SMART HEURISTIC GENE FLIP OPERATORS (Pure Integer LCG Scaling)
;; ============================================================================

;; Rule 1: Gene is 0 (Outside Bag)
(= (heuristic-mutate-bit 0 $weight $value $rate $seed-val)
   (if (< (% $seed-val 100) 5) 1 0))

;; Rule 2: Gene is 1 (Inside Bag)
(= (heuristic-mutate-bit 1 $weight $value $rate $seed-val)
   (if (< (% $seed-val 100) 10) 0 1))

;; ============================================================================
;; CHROMOSOME MUTATION LIFECYCLE ENGINE
;; ============================================================================
(= (heuristic-mutate-chromosome Nil Nil $rate) Nil)
(= (heuristic-mutate-chromosome $genes $items $rate) 
   (run-mutation-loop $genes $items $rate 54321))

;; Base Case
(= (run-mutation-loop Nil Nil $rate $seed) Nil)

;; Recursive Step: Shifts the LCG calculation directly into the functional argument stream
(= (run-mutation-loop (Cons $g $gs) (Cons (Item $w $v) $items) $rate $seed)
   (step-mutation-loop $g $gs $w $v $items $rate (% (+ (* 1103515245 $seed) 12345) 65536)))

;; Helper: Extracts the results cleanly without creating let variable traps
(= (step-mutation-loop $g $gs $w $v $items $rate $next-seed)
   (Cons (heuristic-mutate-bit $g $w $v $rate $next-seed) 
         (run-mutation-loop $gs $items $rate $next-seed)))
