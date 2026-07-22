(= (evaluate-population
      ()
      $items
      $capacity)

   ())


(= (evaluate-population
      (cons $x $rest)
      $items
      $capacity)

   (cons

      (cons
         $x
         (fitness
            $x
            $items
            $capacity))

      (evaluate-population
         $rest
         $items
         $capacity)))
