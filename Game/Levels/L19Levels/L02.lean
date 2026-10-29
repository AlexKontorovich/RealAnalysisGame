import Game.Levels.L19Levels.L01

open Finset Function

World "Lecture19"
Level 2
Title "Rearrangements"
Introduction "
# Level 2: Rearrangements

In this level, we introduce the formal concept of a rearrangement and prove a crucial technical lemma about how rearrangements behave.

## New Definitions

**Definition** (`Injective`): A function `f : X → Y` is *injective* (one-to-one) if whenever `f i = f j`, we have `i = j`. In other words, different inputs give different outputs.

**Definition** (`Surjective`): A function `f : X → Y` is *surjective* (onto) if for every `y : Y`, there exists some `x : X` with `f x = y`. In other words, every output is achieved by some input.

**Definition** (`Rearrangement`): A function `σ : ℕ → ℕ` is a *rearrangement* if it is both injective and surjective—that is, a bijection of the natural numbers.

A rearrangement `σ` gives us a new ordering of ℕ. For a sequence `a`, the rearranged sequence `a ∘ σ` is defined by `(a ∘ σ) n = a (σ n)`.

## New Theorems

**Theorem** (`mem_image`): For a function `f : X → Y` and a finite set `s`, `y ∈ image f s ↔ ∃ x ∈ s, f x = y`. In other words, `y` is in the image of `s` exactly when some element of `s` maps to `y`.

So `rewrite [mem_image]` turns a goal like `m ∈ image σ (range n)` into `∃ a ∈ range n, σ a = m`, which you can then prove by finding a suitable `a` with `use`.

**Theorem** (`mem_range`): For natural numbers `m` and `n`, `m ∈ range n ↔ m < n`. Recall that `range n` is the finite set `{0, 1, ..., n-1}`.

So `rewrite [mem_range]` turns a membership goal like `a ∈ range n` into the inequality `a < n`, which tools like `linarith` can handle.

## The Main Result

**Theorem** (`EventuallyCovers_of_Rearrangement`): If `σ` is a rearrangement, then for any `M : ℕ`, there exists `N` such that for all `n ≥ N`, we have:

`range M ⊆ image σ (range n)`

In other words: the image of `σ` on `{0, 1, ..., n-1}` contains `{0, 1, ..., M-1}`.

## What This Means

Even though a rearrangement `σ` might scramble the order of natural numbers dramatically, it must \"eventually catch up\" with the original ordering. By the time we reach index `N`, we're guaranteed to have seen all of the first `M` elements as outputs of `σ`.

For example, if `σ` sends `0 → 1000000`, we might have to wait a while, but eventually (before reaching some `N`), all of `{0, 1, ..., M}` will have appeared as values `σ(k)` for `k < N`.

## Why This Matters

This theorem is essential for proving that rearranged series converge to the same limit. We'll need to know that when we've computed enough terms of the rearranged series, we've included all the important early terms from the original series.

Your task: Prove that every rearrangement eventually covers any initial segment!
"

def Rearrangement (σ : ℕ → ℕ) : Prop := Injective σ ∧ Surjective σ

/-- `(f : X → Y) := ∀ ⦃i j⦄, f i = f j → i = j`

A function `f : X → Y` is called `Injective` if: for all `i, j`, `f i = f j → i = j`.
-/
DefinitionDoc Injective as "Injective"


/-- `(f : X → Y) := ∀ y, ∃ x, f x = y`

A function `f : X → Y` is called `Surjective` if: for all `y : Y`, `∃ x : X` so that `f x = y`.
-/
DefinitionDoc Surjective as "Surjective"


/-- `(σ : ℕ → ℕ) := Injective σ ∧ Surjective σ`

A `Rearrangement` `σ : ℕ → ℕ` is a function that is `Injective` and `Surjective`.
-/
DefinitionDoc Rearrangement as "Rearrangement"

NewDefinition Rearrangement Surjective Injective

/--
For `f : X → Y` and a finite set `s`, `y ∈ image f s ↔ ∃ x ∈ s, f x = y`.
-/
TheoremDoc Finset.mem_image as "mem_image" in "x∈U"

/--
For natural numbers `m` and `n`, `m ∈ range n ↔ m < n`.
-/
TheoremDoc Finset.mem_range as "mem_range" in "x∈U"

NewTheorem Finset.mem_image Finset.mem_range

/--
  If `σ` is a `Rearrangement`, then for any `M`, there is an `N`, so that,
  for all `n ≥ N`, the `range M` is contained in `image σ (range n)`.
-/
TheoremDoc EventuallyCovers_of_Rearrangement as "EventuallyCovers_of_Rearrangement" in "∑aₙ"

Statement EventuallyCovers_of_Rearrangement
    {σ : ℕ → ℕ} (hσ : Rearrangement σ) (M : ℕ) :
    ∃ N, ∀ n ≥ N, (range M) ⊆ image σ (range n) := by
have surj : ∀ j, ∃ n, σ n = j := hσ.2
choose τ hτ using surj
let N := 1 + ∑ k ∈ range M, τ k
have hN : N = 1 + ∑ k ∈ range M, τ k := by rfl
use N
intro n hn m hm
rewrite [mem_image]
use τ m
split_ands
rewrite [mem_range]
have hτ' : ∀ k ∈ range M, 0 ≤ τ k := by intro k hk; bound
have f : τ m ≤ ∑ k ∈ range M, τ k := by apply sum_le_mem_of_nonneg hm hτ'
linarith [f, hN, hn]
apply hτ m



Conclusion "
# Congratulations!

You've just proven the **Eventually Covers Property** for rearrangements—a beautiful result about bijections of the natural numbers!

## What We've Accomplished

This theorem tells us that no matter how wildly a rearrangement `σ` scrambles the natural numbers, it can't \"hide\" any element forever. Given any target set `{0, 1, ..., M-1}`, there's a point `N` beyond which we're guaranteed to have seen all of these elements as outputs.

## The Proof Technique

The proof uses a clever construction:
1. Since `σ` is surjective, each element `j < M` appears as `σ(k_j)` for some `k_j`
2. We use the axiom of choice (via `choose`) to select all these preimages simultaneously
3. We set `N` larger than all the `k_j` values
4. Then for any `n ≥ N`, all the required preimages are in `range n`, so all their images are covered

The key insight is that finite sets have maximum elements, so we can always find a threshold that works.

## A Concrete Example

Consider the rearrangement that sends:
- `0 → 1, 1 → 2, 2 → 3, ...` (shift everything right)
- except `1000000 → 0` (one element goes way back)

To cover `range 1` (just `{0}`), we need `N ≥ 1000001`, because `0` doesn't appear as `σ(k)` until `k = 1000000`.

But the theorem guarantees such an `N` exists! No matter how we rearrange, we eventually catch everything.

## Why This Matters for Series

When we rearrange a series `∑ a_n` to get `∑ a_(σ(n))`, the partial sums are:
- Original: `a_0 + a_1 + ... + a_(n-1)`
- Rearranged: `a_(σ(0)) + a_(σ(1)) + ... + a_(σ(n-1))`

This theorem tells us that for large enough `n`, the rearranged partial sum includes all the terms `a_0, a_1, ..., a_M` from the original series. Combined with the strong Cauchy property from Level 1, this will let us prove that the rearranged series converges to the same limit!

## Next Steps

In Level 3, we'll combine this result with the strong Cauchy property to prove the magnificent **Rearrangement Theorem**: absolutely convergent series can be rearranged without changing their sum!
"
