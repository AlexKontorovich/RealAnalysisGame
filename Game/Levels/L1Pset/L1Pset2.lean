import Game.Metadata

World "L1Pset"
Level 2
Title "Problem 2"

Introduction "
# Problem 2

In this problem you are asked to show that there is some `c` so that `(x + y) ^ 2 = c`, given that
`x * y = 1` and `x ^ 2 + y ^ 2 = 2`.

You will likely have a hard time solving this problem as is.
You surely can work out what value of
`c` you need. But if you try
`ring_nf`, you won't have control over
how the \"normal form\" chooses to
express things. In fact, the
left-hand side, `(x + y) ^ 2` will
turn into `x * y * 2 + x ^ 2 + y ^ 2`,
which is parsed in this order:

`(((x * y) * 2) + x ^ 2) + y ^ 2`

This means that you *will* be able to
`rewrite [h2]` successfully,
but then you will *not* be able to rewrite by `h1`, because the (invisible) parentheses  go the wrong way. (Hint: If you want to know how things are grouped but don't see parentheses, you can hover your cursor over the text in the Goal State, and Lean will show you the groupings. Try it!)

To get around this issue, you can `rewrite` by a fact that you prove on the spot, using the new `show` tactic.

## New Tactic: `show`

The syntax is: `show factToBeProved by giveTheProof`. For example, this might come in handy:

`rewrite [show (x + y) ^ 2 = (x ^ 2 + y ^ 2) + 2 * (x * y) by ring_nf]`

What this is doing is using `ring_nf` to prove the fact that `(x + y) ^ 2` equals `(x ^ 2 + y ^ 2) + 2 * (x * y)`.
This allows you to control what `ring_nf` is proving for you,
and immediately `rewrite` by that fact.

"

/-- The `show` tactic has syntax `show fact by proof`. -/
TacticDoc «show»

NewTactic «show»


/-- Show that there exists a constant `c` so that, for any real numbers `x` and `y` with `x ^ 2 + y ^ 2 = 2` and `x * y = 1`, we have `(x + y) ^ 2 = c`. -/
Statement :
 ∃ c, ∀ x y : ℝ, x ^ 2 + y ^ 2 = 2 → x * y = 1 → (x + y) ^ 2 = c := by
  use 4
  intro x y
  Hint (hidden := true) "If you're stuck at this point, let me remind you that, in a previous level, the Goal was: `∀ ε > 0, BlahBlah`, and
  after `intro ε`, the Goal became `ε > 0 → BlahBlah`.
  Then what did you do?..."
  intro h1 h2
  rewrite [show (x + y) ^ 2 = (x ^ 2 + y ^ 2) + 2 * (x * y) by ring_nf]
  rewrite [h1]
  rewrite [h2]
  ring_nf

Conclusion "Great job using the `show` tactic to control what fact you wanted to prove!"
