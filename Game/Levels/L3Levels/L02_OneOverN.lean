import Game.Levels.L3Levels.L01_ArchProp

open Nat

World "Lecture3"
Level 2
Title "First Real Limit"

Introduction "
# Level 2: Our First Real Limit

*Congratulations!* You've just proved the Archimedean Property. Now let's use it to prove something genuinely interesting: our first non-trivial limit.

## The Goal: Proving that `1 / n → 0`

We want to prove that the sequence `a(n) = 1 / n` converges to `0` as `n` approaches infinity. This is intuitively obvious—as `n` gets larger, `1 / n` gets smaller and approaches `0`. But how do we make this rigorous using the `ε`-`N` definition of limits?

**Theorem**: The sequence `a(n) = 1 / n` converges to `0`.

This might seem straightforward, but let's see it as a test of the definition.

## Recall: The Definition of Sequential Convergence

A sequence `a : ℕ → ℝ` converges to a limit `L` (written `SeqLim a L`) if:

**For every `ε > 0`, there exists `N : ℕ` such that for all `n ≥ N`, `|a(n) - L| < ε`**

In formal notation: `∀ ε > 0, ∃ N, ∀ n ≥ N, |a(n) - L| < ε`

For our specific case with `a(n) = 1 / n` and `L = 0`, this becomes:
`∀ ε > 0, ∃ N, ∀ n ≥ N, |1 / n - 0| < ε`

## The Natural Language Proof Strategy

Here's how we'll prove this step by step:

**Step 1**: Let `ε > 0` be given. (This will correspond to `intro ε hε`)

**Step 2**: We need to find `N` such that for all `n ≥ N`, we have `1 / n < ε`.

**Key insight**: We need `1 / n < ε`, which is equivalent to `1 / ε < n` (since both sides are positive). So we need `n` to be larger than `1 / ε`.
When our Engineer requests the tolerance of `ε = 1/100`, the Machinist replies, ok, I can do that, but I'll need `N = 1 / ε = 100` days in my factory.


**Step 3**: That's exactly why we developed the Archimedean Property! It tells us that there exists some natural number `N` such that `1 / ε < N`.
Rather than reproving that from scratch, we can simply quote this fact;
then
we'll choose such an `N` and use it.

**Step 4**: Now let `n ≥ N` be given. We have:
- `1 / ε < N` (by our choice of `N`)
- `N ≤ n` (by assumption)
- Therefore: `1 / ε < N ≤ n`, so `1 / ε < n`
- Taking reciprocals (and flipping the inequality): `1 / n < ε`

**Step 5**: Since `|1 / n - 0| = |1 / n| = 1 / n < ε`, we're done! □

## The Lean Implementation Challenges

### Challenge 1: Cross-Multiplying Fractions
Our key step is showing that `1 / n < ε`. In paper mathematics, we'd simply cross-multiply to get `1 < n * ε`. But Lean is very careful about division by zero, so we can't just cross-multiply willy-nilly.

**The Problem**: We want to go from `1 / n < ε` to `1 < n * ε`, but this is only valid if `n > 0` and `ε > 0`.

**Solution**: The `field_simp` tactic handles this automatically! It will clear denominators by cross-multiplying, but only after it can verify that all denominators are positive (or at least non-zero).

### Challenge 2: Linear Arithmetic
Once we've cleared the fractions, we need to combine various inequalities like:
- `1 / ε < N` (from the Archimedean Property)
- `N ≤ n` (our assumption)
- `1 < n * ε` (our goal after clearing denominators)

For some reason, the `bound` tactic doesn't always handle these linear combinations well, especially when they involve multiplication by variables.

**Solution**: The `linarith` tactic is specifically designed for linear arithmetic. It can take a list of hypotheses and solve goals that follow from linear combinations of those hypotheses.

### Challenge 3: Explicit Type Casting
Remember those mysterious up arrows `↑` from the last level? They're back! When we write `1 / n`, Lean sees this as `1 / ↑n` where `n` starts as a natural number but needs to be cast as a real number.

Sometimes we have to be specific about what type of casting to use. The expression `1 / ↑n` could be ambiguous—are we casting to integers, rationals, reals, or something else?

**Solution**: Instead of an up arrow, we can specify the casting explicitly with this syntax: `(n : ℝ)`. This tells Lean exactly what type we want to cast `n` to, in this case, the reals. This eliminates ambiguity and makes your proofs more precise.

### Challenge 4: Casting in Tactic Applications
Sometimes you want to apply a tactic or theorem, but the types don't quite match because of casting issues. For example, you might have the hypothesis that `N ≤ n` where `n, N` are naturals, but `bound` or `linarith` are searching for a proof that `(N : ℝ) ≤ (n : ℝ)` as reals.

**Solution**: The `exact_mod_cast` tactic is like `apply`, but it automatically handles the type coercions for you. If you're trying to prove `(N : ℝ) ≤ (n : ℝ)`, and you have the hypothesis `h : N ≤ n` (as naturals), then you can write: `exact_mod_cast h`. Lean will look at `h`
and realize, oh it's exactly what you're trying to prove, but just
cast to a different number system; and it'll figure out the proof from there.

## New Tools You'll Need

- **`field_simp`**: Clears denominators by cross-multiplying, but only when it can prove the denominators are non-zero. This is the key to handling fractional inequalities safely.

- **Arithmetic with inequalities**: You might also find the `linarith` tactic helpful. It is a very powerful, general tactic like `ring_nf`, but instead of proving algebraic *identities*, it proves *inequalities* involving \"linear arithmetic\" on the specified hypotheses. For example,
if you have as hypotheses: `h₁ : X ≤ Y`, `h₂ : 2 * Y ≤ Z`,
and your Goal is to prove that `2 * X ≤ Z`, then
simply calling `linarith [h₁, h₂]` will do the trick. So add as many inequality hypotheses to your Game Board as you may need, and then call `linarith` on them to prove a Goal. I find that `linarith` is best called at the very end, when you've assembled all your facts and are ready to close a Goal (but it has many other uses as well, as you'll see).

- **Explicit casting `(n : ℝ)`**: Tells Lean exactly what type to use, eliminating ambiguity in expressions like `1 / n`. You only need to cast
once in any expression, and Lean will automatically cast everything else.
For example, you can say `(0 : ℝ) < N`, and Lean will figure out that
the `0` you mean is a real number, and so, to compare that with `N`,
the latter too must be cast to the reals.

- **`exact_mod_cast`**: Automatically handles type coercions between different number types (ℕ, ℤ, ℚ, ℝ), when the Goal is *exactly*
what you're trying to prove, just needs to get coerced.


## Pro Tips for This Level

1. **Use `change`** to convert `SeqLim a 0` to its definition
2. **Apply the Archimedean Property** to get the existence of an `N`
3. **Use `choose`** to extract the `N` from the existential statement
4. **Establish positivity first** before using `field_simp`
5. **Work step by step** - don't try to do everything at once!

## What Makes This Non-Trivial?

Unlike the constant sequence (which was essentially definitional), this proof requires:
- **The Archimedean Property** to find a suitable `N`
- **Careful type management** between `ℕ` and `ℝ`
- **Positivity arguments** to handle division
- **Inequality manipulation** to connect our bounds

This is a perfect example of how even \"obvious\" mathematical facts require sophisticated machinery to prove rigorously!
"

/-- The `linarith` tactic, with syntax `linarith [h₁, h₂]`, can solve goals that are linear arithmetic combinations of hypotheses `h₁, h₂` involving `≤`, `<`, `=` with addition and multiplication by constants.
- ✅ **Linear:** `2*x + y - 3`, `z / 5`
- ❌ **Not Linear:** `x*y`, `x^2`, `|x|`, `1/x`

Example Usage:
h1 : x < y
h2 : y ≤ z
Goal: x < z + 1
linarith [h1, h2]
-/
TacticDoc linarith

/-- The `field_simp` tactic tries to clear denominators, if it can figure out that the denominators are non-zero (or in the case of inequalities, positive). -/
TacticDoc field_simp

/-- The `exact_mod_cast` tactic is similar to `apply`, except it automatically handles type coercions that would otherwise require manual casting. -/
TacticDoc exact_mod_cast

NewTactic linarith field_simp exact_mod_cast

/-- If `a n = 1 / n`, then `SeqLim a 0`; that is, the sequence
`1 / n` converges to zero. -/
TheoremDoc OneOverNLimZero as "OneOverNLimZero" in "aₙ"


/-- Prove that the sequence `a(n) = 1 / n` converges to 0.
This is our first substantive limit proof, requiring the Archimedean Property.
-/
Statement OneOverNLimZero (a : ℕ → ℝ) (ha : ∀ n, a n = 1 / n) : SeqLim a 0 := by
  Hint (hidden := true) "Start by converting to the definition of sequential convergence using `change`."
  change ∀ ε > 0, ∃ N, ∀ n ≥ N, |a n - 0| < ε
  intro ε hε
  Hint (hidden := true) (strict := true) "We need to find `N`. Use the Archimedean Property: there exists `N` such that `1 / ε < N`. Try: `have f1 : ∃ (N : ℕ), 1 / ε < N := by apply ArchProp hε`"
  have f1 : ∃ (N : ℕ), 0 < N ∧ 1 / N < ε := by sorry -- apply ArchProp hε
  Hint (hidden := true) (strict := true) "Presumably you know that you
  should `choose N hN using f1` at this stage. But maybe you'd like to give `hN` a more descriptive name (so that I can keep giving you hints). Try `choose N eps_inv_lt_N using f1`."
  choose N Npos hN using f1
  use N
  Hint (hidden := true) (strict := true) "Again, you presumably you know
  now to do `intro n hn`. But let's also give `hn` the more descriptive name `n_ge_N`. So that I can keep giving you hints, try `intro n n_ge_N`."
  intro n hn
  specialize ha n
  rewrite [ha]
  rewrite [show 1 / (n : ℝ) - 0 = 1 / n by ring_nf]
  have Npos' : (0 : ℝ) < N := by exact_mod_cast Npos
  have hn' : (N : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
  have hnpos : (0 : ℝ) < (n : ℝ) := by linarith [Npos', hn']
  have f3 : 0 ≤ 1 / (n : ℝ) := by positivity
  rewrite [show |1 / (n : ℝ)| = 1 / (n : ℝ) by apply abs_of_nonneg f3]
  have f4 : 1 / (n : ℝ) ≤ 1 / N := by field_simp; apply hn'
  linarith [hN, f4]

  Hint (hidden := true) (strict := true) "Simplify the absolute value: `have f2 : |1 / (n : ℝ)| = 1 / n := by bound`. Note the explicit casting to the reals, so that this is not a statement about natural numbers!"
  have f2 : |1 / (n : ℝ)| = 1 / n := by bound
  rewrite [f2]
  Hint (hidden := true) (strict := true) "Now we need `1 / n < ε`. First establish that everything is positive. Start with: `have f3 : 0 < 1 / ε := by bound`"
  have f3 : 0 < 1 / ε := by bound
  Hint (hidden := true) (strict := true) "Since 1 / ε < N, we get N > 0: `have Npos : (0 : ℝ) < N := by linarith [f3, eps_inv_lt_N]`. Again we need to be specific about the casting."
  have Npos : (0 : ℝ) < N := by linarith [f3, eps_inv_lt_N]
  Hint (hidden := true) (strict := true) "Cast the inequality `n ≥ N` to reals, so that `linarith` can see and access it: `have N_le_n : (N : ℝ) ≤ n := by exact_mod_cast n_ge_N`"
  have N_le_n : (N : ℝ) ≤ n := by exact_mod_cast n_ge_N
  Hint (hidden := true) (strict := true) "Therefore `n > 0`; try: `have npos : (0 : ℝ) < n := by linarith [Npos, N_le_n]`"
  have npos : (0 : ℝ) < n := by linarith [Npos, N_le_n]
  Hint (hidden := true) "Clear denominators in the goal: `field_simp`"
  field_simp
  Hint (hidden := true) "Also clear denominators in our key inequality: `field_simp at eps_inv_lt_N`"
  field_simp at eps_inv_lt_N
  Hint (hidden := true) (strict := true) "Multiply the inequality `N ≤ n` by ε: `have f4 : N * ε ≤ n * ε := by bound`"
  have f4 : N * ε ≤ n * ε := by bound
  Hint (hidden := true) "Combine everything with `linarith [eps_inv_lt_N, f4]`"
  linarith [eps_inv_lt_N, f4]

Conclusion "
As usual, compare to what's written in textbooks:

## Natural Language Proof of `1 / n → 0`

**Theorem**: The sequence `a(n) = 1 / n` converges to `0`.

**Proof**:
Let `ε > 0` be given. We need to find `N : ℕ` such that for all `n ≥ N`, we have `|1 / n - 0| < ε`.

Since `ε > 0`, we have `1 / ε > 0`. By the Archimedean Property, there exists a natural number `N` such that `1 / ε < N`. We choose this value of `N`, and use it.

Now let `n ≥ N` be given. We need to show that `|1 / n| < ε`.

Since `1 / ε < N` and `N ≤ n`, we have that `1 / ε < n`. Since both `1 / ε` and `n` are positive, taking reciprocals reverses the inequality: `1 / n < ε`.

Therefore, `|1 / n - 0| = |1 / n| = 1 / n < ε`, which completes the proof. □

## What We Just Accomplished

This proof demonstrates several key concepts:

1. **The power of the Archimedean Property**: Without it, we couldn't guarantee the existence of a suitable `N`.

2. **The `ε`-`N` definition in action**: We explicitly constructed `N` in terms of `ε`, showing the quantifier structure `∀ε, ∃N, ∀n`.

3. **Rigorous inequality manipulation**: What seems \"obvious\" requires careful attention to positivity and type casting.

4. **The bridge between intuition and formality**: The intuitive idea that \"`1 / n` gets arbitrarily small\" becomes a precise mathematical statement.

"
