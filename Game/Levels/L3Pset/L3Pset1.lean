import Game.Levels.L3Lecture
import Game.Levels.L2PsetIntro

World "L3Pset"
Level 1
Title "Problem 1"

Introduction "# Problem 1

The \"full\" Archimedean Property is this:
Take two positive real numbers `x` and `y`. No matter
how large `y` may be, and how small `x` may be,
if we add `x` to itself enough times (that is, multiply it by some natural number), we can always get that to exceed `y`.
"

theorem ArchProp' {ε : ℝ} (hε : 0 < ε) : ∃ N : ℕ, 0 < N ∧ 1 / N < ε := by
  sorry

/-- Prove the full Archimedean Property. -/
Statement (x y : ℝ) (hx : 0 < x) (hy : 0 < y) : ∃ (N : ℕ), y < N * x  := by
have f0 : 0 < x / y := by positivity
have f1 : ∃ (N : ℕ), 0 < N ∧ 1 / N < x / y := ArchProp' f0
choose N Npos hN using f1
use N
field_simp at hN
apply hN

Conclusion "Done."
