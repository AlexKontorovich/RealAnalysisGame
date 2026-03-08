import Game.Levels.L9Levels.L04_FiniteSums

open Finset

World "Lecture9"
Level 2
Title "Bounded"

Introduction "
# Level 2: Bounded

Welcome to one of the most fundamental results in real analysis: **convergent sequences are bounded**! This theorem tells us that if a sequence converges to a limit, it can't wander off to infinity—it must stay within some finite region.

## The Goal

Prove that if `a : ℕ → ℝ` converges to a nonzero limit `L`, then `a` is bounded (i.e., there exists some `M > 0` such that `|a n| ≤ M` for all `n`).

**Note:** The case `L = 0` will be handled in the exercises. For now, we focus on nonzero limits.

## The Big Idea

Think about what convergence means: eventually, all terms get close to `L`. So for large `n`, we have `|a n| ≤ 2|L|` (approximately).

But what about the **finitely many terms before** the sequence gets close to `L`? That's where your `TermLeSum` theorem from Level 1 comes in! You can bound those initial terms by their finite sum.

### The Strategy:

1. **Eventually bounded:** Use `EventuallyBdd_of_SeqConv` to find an `N` such that `|a n| ≤ 2|L|` for all `n ≥ N`

2. **Initially bounded:** For `n < N`, use `TermLeSum` to show `|a n| ≤ ∑ k ∈ range N, |a k|`

3. **Global bound:** Combine both parts with:
   ```
   M = 2 * |L| + ∑ k ∈ range N, |a k|
   ```

   This works because:
   - For `n ≥ N`: the term `|a n|` is covered by `2|L|`
   - For `n < N`: the term `|a n|` is covered by the sum

4. **Prove `M > 0`:** Show that your bound is positive (needed for the definition of `SeqBdd`)

5. **Prove `∀ n, |a n| ≤ M`:** Split into cases based on whether `n ≥ N` or `n < N`

## New Tools You'll Need

### `SeqBdd`
Definition: A sequence `a : ℕ → ℝ` is **bounded** if `∃ M > 0, ∀ n, |a n| ≤ M`

## Your Mission

Construct the bound `M`, prove it's positive, then verify it works for all terms by splitting into the two cases. Let your `TermLeSum` theorem shine!

Good luck! 🚀
"

/-- `(a : ℕ → X) := ∃ M > 0, ∀ n, |a n| ≤ M`

  A sequence `a : N → X` (where `X` could be `ℚ` or `ℝ`) is bounded (`SeqBdd` holds) if there exists some positive
`M : X` so that `|a n| ≤ M`, for all `n`. -/
DefinitionDoc SeqBdd as "SeqBdd"

NewDefinition SeqBdd

def SeqBdd {X : Type*} [NormedField X] [LinearOrder X] [IsStrictOrderedRing X] (a : ℕ → X) : Prop :=
  ∃ M > 0, ∀ n, |a n| ≤ M

/-- If `a : ℕ → ℝ` is a sequence which converges to a non-zero limit, then it is bounded.
See also `Bdd_of_Conv` which assumes nothing about the limit. -/
TheoremDoc Bdd_of_ConvNonzero as "Bdd_of_ConvNonzero" in "aₙ"

/-- Prove this
-/
Statement Bdd_of_ConvNonzero (a : ℕ → ℝ) (L : ℝ) (ha : SeqLim a L) (hL : L ≠ 0) :
    SeqBdd a := by
choose N hN using EventuallyBdd_of_SeqConv a L ha hL
use 2 * |L| + ∑ k ∈ range N, |a k|
have absL : 0 < |L| := by apply abs_pos_of_nonzero hL
have f1 : ∀ k ∈ range N, 0 ≤ |a k| := by bound
have f2 : 0 ≤ ∑ k ∈ range N, |a k| := by apply sum_nonneg f1
split_ands
linarith [f2, absL]
intro n
by_cases hn : N ≤ n
specialize hN n hn
linarith [hN, f2]
have hn' : n < N := by bound
have f3 : |a n| ≤ ∑ k ∈ range N, |a k| := by apply TermLeSum a N n hn'
linarith [f3, absL]

Conclusion "
# 🎉 Outstanding Achievement!

You've just proven one of the **cornerstone theorems of real analysis**: convergent sequences with nonzero limits are bounded! This is a result you'll use again and again throughout your journey in analysis.

## What You Accomplished

You proved that convergence implies boundedness:
```
SeqLim a L → L ≠ 0 → SeqBdd a
```

This tells us something profound: **convergent sequences can't escape to infinity**. They must remain trapped in a finite region of the real line.

### Key Techniques You Mastered:

1. **Two-region strategy** - You split the natural numbers into two parts:
   - Eventually (n ≥ N): where convergence gives you control
   - Initially (n < N): where you used your TermLeSum theorem

2. **Constructing clever bounds** - You built `M = 2*|L| + ∑ k ∈ range N, |a k|`, which elegantly captures both regions in a single expression

3. **Case analysis** - You used `by_cases` to handle the two regions separately, applying the appropriate bound for each

4. **Connecting theorems** - You saw how `TermLeSum` from Level 1 became an essential tool for handling finitely many terms

## Why This Matters

The boundedness of convergent sequences is fundamental throughout mathematics:

- **Bolzano-Weierstrass Theorem**: Every bounded sequence has a convergent subsequence (you've proven half of this!)
- **Uniform Convergence**: Bounded sequences are essential for proving uniform convergence results
- **Compactness**: This result is key to understanding compactness in metric spaces
- **Practical Analysis**: Knowing a sequence stays bounded helps with error analysis and numerical computations

## The Missing Piece: L = 0

Notice we assumed `L ≠ 0` in this proof. The case where `L = 0` is left as an exercise, but the idea is similar:
- Use convergence with `ε = 1` to bound terms eventually by `1`
- Handle the finitely many initial terms with TermLeSum
- The bound becomes `M = 1 + ∑ k ∈ range N, |a k|`

## Looking Ahead

You now understand that convergent sequences live in a bounded world. This prepares you for deeper results:
- Sequences that are bounded but don't converge (like `(-1)^n`)
- The relationship between boundedness, monotonicity, and convergence
- Cauchy sequences and completeness of the reals

Congratulations on mastering this essential theorem! You're building the foundation for advanced analysis. Keep going! 🚀
"

-- case `L = 0` in exercises
