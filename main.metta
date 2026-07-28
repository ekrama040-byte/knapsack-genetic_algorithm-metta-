;; ============================================================================
;; MASTER MODULAR IMPORTS
;; ============================================================================
!(import! &self cases)
!(import! &self population)
!(import! &self fitness)
!(import! &self repair)
!(import! &self selection)
!(import! &self crossover)
!(import! &self mutation)

;; ============================================================================
;; PIPELINE INTEGRATION & NATIVE PRINTER ENGINE
;; ============================================================================

;; Step 1: Entry Point
(= (evaluate-and-find-best (Case $capacity $items) $rate $case-num)
   (process-with-parents (get-parent-one $items) (get-parent-two $items) $items $capacity $rate $case-num))

;; Step 2: Crossover, Mutate & Repair
(= (process-with-parents $p1 $p2 $items $capacity $rate $case-num)
   (process-with-repaired 
      (repair $p1 $items $capacity)
      (repair $p2 $items $capacity)
      (repair (heuristic-mutate-chromosome (uniform-crossover $p1 $p2 (generate-crossover-mask $p1 1)) $items $rate) $items $capacity)
      $items 
      $capacity
      $case-num))

;; Step 3: Pool Tournament Selection
(= (process-with-repaired $rep-p1 $rep-p2 $rep-off $items $capacity $case-num)
   (build-final-result 
      (select-best-of-pool (Cons $rep-p1 (Cons $rep-p2 (Cons $rep-off Nil))) $items $capacity)
      $items
      $case-num))

;; Step 4: Final Metric Routing
(= (build-final-result $best-chrom $items $case-num)
   (print-metrics $case-num (calculate-weight $best-chrom $items) (calculate-value $best-chrom $items) $best-chrom))

;; Step 5: Structuring - Uses native write and nl (New Line) commands that PeTTa maps directly
(= (print-metrics $case-num $w $v $chrom)
   (progn
     (write "Case ") (write $case-num)
     (write " | Weight Used: ") (write $w)
     (write " | Total Value: ") (write $v)
     (write " | Best Chromosome: ") (write $chrom)
     (nl)))

;; ============================================================================
;; SEQUENTIAL DISPATCHER (Flush to Left Margin)
;; ============================================================================
!(evaluate-and-find-best (get-case 1) 0.05 1)
!(evaluate-and-find-best (get-case 2) 0.05 2)
!(evaluate-and-find-best (get-case 3) 0.05 3)
!(evaluate-and-find-best (get-case 4) 0.05 4)
!(evaluate-and-find-best (get-case 5) 0.05 5)
!(evaluate-and-find-best (get-case 6) 0.05 6)
!(evaluate-and-find-best (get-case 7) 0.05 7)
!(evaluate-and-find-best (get-case 8) 0.05 8)
!(evaluate-and-find-best (get-case 9) 0.05 9)
!(evaluate-and-find-best (get-case 10) 0.05 10)
!(evaluate-and-find-best (get-case 11) 0.05 11)
!(evaluate-and-find-best (get-case 12) 0.05 12)
!(evaluate-and-find-best (get-case 13) 0.05 13)
!(evaluate-and-find-best (get-case 14) 0.05 14)
!(evaluate-and-find-best (get-case 15) 0.05 15)
!(evaluate-and-find-best (get-case 16) 0.05 16)
!(evaluate-and-find-best (get-case 17) 0.05 17)
!(evaluate-and-find-best (get-case 18) 0.05 18)
