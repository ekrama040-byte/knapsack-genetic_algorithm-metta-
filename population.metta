;; ============================================================================
;; Generate one random gene
;; ============================================================================

(= (rand-bit)
   (superpose (0 1)))


;; ============================================================================
;; Generate chromosome from list
;; ============================================================================

(= (generate-chromosome ())
   ())


(= (generate-chromosome (cons $item $rest))
   (cons
      (rand-bit)
      (generate-chromosome $rest)))


!(generate-chromosome
   (
     (4 1)
     (7 7)
     (1 22)
     (3 23)
     (3 6)
   ))
!(generate-chromosome
   ((4 1)
    (7 7)
    (1 22)
    (3 23)
    (3 6)))