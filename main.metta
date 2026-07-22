; ============================================================================
; MAIN ENTRY POINT FOR THE KNAPSACK GENETIC ALGORITHM
; ============================================================================

; 1. Import Utility and Core Helper Functions
!(import! &self "utils.metta")

; 2. Import Problem-Specific Logic (Knapsack Constraints and Evaluations)
!(import! &self "fitness.metta")
!(import! &self "repair.metta")

; 3. Import Genetic Operators and Population Control
!(import! &self "population.metta")
!(import! &self "selection.metta")
!(import! &self "crossover.metta")
!(import! &self "mutation.metta")
!(import! &self "evaluation_population.metta")

; Knapsack entry point

(define (knapsack items capacity)
   (ga-run items capacity))


; Read input and run

(define (main)
   (let* ((items (read-input "input.txt"))
          (capacity (get-capacity items))
          (solution (knapsack items capacity)))
       (print solution)
   )
)

(main)
