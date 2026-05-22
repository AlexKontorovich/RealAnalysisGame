import Game.Metadata

World "L1Pset"
Level 5
Title "Problem 5"

Introduction "
# Problem 5

You've learned about adding hypotheses with `have`, and that you can call tactics not
just to act on the Goal, but  also on hypotheses, via appending `at HypothesisName`.
You also know that calling the `rewrite` tactic with a hypothesis `h : X = Y` takes the *left hand side* `X` and replaces it by `Y`. But what if you needed instead to replace `Y`'s by `X`'s? We call that \"backwards rewriting\". The syntax for that is:

`rewrite [← h]`

or, coupled with that `at` component:

`rewrite [← h] at h2`

will do the rewriting at some other hypothesis, `h2`. You get the backwards arrow by typing \\left,
that is, the backslash, then the word `left`, and then a space.

You may (or may not!) find that useful in this problem.

## New Tactic (component): `←`

This symbol works in the `rewrite` tactic, allowing you to rewrite in the reverse direction. For example, if you have a hypothesis `h : X = Y`, then `rewrite [← h]` will replace `Y` by `X` in the Goal. Similarly, `rewrite [← h] at h2` will replace `Y` by `X` in hypothesis `h2`.

"

/-- The `←` symbol works in the `rewrite` tactic, allowing you to rewrite in the reverse direction. For example, if you have a hypothesis `h : X = Y`, then `rewrite [← h]` will replace `Y` by `X` in the Goal. Similarly, `rewrite [← h] at h2` will replace `Y` by `X` in hypothesis `h2`.
 -/
TacticDoc «←»

NewTactic «←»

/-- Solve the problem -/
Statement (p : ℝ → ℝ) (x : ℝ) (h1 : ∀ t, p (t) = t ^ 2 + 2 * t)
 (h2 : p (x) = 15)
 :
  ∃ b, x ^ 2 + 2 * x = b := by
  use 15
  specialize h1 x
  rewrite [h1] at h2
  apply h2

Conclusion "Done."
