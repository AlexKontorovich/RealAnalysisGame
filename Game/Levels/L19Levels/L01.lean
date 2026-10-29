import Game.Levels.L18Lecture
import Game.Levels.L18PsetIntro

open Finset Function

World "Lecture19"
Level 1
Title "More Flexible Cauchy"
Introduction "
# Level 1: More Flexible Cauchy

In this level, we prove a stronger version of the Cauchy criterion that will be essential for understanding rearrangements of series.

## The Main Result

**Theorem** (`StrongCauchy_of_AbsSeriesConv`): If a series converges absolutely, then for any `ε > 0`, there exists `N` such that for *any* finite set `S : Finset ℕ` whose elements all exceed `N`, we have:

`∑ k ∈ S, |a k| < ε`

## Why This is Stronger

The usual Cauchy criterion only tells us that consecutive intervals `[n, m)` have small sum. This theorem says something much more powerful: *any* finite collection of sufficiently large-index terms has small sum, regardless of whether the indices are consecutive or scattered.

## The Key Insight

For absolutely convergent series, the tail becomes arbitrarily small. Any finite subset of the tail is contained in some interval, and by monotonicity of sums of nonnegative terms, the sum over the subset is bounded by the sum over the interval.

This flexibility is exactly what we need to handle rearrangements, where terms might appear in a completely different order.

## New Definition

**Definition** (`Finset.Nonempty`): A finite set `S` is *nonempty* if it has at least one element. Formally, `S.Nonempty` means `∃ x, x ∈ S`.

Since `S.Nonempty` is an existential statement, once you have `h : S.Nonempty` you can pull out an element with `choose x hx using h`. To split into the cases where `S` is or isn't empty, use `by_cases h : S.Nonempty`.

## New Theorems

- `sum_le_sum_of_nonneg`: If `S ⊆ T` and all values are nonnegative, then `∑ i ∈ S, f i ≤ ∑ i ∈ T, f i`
- `sum_le_mem_of_nonneg`: If `x ∈ S` and all values are nonnegative, then `f x ≤ ∑ i ∈ S, f i`
- `mem_Ico`: Characterizes membership in half-open intervals `[a, b)`

Your task: Prove the strong Cauchy property using these tools!
"

theorem sum_le_sum_of_nonneg {ι : Type*} {N : Type*} [AddCommMonoid N] [PartialOrder N]
  [IsOrderedAddMonoid N] {f : ι → N} {s t : Finset ι} (h : s ⊆ t) (hf : ∀ i ∈ t, 0 ≤ f i) :
  ∑ i ∈ s, f i ≤ ∑ i ∈ t, f i :=
  sum_le_sum_of_subset_of_nonneg h fun i a a_1 => hf i a

theorem sum_le_mem_of_nonneg {ι : Type*} {N : Type*} [AddCommMonoid N] [PartialOrder N]
  [IsOrderedAddMonoid N] {f : ι → N} {s : Finset ι} {i : ι} (hi : i ∈ s) (hf : ∀ i ∈ s, 0 ≤ f i) :
  f i ≤ ∑ j ∈ s, f j := by
have : ∑ j ∈ {i}, f j ≤ ∑ j ∈ s, f j := by
  apply sum_le_sum_of_nonneg
  intro j hj
  norm_num at hj
  rewrite [hj]
  apply hi
  apply hf
norm_num at this
apply this

/-- `(s : Finset X) := ∃ x, x ∈ s`

A finite set `s` is `Nonempty` if it has at least one element.
-/
DefinitionDoc Finset.Nonempty as "Finset.Nonempty"

NewDefinition Finset.Nonempty

/--
If `s ⊆ t`, and `0 ≤ f i`, for all `i ∈ t`, then `∑ i ∈ s, f i ≤ ∑ i ∈ t, f i`.
-/
TheoremDoc sum_le_sum_of_nonneg as "sum_le_sum_of_nonneg" in "∑aₙ"

/--
If `x ∈ s`, and `0 ≤ f i`, for all `i ∈ s`, then `f x ≤ ∑ i ∈ s, f i`.
-/
TheoremDoc sum_le_mem_of_nonneg as "sum_le_mem_of_nonneg" in "∑aₙ"

/--
For `a` and `b`, `x ∈ Ico a b ↔ a ≤ x ∧ x < b`.
-/
TheoremDoc Finset.mem_Ico as "mem_Ico" in "x∈U"


NewTheorem sum_le_sum_of_nonneg sum_le_mem_of_nonneg Finset.mem_Ico

/--
  If `Series a` converges absolutely, then for any `ε > 0`, there is an `N`, so that,
  for any finite set `S` whose elements are all at least `N`, `∑ k ∈ S, |a k| < ε`.
-/
TheoremDoc StrongCauchy_of_AbsSeriesConv as "StrongCauchy_of_AbsSeriesConv" in "∑aₙ"

Statement StrongCauchy_of_AbsSeriesConv
    {a : ℕ → ℝ} (ha : AbsSeriesConv a) {ε : ℝ} (hε : ε > 0) :
    ∃ N, ∀ (S : Finset ℕ), (∀ k ∈ S, k ≥ N) → ∑ k ∈ S, |a k| < ε := by
choose M hM using IsCauchy_of_SeqConv ha ε hε
use M
intro S hS
let sMax := 1 + ∑ k ∈ S, k
have sMaxIs : sMax = 1 + ∑ k ∈ S, k := by rfl
have kInS : ∀ k ∈ S, k < sMax := by
  intro n hn
  have f : id n ≤ ∑ k ∈ S, id k := by apply sum_le_mem_of_nonneg hn (by intro; bound)
  change n ≤ ∑ k ∈ S, k at f
  linarith [f, sMaxIs]
by_cases hSne : S.Nonempty
choose k0 hk0 using hSne
have hk0' : M ≤ k0 := by apply hS k0 hk0
have hk0'' : k0 ≤ sMax := by linarith [kInS k0 hk0]
have sMaxBnd : M ≤ sMax := by linarith [hk0', hk0'']
specialize hM M (by bound) sMax (by bound)
rewrite [show Series (fun n => |a n|) sMax - Series (fun n => |a n|) M =
  ∑ n ∈ Ico M sMax, (|a n|) by apply DiffOfSeries _ sMaxBnd] at hM
have f0 : 0 ≤ ∑ k ∈ S, |a k| := by apply sum_nonneg; intro n hn; bound
have hM0 : 0 ≤ ∑ k ∈ Ico M sMax, |a k| := by apply sum_nonneg; intro k hk; bound
rewrite [show |∑ k ∈ Ico M sMax, (|a k|)| = ∑ k ∈ Ico M sMax, |a k|  by apply abs_of_nonneg hM0] at hM
have Ssub : S ⊆ Ico M sMax := by
  intro k hk
  rewrite [mem_Ico]
  split_ands
  apply hS k hk
  linarith [kInS k hk]
have f2 : ∑ k ∈ S, |a k| ≤ ∑ k ∈ Ico M sMax, |a k| := by
  apply sum_le_sum_of_nonneg Ssub
  intro k hk
  bound
linarith [f2, hM]
norm_num at hSne
rewrite [hSne]
norm_num
apply hε


Conclusion "
# Congratulations!

You've just proven the **Strong Cauchy Property** for absolutely convergent series—a crucial stepping stone toward the Rearrangement Theorem!

## What We've Accomplished

This theorem shows that absolute convergence gives us tremendous flexibility in how we sum the terms. Not only do consecutive intervals have small sum (the usual Cauchy property), but *any* finite collection of sufficiently large-index terms has arbitrarily small sum.

This is much more flexible than the standard Cauchy criterion, which only considers intervals `[n, m)`. Here, we could pick scattered indices like `{100, 137, 1000000, 10^10}` and still guarantee the sum is small, as long as all indices exceed our threshold `N`.

## The Key Technique

The proof uses a clever bounding argument:
1. Every finite set has a maximum element, so we can find an interval containing it
2. The finite set is a subset of this interval
3. Since all terms are nonnegative (we're working with absolute values), monotonicity gives us the bound we need

## Why This Matters for Rearrangements

When we rearrange a series, terms appear in a completely different order. At some point in the rearranged series, we'll have covered all the early terms, but there will be scattered later terms we haven't seen yet.

The strong Cauchy property tells us that these scattered \"missing\" terms contribute negligibly to the sum, because they all have large indices. This is the key to showing that rearrangements don't change the sum!

## Looking Ahead

In the next level, we'll formalize what a rearrangement is and prove that rearrangements eventually \"catch up\" with the original ordering. Combined with this strong Cauchy property, we'll have all the tools needed to prove the magnificent Rearrangement Theorem.
"
