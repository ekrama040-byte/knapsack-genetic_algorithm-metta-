;; ============================================================================
;; COMPARISON & TOURNAMENT MECHANICS (Strict Cons/Nil Alignment)
;; ============================================================================

;; Pits two raw chromosomes against each other and extracts the superior configuration
(= (tournament $a $b $items $capacity)
   ;; FIXED: Completely removed let blocks to avoid any variable binding loops
   (if (> (fitness $a $items $capacity) (fitness $b $items $capacity)) 
       $a 
       $b))

;; Runs tournament bracket selection across structured chromosome pairs
(= (tournament-selection Nil $items $capacity) 
   Nil)

(= (tournament-selection (Cons $x Nil) $items $capacity) 
   (Cons $x Nil))

(= (tournament-selection (Cons $x (Cons $y $rest)) $items $capacity)
   (Cons (tournament $x $y $items $capacity)
         (tournament-selection $rest $items $capacity)))

;; ============================================================================
;; PUBLIC INTERFACE ENGINE (Iterative Pool Champion Selection)
;; ============================================================================

;; Master Entry Point: Requested explicitly by main.metta pipeline
(= (select-best-of-pool Nil $items $capacity) Nil)
(= (select-best-of-pool (Cons $chrom Nil) $items $capacity) $chrom)

;; FIXED: Inlined directly without let blocks to bypass the transpiler bug
(= (select-best-of-pool $pool $items $capacity)
   (select-best-of-pool (tournament-selection $pool $items $capacity) $items $capacity))
