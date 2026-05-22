import Game.Metadata

World "L1Pset"
Level 3
Title "Problem 3"

Introduction "
# Problem 3

You've just learned to prove any necessary
auxiliary
facts via the
`show` tactic.
In this problem,
you might find the following new idea useful.

You already know that if you
have a hypothesis `h : X = Y`, and the Goal
contains `X`, then if you `rewrite [h]`,
then any instances of `X` in the goal
get replaced by `Y`.
But what if you have another hypothesis `h2`,
and you want to replace `X`'s **in `h2`** by `Y`s, what should you do then?
Elementary, my dear Watson!
You simply type:

`rewrite [h] at h2`.

So the syntax is `rewrite [h]` as before, then
the word `at`, and finally the name of the
hypothesis where you want the rewriting to happen.
Similarly, you can say `ring_nf at h2`,
and any algebra in hypothesis `h2` will be put into normal form.

Now you should be able to solve this problem!

## New Tactic (component): `at`

This is not a standalone tactic, but rather a component that supercharges other tactics like `rewrite` and `ring_nf`. The syntax is: after specifying the tactic and its arguments as usual, you write `at` followed by the name of the hypothesis you want to apply the tactic to.

"

/--
To apply a tactic not to the Goal but to a specific hypothesis, use the `at` tactic helper.
For example, if you have a hypothesis `h1 : X = Y` and another hypothesis `h2 : P X`, then you can write `rewrite [h1] at h2` to replace `X` by `Y` in hypothesis `h2`, changing it to `h2 : P Y`.
-/
TacticDoc «at»

NewTactic «at»

/-- Solve the problem -/
Statement (g : ℝ → ℝ) (h1 : ∀ x, g (x + 1) = g (x) + 3)
 (h2 : g (0) = 5) : g (1) = 8 := by
  specialize h1 0
  rewrite [h2] at h1
  rewrite [show (0 : ℝ) + 1 = 1 by ring_nf] at h1
  rewrite [show (5 : ℝ) + 3 = 8 by ring_nf] at h1
  apply h1

Conclusion "Done."
