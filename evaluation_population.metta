;; ============================================================================
;; POPULATION EVALUATION CORE (NATIVE PeTTa LIST SYNTAX)
;; ============================================================================

;; Base case: An empty population returns Nil
(= (evaluate-population Nil $items $capacity)
   Nil)

;; Recursive case: Evaluates each chromosome string using structural uppercase Cons
(= (evaluate-population (Cons $x $rest) $items $capacity)
   (Cons (Cons $x (fitness $x $items $capacity))
         (evaluate-population $rest $items $capacity)))
