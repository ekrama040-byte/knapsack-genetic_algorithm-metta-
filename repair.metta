;; ============================================================================
;; CLEAR FIRST SELECTED GENE
;; ============================================================================

;; Empty chromosome

(= (clear-first ())
   ())

;; First selected gene -> change 1 to 0 and stop

(= (clear-first
      (cons 1 $rest))

   (cons 0 $rest))

;; First gene already 0 -> keep it and continue

(= (clear-first
      (cons 0 $rest))

   (cons
      0
      (clear-first $rest)))
(= (repair-once
      $chromosome
      $capacity
      (cons $weight $value))

   (if
      (<= $weight $capacity)

      $chromosome

      (clear-first $chromosome)))
    
!(clear-first
   (1 1 1 1 1))
!(repair-once
   (1 1 1 1 1)
   10
   (18 59))
!(repair-once
   (0 1 1 1 1)
   10
   (14 58))