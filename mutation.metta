(= (flip-gene 0)
   1)

(= (flip-gene 1)
   0)

(= (keep-gene $gene)
   $gene)

(= (mutate-bit $gene $rand $rate)
   (if (< $rand $rate)
       (flip-gene $gene)
       (keep-gene $gene)))

(= (mutate-chromosome () () $rate)
   ())

(= (mutate-chromosome ($gene . $genes)
                      ($rand . $rands)
                      $rate)
   (cons
      (mutate-bit $gene $rand $rate)
      (mutate-chromosome $genes $rands $rate)))