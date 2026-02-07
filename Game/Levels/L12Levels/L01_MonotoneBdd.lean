import Game.Levels.L12Levels.L01_Choose

World "Lecture12"
Level 3
Title "Monotone and Bounded Implies Cauchy"

Introduction "
# Level 3: Monotone and Bounded Implies Cauchy

Now we tackle one of the fundamental theorems of real analysis: every bounded monotone sequence is Cauchy. This result provides a powerful convergence criterion that doesn't require knowing the limit beforehand.

## The Intuitive Picture

Why should this be true? If a sequence is monotone (that is, non-decreasing) and bounded above, then it can't \"escape to infinity\" - there's a ceiling it can't break through. But it also can't have persistent gaps, because each gap would push it a bit higher, and eventually these accumulated jumps would break through the ceiling. So the sequence must \"settle down\" and become Cauchy.

Making this intuition rigorous requires the orbit technique you just mastered.

## A Question of Generality

Before diving in, let's address an important design choice. What type should our sequence have? We could work with `a : ℕ → ℝ` (real sequences), but we're building up to constructing the real numbers, so we shouldn't presuppose their existence. We could use `a : ℕ → ℚ` (rational sequences), but then we'd need to reprove everything for real sequences later.

The elegant solution: work with an abstract type `X` that has just the properties we need. We'll assume `X` has:
- A linear order (so we can say `x ≤ y`)
- A norm (so we can say `|x|`)
- Field operations (so we can add, subtract, multiply, divide)
- A few other technical properties for the proof to work

Then this theorem automatically applies to both rational and real sequences - Lean will verify that ℚ and ℝ satisfy all our assumptions about `X`.

## Strategic Overview

The proof uses contradiction. We'll assume a bounded monotone sequence is not Cauchy, which means there are persistent gaps of size `ε`. Using the `choose` tactic (as in the previous level), we'll extract subsequences that witness these gaps. Then we'll apply your orbit result to show these gaps accumulate without bound, contradicting the boundedness.

**Your goal:** Prove that if `a : ℕ → X` is monotone and bounded above by `M`, then `a` is Cauchy.

Note: This level uses a \"black box\" helper lemma `IterateGap` that we'll prove in the next level. For now, trust that it captures how gaps accumulate under iteration.

## New Tools

### Definition: `Monotone`
A sequence `a : ℕ → X` is monotone if `a n ≤ a m` whenever `n ≤ m`.

### Theorem: `Monotone_of_succ`
To prove monotonicity, it's enough to check consecutive terms: if `a m ≤ a (m+1)` for all `m`, then `a` is `Monotone`.

### Tactic: `push_neg`
Pushes negations through quantifiers: `¬∀` becomes `∃¬`, `¬∃` becomes `∀¬`, etc. Essential for proof by contradiction with complex statements.

### The Helper Lemma: `IterateGap`
Given a monotone sequence with persistent gaps of size `ε` between subsequences `τ` and `σ`, the orbit `σ^[k] 0` accumulates at least `k * ε` growth from the starting point. This will be proven in Level 4.

`theorem IterateGap (a : ℕ → X) (ha : Monotone a) (ε : X)
  (εpos : ε > 0)
  (τ : ℕ → ℕ) (hτ : ∀ n, τ n ≥ n)
  (σ : ℕ → ℕ) (hσ : ∀ n, σ n ≥ τ n)
  (hgap : ∀ n, ε ≤ |a (σ n) - a (τ n)|)
  : ∀ (k : ℕ), k * ε ≤ a (σ^[k] 0) - a 0
`
"

/-- `(a : X → Y) {i j} (hij : i ≤ j) : a i ≤ a j`

A sequence `a : X → Y` is said to be `Monotone` if `a n ≤ a m` whenever `n ≤ m`. -/
DefinitionDoc Monotone as "Monotone"

NewDefinition Monotone

theorem Monotone_of_succ {X : Type*} [Preorder X] (a : ℕ → X) (ha : ∀ n, a n ≤ a (n + 1)) : Monotone a := by
exact monotone_nat_of_le_succ ha

/-- If `a n ≤ a (n+1)` holds for all `n`, then `a` is `Monotone`. -/
TheoremDoc Monotone_of_succ as "Monotone_of_succ" in "aₙ"

theorem IterateGap {X : Type*} [NormedField X] [LinearOrder X] [IsStrictOrderedRing X] (a : ℕ → X) (ha : Monotone a) (ε : X)
  (εpos : ε > 0)
  (τ : ℕ → ℕ) (hτ : ∀ n, τ n ≥ n)
  (σ : ℕ → ℕ) (hσ : ∀ n, σ n ≥ τ n)
  (hgap : ∀ n, ε ≤ |a (σ n) - a (τ n)|)
  : ∀ (k : ℕ), k * ε ≤ a (σ^[k] 0) - a 0
  := by
intro k
induction' k with k hk
norm_num
specialize hgap (σ^[k] 0)
rewrite [(show |a (σ (σ^[k] 0)) - a (τ (σ^[k] 0))| = a (σ (σ^[k] 0)) - a (τ (σ^[k] 0)) by apply abs_of_nonneg (by bound))] at hgap
rewrite [show σ (σ^[k] 0) = σ^[k + 1] 0 by apply succ_iterate] at hgap
have f1 : 0 ≤ a (τ (σ^[k] 0)) - a (σ^[k] 0) := by bound
push_cast
linarith [f1, hk, hgap]


/--
If a sequence `a : ℕ → X` (where `X` could be `ℚ` or `ℝ`) is `Monotone` and grows along some subsequences by `ε`, then it eventually grows by `k * ε` for any `k`.
-/
TheoremDoc IterateGap as "IterateGap" in "aₙ"

NewTheorem Monotone_of_succ IterateGap

/-- The `push_neg` tactic pushes negations through universal and existential quantifiers, inequalities, etc. -/
TacticDoc push_neg

NewTactic push_neg

/--
If a sequence `a : ℕ → X` (where `X` can be `ℚ` or `ℝ`) is monotone and bounded, then it is Cauchy.
-/
TheoremDoc IsCauchy_of_MonotoneBdd as "IsCauchy_of_MonotoneBdd" in "aₙ"

/-- Prove this
-/
Statement IsCauchy_of_MonotoneBdd {X : Type*} [NormedField X] [LinearOrder X] [IsStrictOrderedRing X]
  [FloorSemiring X] {a : ℕ → X} {M : X} (ha : Monotone a) (hM : ∀ n, a n ≤ M)
  : IsCauchy a := by
intro ε hε
by_contra h
push_neg at h
choose τ hτ σ hσ hgap using h
have f1 : ∀ k, k * ε ≤ a (σ^[k] 0) - a 0 := by apply IterateGap a ha ε hε τ hτ σ hσ hgap
let k : ℕ := ⌈(M - a 0) / ε⌉₊ + 1
have hk' : (M - a 0) / ε ≤  ⌈(M - a 0) / ε⌉₊ := by bound
have hk : (M - a 0) / ε < k := by change (M - a 0) / ε < (⌈(M - a 0) / ε⌉₊ + 1 : ℕ); push_cast; linarith [hk']
specialize f1 k
specialize hM (σ^[k] 0)
have f2 : (M - a 0) < k * ε := by field_simp at hk; rewrite [show k * ε = ε * k by ring_nf]; apply hk
linarith [f1, f2, hM]

Conclusion "
## What You've Accomplished

You've just proven one of the cornerstone theorems of real analysis. By showing that every bounded monotone sequence is Cauchy, you've established a fundamental bridge between order properties (monotonicity and boundedness) and topological properties (convergence).

## The Power of Contradiction

This proof demonstrates the elegance of contradiction in analysis. By assuming the sequence wasn't Cauchy, you were able to extract concrete subsequences that witness persistent gaps. The beauty lies in how these gaps, when iterated, necessarily violate the boundedness assumption - making the contradiction inevitable rather than accidental.

## Why This Theorem Matters

This result is foundational because:
- It provides a practical convergence test that doesn't require knowing the limit
- It underlies the Monotone Convergence Theorem in measure theory
- It establishes that \"order + bounds = convergence\" - a principle that appears throughout analysis

## The Role of Abstraction

By proving this for an abstract type `X` rather than specific number systems, you've seen how mathematical abstraction pays dividends. This single proof now covers both rational and real sequences, and will work for any mathematical structure with the right properties.

## Looking Ahead

In the next level, you'll prove the technical helper lemma `IterateGap` that made this proof possible. You'll see exactly how the orbit construction from Level 1 combines with monotonicity to create the linear accumulation of gaps that drives the contradiction.

The technique you've mastered - using `choose` to extract witnesses, then applying iteration to scale up local properties - is a powerful pattern that appears throughout advanced analysis.
"
