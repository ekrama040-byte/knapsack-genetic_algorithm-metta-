;; ============================================================================
;; HEURISTIC MUTATION MODULE FOR PeTTa
;; Applies biased flipping while preserving deterministic seed progression
;; ============================================================================

;; 1. Heuristic Gene Flipping Operators (Your optimized bias rules)
;; Flips 0 -> 1 with a 15% probability
(= (heuristic-mutate-bit 0 $w $v $rate $seed) 
   (if (< (% $seed 100) 15) 1 0))

;; Flips 1 -> 0 with a 20% probability (heavier pressure to prevent overcapacity)
(= (heuristic-mutate-bit 1 $w $v $rate $seed) 
   (if (< (% $seed 100) 20) 0 1))


;; 2. Chromosome Processing Loop (State-Passing Style)
(= (heuristic-mutate-chromosome Nil Nil $rate $seed) 
   (Mutation-State Nil $seed))

(= (heuristic-mutate-chromosome (Cons $g $gs) (Cons (Item $w $v) $items) $rate $seed)
   (process-mutation-step $g $w $v $rate $items $gs (% (+ (* 48271 $seed) 11) 2147483647)))

;; Step helper to capture the mutated tail and pass the final seed upwards
(= (process-mutation-step $g $w $v $rate $items $gs $next-seed)
   (assemble-chromosome-mutation 
      (heuristic-mutate-bit $g $w $v $rate $next-seed)
      (heuristic-mutate-chromosome $gs $items $rate $next-seed)))

;; Assembles genes while keeping track of the seed state boundary
(= (assemble-chromosome-mutation $mutated-gene (Mutation-State $rest-chrom $final-seed))
   (Mutation-State (Cons $mutated-gene $rest-chrom) $final-seed))


;; 3. Public Population Orchestrator (Dynamic Case Support)
;; Accepts the active item list and a moving seed state to prevent hardcoding
(= (mutate-population Nil $items $rate $seed) 
   (Population-Mutation-State Nil $seed))

(= (mutate-population (Cons $chrom $rest) $items $rate $seed)
   (process-population-mutation-step 
      (heuristic-mutate-chromosome $chrom $items $rate $seed) 
      $items 
      $rate 
      $rest))

;; Step helper to combine mutated chromosomes across the whole matrix cleanly
(= (process-population-mutation-step (Mutation-State $mutated-chrom $next-seed) $items $rate $rest)
   (assemble-population-mutation 
      $mutated-chrom
      (mutate-population $rest $items $rate $next-seed)))

(= (assemble-population-mutation $chrom (Population-Mutation-State $rest-matrix $final-seed))
   (Population-Mutation-State (Cons $chrom $rest-matrix) $final-seed))
