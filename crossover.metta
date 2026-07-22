;; ==========================================
;; CROSSOVER
;; RETURNS TWO CHILDREN
;; ==========================================

(= (crossover
      $p1
      $p2)

   (cons
      (uniform-child
         $p1
         $p2
         1)

      (cons
         (uniform-child
            $p2
            $p1
            1)

         ())))


;; ==========================================
;; END OF CHROMOSOME
;; ==========================================

(= (uniform-child
      ()
      ()
      $flag)

   ())


;; ==========================================
;; TAKE GENE FROM FIRST PARENT
;; ==========================================

(= (uniform-child
      (cons $a $r1)
      (cons $b $r2)
      1)

   (cons
      $a

      (uniform-child
         $r1
         $r2
         0)))


;; ==========================================
;; TAKE GENE FROM SECOND PARENT
;; ==========================================

(= (uniform-child
      (cons $a $r1)
      (cons $b $r2)
      0)

   (cons
      $b

      (uniform-child
         $r1
         $r2
         1)))

!(crossover

(1 0 1 1 0)

(0 1 0 0 1))