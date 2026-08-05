;; ============================================================================
;; MAIN MODULE ORCHESTRATOR (BUG-FIXED MODULAR VERSION)
;; Forces explicit functional reduction to fix PeTTa transpilation errors
;; ============================================================================

;; 1. Import GA Core Components
!(import! &self population)
!(import! &self fitness)
!(import! &self selection)
!(import! &self repair)
!(import! &self crossover)
!(import! &self mutation)
!(import! &self cases)


;; ----------------------------------------------------------------------------
;; 2. Local Module Proxies (Informs PeTTa that these are active functions)
;; ----------------------------------------------------------------------------
(= (call-select-best $pop $items) (select-best $pop $items))
(= (call-execute-crossover $p1 $p2 $length $seed) (execute-crossover $p1 $p2 $length $seed))
(= (call-mutate-population $pop $items $rate $seed) (mutate-population $pop $items $rate $seed))
(= (call-repair $chrom $items $capacity) (repair $chrom $items $capacity))

;; ----------------------------------------------------------------------------
;; 3. Hardcoded Configuration Constants
;; ----------------------------------------------------------------------------
(= (pop-size) 4)         
(= (max-generations) 5)  
(= (base-seed) 8888888)  

;; ----------------------------------------------------------------------------
;; 4. Master Case Range Looping System
;; ----------------------------------------------------------------------------
(= (run-all-cases $start $end $mutation-rate)
   (if (<= $start $end)
       (execute-and-advance-case $start (get-case $start) $end $mutation-rate)
       (Execution-Completed)))

(= (execute-and-advance-case $id (Case $capacity $items) $end $mutation-rate)
   (dispatch-case-pipeline $id $capacity $items (run-single-case $items $capacity $mutation-rate) $end $mutation-rate))

(= (execute-and-advance-case $id Nil $end $mutation-rate)
   (run-all-cases (+ $id 1) $end $mutation-rate))

(= (dispatch-case-pipeline $id $capacity $items (Case-Result $best-chrom $v $w) $end $mutation-rate)
   (advance-after-print 
       (println! (Final-Report Case $id Max-Value $v Max-Weight $w Chromosome $best-chrom)) 
       $id $end $mutation-rate))

(= (advance-after-print $void $id $end $mutation-rate)
   (run-all-cases (+ $id 1) $end $mutation-rate))

;; ----------------------------------------------------------------------------
;; 5. Single Case Pipeline Execution
;; ----------------------------------------------------------------------------
(= (run-single-case $items $capacity $mutation-rate)
   (bridge-initial-pop (generate-population $items (pop-size) (base-seed)) $items $capacity $mutation-rate))

(= (bridge-initial-pop $initial-pop $items $capacity $mutation-rate)
   (evolutionary-loop $initial-pop $items $capacity $mutation-rate (max-generations) (+ (base-seed) 99)))

;; ----------------------------------------------------------------------------
;; 6. Evolutionary Loop
;; ----------------------------------------------------------------------------
(= (evolutionary-loop $pop $items $capacity $mutation-rate 0 $seed)
   (dispatch-champion-extraction (call-select-best $pop $items) $items))

(= (evolutionary-loop $pop $items $capacity $mutation-rate $gen $seed)
   (dispatch-generation-step1 (call-select-best $pop $items) $pop $items $capacity $mutation-rate $gen $seed))

(= (dispatch-generation-step1 $elite-parent $pop $items $capacity $mutation-rate $gen $seed)
   (apply-breeding-pipeline $elite-parent $pop $items $capacity $mutation-rate (- $gen 1)
       (% (+ (* $seed 1103515245) 12345) 2147483648)))

;; ----------------------------------------------------------------------------
;; 7. Breeding Pipeline Execution
;; ----------------------------------------------------------------------------
(= (apply-breeding-pipeline $elite $pop $items $capacity $mutation-rate $next-gen $fresh-seed)
   (dispatch-breeding-step1 (breed-new-population $pop $items (pop-size) $fresh-seed) $elite $items $capacity $mutation-rate $next-gen $fresh-seed))

(= (dispatch-breeding-step1 $bred-pop $elite $items $capacity $mutation-rate $next-gen $fresh-seed)
   (dispatch-breeding-step2 (call-mutate-population $bred-pop $items $mutation-rate $fresh-seed) $elite $items $capacity $next-gen))

(= (dispatch-breeding-step2 (Population-Mutation-State $mutated-matrix $final-seed) $elite $items $capacity $next-gen)
   (evolutionary-loop (Cons $elite (repair-matrix $mutated-matrix $items $capacity)) $items $capacity $mutation-rate $next-gen $final-seed))

;; ----------------------------------------------------------------------------
;; 8. Breeding Workers
;; ----------------------------------------------------------------------------
(= (breed-new-population $pop $items 0 $seed) Nil)
(= (breed-new-population $pop $items $count $seed)
   (dispatch-crossover-parent1 (call-select-best $pop $items) $pop $items $count $seed))

(= (dispatch-crossover-parent1 $p1 $pop $items $count $seed)
   (dispatch-crossover-parent2 (call-select-best $pop $items) $p1 $pop $items $count $seed))

(= (dispatch-crossover-parent2 $p2 $p1 $pop $items $count $seed)
   (dispatch-crossover-execution (call-execute-crossover $p1 $p2 (get-items-length $items) $seed) $pop $items $count))

(= (dispatch-crossover-execution (Crossover-Result $child $next-seed) $pop $items $count)
   (Cons $child (breed-new-population $pop $items (- $count 1) $next-seed)))

;; ----------------------------------------------------------------------------
;; 9. Repair Matrix Runner
;; ----------------------------------------------------------------------------
(= (repair-matrix Nil $items $capacity) Nil)
(= (repair-matrix (Cons $c $cs) $items $capacity)
   (Cons (call-repair $c $items $capacity) (repair-matrix $cs $items $capacity)))

;; ----------------------------------------------------------------------------
;; 10. Structural Calculation Utilities
;; ----------------------------------------------------------------------------
(= (get-items-length Nil) 0)
(= (get-items-length (Cons $x $xs)) (+ 1 (get-items-length $xs)))

(= (dispatch-champion-extraction $champ $items)
   (Case-Result $champ (calculate-value $champ $items) (calculate-weight $champ $items)))


;; Trigger the execution for Cases 1 through 18 with a 5% mutation rate
!(run-all-cases 1 20 0.05)

