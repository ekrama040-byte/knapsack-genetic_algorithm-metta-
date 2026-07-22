;; ============================================================================
;; LIST UTILITIES
;; ============================================================================

;; First element
(= (list-car (cons $head $tail))
   $head)

;; Rest of list
(= (list-cdr (cons $head $tail))
   $tail)

;; nth element
(= (list-nth (cons $head $tail) 0)
   $head)

(= (list-nth (cons $head $tail) $idx)
   (list-nth $tail (- $idx 1)))

;; Length
(= (list-length ())
   0)

(= (list-length (cons $head $tail))
   (+ 1 (list-length $tail)))

;; Append
(= (list-append () $list)
   $list)

(= (list-append (cons $head $tail) $list)
   (cons $head
         (list-append $tail $list)))
!(list-length ())
!(list-length
   (cons 1
      (cons 2
         (cons 3 ()))))
!(list-car
   (cons 10
      (cons 20 ())))
!(list-nth
   (cons 5
      (cons 8
         (cons 12 ())))
   2)