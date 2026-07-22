;; ==========================================
;; REMOVE ELEMENT
;; ==========================================


(= (remove-chromosome
      $x
      ())

   ())


(= (remove-chromosome
      $x
      (cons $x $rest))

   $rest)


(= (remove-chromosome
      $x
      (cons $y $rest))

   (cons
      $y
      (remove-chromosome
         $x
         $rest)))



;; ==========================================
;; COMPARE TWO CHROMOSOMES
;; ==========================================


(= (better
      $a
      $b
      $items
      $capacity)

   (compare
      $a
      $b
      (fitness $a $items $capacity)
      (fitness $b $items $capacity)))


(= (compare
      $a
      $b
      $fa
      $fb)

   (if
      (> $fa $fb)
      $a
      $b))



;; ==========================================
;; TOURNAMENT
;; ==========================================


(= (tournament
      $a
      $b
      $items
      $capacity)

   (better
      $a
      $b
      $items
      $capacity))



;; ==========================================
;; APPLY TO POPULATION PAIRS
;; ==========================================


(= (tournament-selection
      ()
      $items
      $capacity)

   ())


(= (tournament-selection
      (cons $x ())
      $items
      $capacity)

   (cons
      $x
      ()))


(= (tournament-selection
      (cons $x
            (cons $y $rest))
      $items
      $capacity)

   (cons

      (tournament
         $x
         $y
         $items
         $capacity)

      (tournament-selection
         $rest
         $items
         $capacity)))



;; ==========================================
;; SELECT PARENTS
;; ==========================================


(= (select-parents
      $population
      $items
      $capacity)

   (take-two
      (tournament-selection
         $population
         $items
         $capacity)))



;; ==========================================
;; TAKE TWO WINNERS
;; ==========================================


(= (take-two
      (cons $x
            (cons $y $rest)))

   (cons
      $x
      (cons
         $y
         ())))