;; Base cases: If empty or 1 left, return what remains
(= (select-winners-pool Nil $items) Nil)
(= (select-winners-pool (Cons $c Nil) $items) (Cons $c Nil))

;; Processes pairs independently, keeping BOTH winners in a list
(= (select-winners-pool (Cons $c1 (Cons $c2 $rest)) $items)
   (build-winners-list (if (> (calculate-value $c1 $items) (calculate-value $c2 $items)) $c1 $c2)
                       (select-winners-pool $rest $items)))

;; Helper to prepend the winner to the rest of the winning pool
(= (build-winners-list $winner $rest-winners)
   (Cons $winner $rest-winners))


