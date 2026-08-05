;; Base Cases: Catch any variation of list termination safely
(= (calculate-weight Nil Nil) 0)
(= (calculate-weight () ()) 0)

;; Recursive Rules: Unpack items dynamically
(= (calculate-weight (Cons 0 $genes) (Cons (Item $weight $value) $items))
   (calculate-weight $genes $items))

(= (calculate-weight (Cons 1 $genes) (Cons (Item $weight $value) $items))
   (+ $weight (calculate-weight $genes $items)))

;; Value Accumulator Loop
(= (calculate-value Nil Nil) 0)
(= (calculate-value () ()) 0)

(= (calculate-value (Cons 0 $genes) (Cons (Item $weight $value) $items))
   (calculate-value $genes $items))

(= (calculate-value (Cons 1 $genes) (Cons (Item $weight $value) $items))
   (+ $value (calculate-value $genes $items)))

;; Master Fitness Engine
(= (fitness $chromosome $items $capacity)
   (if (> (calculate-weight $chromosome $items) $capacity)
       0 
       (calculate-value $chromosome $items)))


;; ============================================================================
;; MASTER MODULAR IMPCRIPTIONS
;; ============================================================================
!(import! &self cases)
!(import! &self population)
!(import! &self fitness)
!(import! &self repair)
!(import! &self selection)
!(import! &self crossover)
!(import! &self mutation)

;; ============================================================================
;; PURE FUNCTIONAL EVOLUTIONARY CORE PIPELINE
;; ============================================================================

(= (evaluate-and-find-best (Case $capacity $items) $rate $case-num)
   (process-with-parents (get-parent-one $items) (get-parent-two $items) $items $capacity $rate $case-num))

(= (process-with-parents $p1 $p2 $items $capacity $rate $case-num)
   (process-with-repaired 
      (repair $p1 $items $capacity)
      (repair $p2 $items $capacity)
      (repair (heuristic-mutate-chromosome (uniform-crossover $p1 $p2 (generate-crossover-mask $p1 1)) $items $rate) $items $capacity)
      $items $capacity $case-num))

(= (process-with-repaired $rep-p1 $rep-p2 $rep-off $items $capacity $case-num)
   (build-final-result 
      (select-best-of-pool (Cons $rep-p1 (Cons $rep-p2 (Cons $rep-off Nil))) $items $capacity)
      $items $case-num))

(= (build-final-result $best-chrom $items $case-num)
   (Row (Case $case-num) 
        (Weight (calculate-weight $best-chrom $items)) 
        (Value (calculate-value $best-chrom $items)) 
        (Best-Chromosome $best-chrom)))
;; ============================================================================
;; HARDCODE-FREE RECURSIVE DISPATCHER GRID (Fixed One-Pass Layout)
;; ============================================================================

;; We use an explicit match statement to securely anchor the specific items.
;; This isolates the database search and cuts off Prolog's duplicate loop forks.

(= (run-evolution-grid $current $max $rate)
   (if (> $current $max)
       Nil
       (match &self (= (get-case $current) (Case $capacity $items))
          (Cons (process-with-parents (get-parent-one $items) (get-parent-two $items) $items $capacity $rate $current)
                (run-evolution-grid (+ $current 1) $max $rate)))))








;; ============================================================================
;; MAIN RUNNABLE EXECUTION TARGET (FORCED CONSOLE VISIBILITY)
;; ============================================================================
!(METTA-KNAPSACK-EVOLUTIONARY-RESULTS (run-evolution-grid 1 20 0.05))