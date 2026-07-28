# MeTTa 0-1 Knapsack Genetic Algorithm

A pure, high-performance Genetic Algorithm (GA) implementation designed to solve the 0-1 Knapsack problem for dynamic, variable-length inputs. The core engine is tailored to be built, transpiled, and optimized natively via the **PeTTa** (MeTTa-to-Prolog) source-to-source transpilation framework.

## 🚀 Key Architectural Principles
- **100% Let-Free Functional Pipelines**: Completely optimized to avoid nested `let` assignment blocks across all operations, completely bypassing internal variable-binding limits and compiler locks inside the PeTTa transpiler engine.
- **Functional Argument Passing Pattern**: Performs algebraic mutation scaling, dynamic population initializations, and layout formatting by threading expressions directly into functional argument streams. This forces the compiler to produce flat, non-freezing Prolog clauses.
- **Pure Integer Accumulation**: Uses deterministic, tagless metric evaluations to separate weight boundaries from value metrics, avoiding structural tuple pattern-matching failures on the Prolog back-end.
- **Pseudo-Random LCG Optimization**: Implements an integer-driven Linear Congruential Generator (LCG) modulo calculation directly in MeTTa to ensure stochastic genetic diversity without cross-language dependencies.

## 📁 Core Framework Modules
- `main.metta` - The master orchestrator execution engine managing functional pipeline lifecycles.
- `cases.metta` - Contains the dynamic benchmark problem layout capacities and item profiles.
- `population.metta` - Handles non-freezing pseudo-random initial binary seed chromosome generations.
- `crossover.metta` - Implements a deterministic uniform crossover recombination mask operator.
- `mutation.metta` - Coordinates adaptive gene flips using calculated profit-to-weight efficiencies.
- `repair.metta` - Prunes over-capacity chromosomes down systematically via active bit clearing.
- `fitness.metta` - Evaluates strict item weight constraints and overall target value rewards.
- `selection.metta` - Conducts tournament bracket pairs reduction to isolate ultimate champions.
- `format_output.metta` - Pure, let-free structural output generator creating data grids natively.

## 🛠️ Execution & Native Formatting Pipeline
To evaluate your evolutionary genetic system and view your results natively without using any external Python scripts, run the code modules sequentially from the `PeTTa` subfolder:

```bash
# Navigate to your PeTTa engine directory
cd PeTTa

# Step 1: Run the main genetic algorithm pipeline to process your benchmark queries
sh run.sh ../main.metta

# Step 2: Run your native let-free formatter to output your structural results graph
sh run.sh ../format_output.metta
```

## 📊 Sample Structural Output Layout
When running the pure MeTTa formatting module, the PeTTa framework safely parses the structural arrays to print a native results data graph directly to your console window:

```text
METTA-KNAPSACK-EVOLUTIONARY-RESULTS
(Cons (Row (Case 1) (Weight 13) (Value 52) (Best-Chromosome (Cons 1 (Cons 0 (Cons 1 (Cons 0 (Cons 1 Nil)))))))
(Cons (Row (Case 2) (Weight 26) (Value 104) (Best-Chromosome (Cons 1 (Cons 0 (Cons 1 (Cons 0 (Cons 1 Nil)))))))
(Cons (Row (Case 3) (Weight 25) (Value 100) (Best-Chromosome (Cons 0 (Cons 1 (Cons 0 (Cons 1 (Cons 0 Nil)))))))
...
(Cons (Row (Case 20) (Weight 868) (Value 3298) (Best-Chromosome (Cons 1 (Cons 0 (Cons 1 (Cons 0 ... Nil)))))) Nil)))
```
