;; ============================================================================
;; CROSSOVER MODULE FOR PeTTa
;; Performs deterministic single-point crossover using an LCG seed state
;; ============================================================================

;; 1. Standard LCG primitive (matching your population generator)
(= (next-crossover-seed $seed)
   (% (+ (* $seed 1103515245) 12345) 2147483648))

;; 2. Maps the seed value into a valid splitting index bounded by the chromosome length
(= (seed-to-index $seed $length)
   (+ 1 (% $seed (- $length 1))))

;; 3. Core Splicing Engine (Your optimized structural recursion)
(= (single-point-crossover Nil Nil $_) Nil)
(= (single-point-crossover (Cons $p1 $r1) (Cons $p2 $r2) $idx)
   (if (> $idx 0)
       (Cons $p1 (single-point-crossover $r1 $r2 (- $idx 1)))
       (Cons $p2 (single-point-crossover $r1 $r2 0))))

;; 4. Orchestrator: Accepts parents, length, and seed; outputs child and next seed state
(= (execute-crossover $parent1 $parent2 $length $seed)
   (dispatch-crossover-step $parent1 $parent2 (seed-to-index $seed $length) (next-crossover-seed $seed)))

;; 5. Step helper to package the new child alongside its mutated seed state
(= (dispatch-crossover-step $parent1 $parent2 $idx $next-seed)
   (Crossover-Result (single-point-crossover $parent1 $parent2 $idx) $next-seed))
