import Game.Levels.L2NewtonsCalculationOfPi

open Nat

World "Lecture3"
Level 1
Title "Archimedean Property"

Introduction "
# Level 1: The Archimedean Property

The so-called Archimedean Property (which I think is originally due to Eudoxus, and appears already in Euclid's Elements Book V) is a fundamental property of the real numbers that captures the intuitive notion that there are no \"infinitely large\" or \"infinitesimally small\" positive real numbers.

More precisely, it states that no matter how small `ε > 0` is, there is always a natural number `N` so that `1 / N` is even smaller than `ε` (and of course positive). Equivalently, we can state it as: for any positive real number `ε`, there exists a natural number `N` such that `1 / ε < N`.

*Why does this matter?* The Archimedean Property is one of the most fundamental properties distinguishing the real numbers from other number systems. Without it, we could have \"infinitely large\" or \"infinitesimally small\" positive numbers, which would break most of calculus and analysis.

Our goal will be to prove the following:

**Theorem (ArchProp)**: For any `ε : ℝ` with `0 < ε`, there exists `N : ℕ` such that `1 / ε < N`.

This is mathematically \"obvious\" to most people—if you have a positive number ε, no matter how small, you can always find a natural number large enough that 1 / ε is smaller than it. (At least it seems obvious, and perhaps becomes less so once you remember that we don't yet know what the real numbers actually *are*... We'll continue postponing the construction for some time.) But how do you actually formalize this in Lean?

## The Natural Language Proof Strategy

First, let's think about this in natural language. The key insight is that we need to provide a specific natural number `N` that works.

A natural choice would be to use something related to the ceiling function. The ceiling function `x ↦ ⌈x⌉` rounds any real number up to the nearest integer. However, there's a subtle issue here: the standard ceiling function takes values in integers `ℤ`, but we need values in `ℕ` (the natural numbers). These are *not* the same thing!!

Fortunately, Lean provides the \"natural number ceiling function\" written `x ↦ ⌈x⌉₊`, which takes any real number and returns a natural number.
(You can write these symbols using `\\lceil`, `\\rceil`, and `\\_+`. Or if you're lazy like me, just copy and paste them from elsewhere.)
 For negative inputs, this function returns `0`. For example, `⌈-3.14⌉₊ = 0` and `⌈3.14⌉₊ = 4`.

Now our strategy becomes clear:
- **Choice of N**: Use `N = ⌈1 / ε⌉₊ + 1`
- **Why this works**: We have the \"key inequality\": `1 / ε ≤ ⌈1 / ε⌉₊`, which holds by the definition of the ceiling function
- **Getting strict inequality**: Adding 1 gives us `1 / ε < ⌈1 / ε⌉₊ + 1`

## The Lean Implementation Challenges

In Lean, the first two steps of our natural language proof work fine, but then we encounter the issue of **type coercion** (\"casting\" between different number types). We'll discuss this in more detail later, but again it has to do with the fact that `ℕ`, `ℤ`, `ℚ`, and `ℝ` are all different kinds of things, and we need to be able to move numbers up the \"sophistication\" hierarchy, with natural numbers being the simplest objects and the reals being the most complicated (so much so that we keep postponing their construction).

For example, notice that when we'll write our `have` statement to establish the key inequality:

`have fact : 1 / ε ≤ ⌈1 / ε⌉₊ := by WhateverTheProofIs`

Lean will record it as:

`fact : 1 / ε ≤ ↑⌈1 / ε⌉₊`

Notice the mysterious up arrow `↑`. This represents a coercion function from natural numbers to real numbers:

↑ : ℕ → ℝ

This is because `ℕ`, `ℤ`, `ℚ`, and `ℝ` are all **different** types in Lean's type system (and really, in mathematics, as we'll see when we construct the real numbers)! Even though we think of natural numbers as being \"contained\" in the real numbers, formally they are distinct types of things, and Lean needs explicit coercion functions to convert between them.

*Think of it this way*: the natural number `3 : ℕ` and the fraction `3 / 1 : ℚ` and the real number `3.000 : ℝ` are different objects that just happen to represent the same mathematical value.

The `push_cast` tactic helps manage these coercions, kind of like `ring_nf` but for casting instead of ring operations.

## New Tools You'll Need

- `⌈ ⬝ ⌉₊`: The natural number ceiling function
- `push_cast`: Tactic that handles coercions between number types
- `bound`: Solves many routine inequalities

The `bound` tactic can solve many \"trivial\" inequalities once the types are properly aligned.

## Hint:

If you get stuck and don't see a Hint, try backtracking until you do.
"

/-- The `push_cast` tactic handles coercions between number types, particularly useful when working with natural numbers that need to be treated as real numbers (or integers, or rationals). -/
TacticDoc push_cast

/-- The `bound` tactic can solve many \"trivial\" inequalities involving standard functions and basic arithmetic. -/
TacticDoc bound

NewTactic push_cast bound

/-- Given `ε` and the fact that `0 < ε`, the theorem `ArchProp` claims the existence of `N : ℕ` so that `1 / ε < N`. This is a formalization of the classical Archimedean Property. -/
TheoremDoc ArchProp as "ArchProp" in "Theorems"

/-- Prove the \"Archimedean Property\"
that no matter how small `ε > 0` may be,
there is always a natural number `N` with `1 / ε < N`.
-/
Statement ArchProp {ε : ℝ} (hε : 0 < ε) :
    ∃ (N : ℕ), 1 / ε < N := by
  Hint (hidden := true) "Try `use ⌈1 / ε⌉₊ + 1`. Of course you can use other values of `N`, but then I won't be able to give you more hints..."
  use ⌈1 / ε⌉₊ + 1
  Hint (hidden := true) "This is a good time to record the fact that `1 / ε ≤ ⌈1 / ε⌉₊`.
  You can do that with: `have fact : 1 / ε ≤ ⌈1 / ε⌉₊ := by bound`. The `bound` tactic can solve inequalities like this."
  have fact : 1 / ε ≤ ⌈1 / ε⌉₊ := by bound
  Hint (hidden := true) "You might think that the `bound` tactic
  would also be able to solve `1 / ε < ↑(⌈1 / ε⌉₊ + 1)`, but No!
  That's because the addition `⌈1 / ε⌉₊ + 1` happens as **natural numbers**, and only then is the result cast to the reals; so the
  `fact` that was just proved is not useful to `bound`. Instead try: `push_cast` to get the casting to push down as far as possible.
  The Goal will change to `1 / ε < ↑⌈1 / ε⌉₊ + 1`, where now the
  ceiling is cast to the reals, and then the real number `1` is added."
  push_cast
  Hint (hidden := true) "And now the `bound` tactic will do the trick."
  bound

Conclusion "

Let's compare now to the purely natural language proof:

## Natural Language Proof of the Archimedean Property

**Theorem**: For any positive real number ε > 0, there exists a natural number N such that 1 / ε < N.

**Proof**:
Let ε > 0 be given. We need to find a natural number N such that 1 / ε < N.

Use the value N = ⌈1 / ε⌉₊ + 1, where ⌈·⌉₊ denotes the natural number ceiling function.

Since ε > 0, we have 1 / ε > 0. By the definition of the natural number ceiling function, we know that:

1 / ε ≤ ⌈1 / ε⌉₊

Now, since ⌈1 / ε⌉₊ is a natural number and N = ⌈1 / ε⌉₊ + 1, we have:

⌈1 / ε⌉₊ < ⌈1 / ε⌉₊ + 1 = N

Combining these inequalities, we get that:

1 / ε ≤ ⌈1 / ε⌉₊ < N

Therefore, 1 / ε < N, which completes the proof. □

**Significance**: The Archimedean Property is fundamental to analysis because it ensures that the real numbers have no \"infinite\" or \"infinitesimal\" elements. It guarantees that we can always find natural numbers large enough to dominate any given positive real number when we take their reciprocals. This property is essential for many limit processes and is equivalent to the completeness of the real numbers in certain formulations of real analysis.

## Review of Common Pitfalls

- **Don't use the regular ceiling function `⌈·⌉`** - it returns integers, not natural numbers!
- **Watch out for casting issues** - if `bound` isn't working, try `push_cast` first
- **The addition `⌈1 / ε⌉₊ + 1` happens in `ℕ`**, then gets cast to `ℝ` - this is why we need `push_cast`

**Historical Note**: While often attributed to Archimedes (c. 287-212 BCE), this property was likely known to Eudoxus (c. 408-355 BCE) and appears in Euclid's *Elements*. Archimedes used a version of this principle in his method of exhaustion, particularly in calculating areas and volumes by approximating them with polygons of increasing numbers of sides.
"
