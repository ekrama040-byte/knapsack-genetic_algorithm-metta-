;; ============================================================================
;; REPAIR MODULE FOR PeTTa
;; Keeps high-value, low-weight items by dropping the heaviest active item
;; ============================================================================

;; Primary repair loop: triggers if total weight exceeds capacity
(= (repair $chrom $items $capacity)
   (if (> (calculate-weight $chrom $items) $capacity)
       (repair (drop-heaviest-active-item $chrom $items) $items $capacity)
       $chrom))

;; Finds the highest weight among active genes (gene == 1)
;; Signature: (find-max-weight chromosome items current-max-weight)
(= (find-max-weight Nil Nil $max) $max)
(= (find-max-weight (Cons $g $g-rest) (Cons (Item $w $v) $i-rest) $max)
   (if (== $g 1)
       (if (> $w $max)
           (find-max-weight $g-rest $i-rest $w)
           (find-max-weight $g-rest $i-rest $max))
       (find-max-weight $g-rest $i-rest $max)))

;; Flips the first active gene that matches the targeted heaviest weight to 0
;; Signature: (flip-target-gene chromosome items target-weight)
(= (flip-target-gene Nil Nil $target) Nil)
(= (flip-target-gene (Cons $g $g-rest) (Cons (Item $w $v) $i-rest) $target)
   (if (and (== $g 1) (== $w $target))
       (Cons 0 $g-rest) ;; Target found: flip to 0 and terminate search
       (build-repair-step $g (flip-target-gene $g-rest $i-rest $target))))

;; Pure structural helper to avoid let-binding crashes in PeTTa
(= (build-repair-step $gene $rest-chrom)
   (Cons $gene $rest-chrom))

;; Main orchestration function to drop the heaviest active item
(= (drop-heaviest-active-item $chrom $items)
   (execute-drop $chrom $items (find-max-weight $chrom $items -1)))

;; Dispatches the target weight value to the flipping mechanism
(= (execute-drop $chrom $items $target-weight)
   (if (== $target-weight -1)
       $chrom ;; Safety fallback: no active genes found
       (flip-target-gene $chrom $items $target-weight)))
