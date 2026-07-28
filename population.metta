;; ============================================================================
;; POPULATION GENERATOR MODULE (Pure Deterministic Pseudo-Random LCG Layout)
;; ============================================================================

;; Base Case
(= (generate-stochastic-chromosome Nil $seed) Nil)

;; Recursive Step: Inlines the LCG seed calculation directly into the next function call argument
(= (generate-stochastic-chromosome (Cons $item $rest) $seed)
   (construct-pop-bit (% (+ (* 1103515245 $seed) 12345) 65536) $rest))

;; Helper: Eliminates the let block by accepting the computed next-seed directly as a parameter
(= (construct-pop-bit $next-seed $rest)
   (Cons (if (< (% $next-seed 100) 50) 1 0) (generate-stochastic-chromosome $rest $next-seed)))

;; ============================================================================
;; PUBLIC INTERFACE FUNCTIONS
;; ============================================================================
(= (get-parent-one $items-list) (generate-stochastic-chromosome $items-list 12345))
(= (get-parent-two $items-list) (generate-stochastic-chromosome $items-list 67890))
