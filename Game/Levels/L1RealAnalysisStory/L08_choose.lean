import Game.Metadata

World "RealAnalysisStory"
Level 8
Title "The choose tactic"

Introduction "
# Extracting information from existential quantifiers

Now let's learn the counterpart to `use`. You know that if you have `∃` in the goal, you write `use` to provide a specific value.

But suppose you have a *hypothesis* that says \"there exists a real number `c` such that `f (c) = 2`\". In Lean, this looks like:
`h : ∃ (c : ℝ), f c = 2`

And say you want to prove that \"there exists a real number `c` such that `(f c)^2 = 4`\".

Again, you can't just say `apply h` because these are different statements.
If you know from `h` that at least one such `c` exists, how do you *choose* one?
 The name of this command is... `choose`.

The syntax for `choose` is as follows:

`choose c hc using h`.

You need to give a name to both the value of `c`, and to the hypothesis with which `c` is bundled. Here we named it `hc` (a hypothesis about `c`).

You should be able to figure out how to solve the goal from here.
"

/-- The `choose` tactic extracts a witness from an existence statement in a hypothesis. -/
TacticDoc choose

/-- If there exists a point where f equals 2, then there exists a point where f² equals 4. -/
Statement (f : ℝ → ℝ) (h : ∃ c : ℝ, f c = 2) : ∃ x : ℝ, (f x) ^ 2 = 4 := by
  Hint (hidden := true) "Write `choose c hc using h`, then you should be able to finish it yourself."
  choose c hc using h
  use c
  rewrite [hc]
  Hint (hidden := true) "If you're struggling to prove that `2 ^ 2 = 4`, it's
  a basic fact in a *ring*..."
  ring_nf

NewTactic choose

Conclusion "
Excellent! You've learned the `choose` tactic for working with existence in hypotheses.

Notice the complete pattern:
1. `choose c hc using h` unpacked the hypothesis into a specific value `c` and proof `hc : f c = 2`
2. `use c` provided this same value as our witness for the goal
3. `rewrite [hc]` rewrote `f c` as `2` in the goal, changing it to `2^2 = 4`
4. `ring_nf` verified that `2 ^ 2 = 4`

The symmetry is beautiful:
- `use` when you have `∃` in the goal (\"here's my specific example\")
- `choose` when you have `∃` in a hypothesis (\"let me unpack this existence claim\")

This completes your basic logical toolkit! In real analysis, you'll use `choose` (or a similar
tactic called `obtain`) constantly when working with:
- Limit definitions (\"given ε > 0, there exists δ > 0...\")
- Intermediate Value Theorem (\"there exists c such that f(c) = 0\")
- Existence theorems throughout analysis

You're now ready to tackle real mathematical proofs!
"
