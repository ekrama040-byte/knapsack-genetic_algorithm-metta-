;; ============================================================================
;; DYNAMIC WEIGHT ACCUMULATION (Pure Flat Integers)
;; ============================================================================
(= (calculate-weight Nil Nil) 0)

(= (calculate-weight (Cons 0 $genes) (Cons (Item $weight $value) $items))
   (calculate-weight $genes $items))

(= (calculate-weight (Cons 1 $genes) (Cons (Item $weight $value) $items))
   (+ $weight (calculate-weight $genes $items)))

;; ============================================================================
;; DYNAMIC VALUE ACCUMULATION (Pure Flat Integers)
;; ============================================================================
(= (calculate-value Nil Nil) 0)

(= (calculate-value (Cons 0 $genes) (Cons (Item $weight $value) $items))
   (calculate-value $genes $items))

(= (calculate-value (Cons 1 $genes) (Cons (Item $weight $value) $items))
   (+ $value (calculate-value $genes $items)))

;; ============================================================================
;; PUBLIC FITNESS FUNCTION ENGINE
;; ============================================================================
(= (fitness $chromosome $items $capacity)
   (if (> (calculate-weight $chromosome $items) $capacity)
       0 
       (calculate-value $chromosome $items)))
