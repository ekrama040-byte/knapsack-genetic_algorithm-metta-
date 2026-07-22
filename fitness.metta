;; ============================================================================
;; FITNESS EVALUATION
;; ============================================================================


;; Empty case

(= (calculate-total () ())
   (0 0))


;; Gene 0: skip item

(= (calculate-total
      (cons 0 $genes)
      (cons $item $items))

   (calculate-total
      $genes
      $items))


;; Gene 1: add item weight/value

(= (calculate-total
      (cons 1 $genes)
      (cons (cons $weight $value) $items))

   (add-total
      (calculate-total $genes $items)
      $weight
      $value))


;; Add values

(= (add-total
      (cons $old-weight $old-value)
      $weight
      $value)

   (cons
      (+ $old-weight $weight)
      (+ $old-value $value)))
    
;; ============================================================================
;; FITNESS FUNCTION
;; ============================================================================


;; Feasible solution
;; weight <= capacity
;; return value

(= (fitness
      $chromosome
      $items
      $capacity)

   (check-fitness
      (calculate-total
         $chromosome
         $items)
      $capacity))


;; Valid solution

(= (check-fitness
      (cons $weight $value)
      $capacity)

   (if
      (<= $weight $capacity)
      $value
      0))
!(calculate-total
   (1 0 1 1 0)
   ((4 1)
    (7 7)
    (1 22)
    (3 23)
    (3 6)))

!(fitness
   (1 0 1 1 0)
   ((4 1)
    (7 7)
    (1 22)
    (3 23)
    (3 6))
   20)
!(fitness
   (1 1 1 1 1)
   ((4 1)
    (7 7)
    (1 22)
    (3 23)
    (3 6))
   10)