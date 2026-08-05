;; Linear Congruential Generator for non-backtracking random numbers
(= (next-seed $seed)
   (% (+ (* $seed 1103515245) 12345) 2147483648))

!(random-float  &rng 1 2)

;; Turns the high seed value into a clean 0 or 1 gene
(= (seed-to-gene $seed)
   (% $seed 2))

;; Generates a single chromosome deterministically without path splitting
(= (generate-chromosome Nil $seed) 
   (Cons-Result Nil $seed))

(= (generate-chromosome (Cons $x $xs) $seed)
   (build-chromosome-step (seed-to-gene $seed) (generate-chromosome $xs (next-seed $seed))))

(= (build-chromosome-step $gene (Cons-Result $rest-chrom $final-seed))
   (Cons-Result (Cons $gene $rest-chrom) $final-seed))

;; Generates the full population array cleanly
(= (generate-population $items 0 $seed) Nil)
(= (generate-population $items $size $seed)
   (build-population-step (generate-chromosome $items $seed) $items $size))

(= (build-population-step (Cons-Result $chrom $next-seed) $items $size)
   (Cons $chrom (generate-population $items (- $size 1) (next-seed $next-seed))))
