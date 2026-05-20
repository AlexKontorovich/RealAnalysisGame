import Game.Levels.L22Pset.L02

open Finset Set

World "L22Pset"
Level 3
Title "Differentiability Exercise"
Introduction "
# Level 3: Differentiability Exercise

Show that `x ↦ x ^ 3` is differentiable.

"

/-- Prove this
-/
Statement : ∃ g : ℝ → ℝ,
  FunDeriv (fun x ↦ x ^ 3) g := by
use (fun x ↦ 3 * x ^ 2)
intro x ε hε
have absNn : 0 ≤ |x| := by bound
let δ : ℝ := min 1 (ε / (3 * |x| + 1))
have δ_le1 : δ ≤ 1 := by bound
have δ_le2 : δ ≤ ε / (3 * |x| + 1) := by bound
field_simp at δ_le2
have δpos : 0 < δ := by bound
use δ, δpos
intro h hne hh
rewrite [show ((x + h) ^ 3 - x ^ 3) / h - 3 * x ^ 2 = (h - 0) * (3 * x + h) by field_simp; ring_nf]
rewrite [show |(h - 0) * (3 * x + h)| = |h - 0| * |3 * x + h| by apply abs_mul]
have h1 : |3 * x + h| ≤ 3 * |x| + 1 := by 
  have f1 : |3 * x + h| ≤ |3 * x| + |h| := by apply abs_add
  rewrite [show |3 * x| = |3| * |x| by apply abs_mul, show |(3 : ℝ)| = 3 by norm_num] at f1
  rewrite [show h - 0 = h by ring_nf] at hh
  linarith [hh, f1, δ_le1]
by_cases hxh : 3 * x + h = 0
rewrite [hxh]
norm_num
bound
have f1 : 0 < |3 * x + h| := abs_pos_of_nonzero hxh
have f2 : |h - 0| * |3 * x + h| < δ * |3 * x + h| := by bound
have f3 : δ * |3 * x + h| ≤ δ * (3 * |x| + 1) := by bound
linarith [f2, f3, δ_le2]

Conclusion "
"
