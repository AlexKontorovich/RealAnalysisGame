import Game.Metadata

World "L1Pset"
Level 4
Title "Problem 4"

Introduction "
# Problem 4

This problem looks very similar to the previous one, but without a few hints, it
may cause great difficulty. The issue is that last time, you likely called `specialize h1 0`, and turned `h1` into:

`h1 : g (0 + 1) = g (0) + 3`

If you do that now, the original `h1` will be *gone*, and you won't have a way of accessing it *again* to bootstrap from `g (1)` to `g (2)`. So what should you do?

In natural language, there are times when you might want to
record an auxiliary fact: \"let's
*have* the fact that such and such ...\". The Lean
syntax for this is as follows:

`have NewFactName (Assumptions) : Conclusion := by Proof`

That is, you first write `have`; then give
the new hypothesis a name; then include any
assumptions, like `(x : ℝ)`, meaning, `x`
is a real number, etc (the symbol `ℝ` is written with a backslash, then capital `R`, then space); then you put a colon,
and then state the conclusion; then you
put a colon-equals and the word `by`; and finally you give the proof.

Observe that `have` can perform the same
role as `specialize` (and much more)! Try starting your solution with:

`have h3 : g (0 + 1) = g (0) + 3 := by apply h1 0`

This will not affect the original statement
of `h1`, but will instead add a *new* hypothesis, `h3`, which amounts to the
desired fact that `g (0 + 1) = g (0) + 3`.
Notice what's happening in the proof: `h1` says: for all `x`, `g (x + 1) = g (x) + 3`.
So `h1` is really a *function* whose input
is a real number `x`, and whose output is a
*proof* of the fact that, for this value of `x`, `g (x + 1) = g (x) + 3` holds. So when
we feed `0` into `h1`, it has the same effect
as it did when we `specialize`d, thus giving a proof of
 exactly what was claimed in the `have` statement.

Now you should be able to solve this problem.
"


/-- The `have` tactic has the following
syntax: `have NewHypothesisName (Assumptions) : Claim := by GiveTheProof`.
This creates a new hypothesis called
`NewHypothesisName : ∀ (Assumptions), ClaimHolds`.
 -/
TacticDoc «have»

NewTactic «have»

/-- Solve the problem -/
Statement (g : ℝ → ℝ) (h1 : ∀ x, g (x + 1) = g (x) + 3)
 (h2 : g (0) = 5)
 :
  g (2) = 11 := by
  have h3 : g (0 + 1) = g (0) + 3 := by apply h1 0
  rewrite [h2] at h3
  rewrite [show (0 : ℝ) + 1 = 1 by ring_nf] at h3
  specialize h1 1
  rewrite [h3] at h1
  rewrite [show (1 : ℝ) + 1 = 2 by ring_nf] at h1
  rewrite [show (5 : ℝ) + 3 + 3 = 11 by ring_nf] at h1
  apply h1

Conclusion "Done."
