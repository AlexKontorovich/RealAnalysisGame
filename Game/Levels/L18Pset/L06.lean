import Game.Levels.L18Pset.L05
open Finset

World "L18Pset"
Level 6
Title "MonotoneSeriesEven"
Introduction "
# Level 6: `MonotoneSeriesEven`

Prove `MonotoneSeriesEven`:

"

DisabledTheorem MonotoneSeriesEven

/-- Prove `MonotoneSeriesEven`
-/
Statement {a : ℕ → ℝ} (ha : Antitone a) :
  Monotone (fun n ↦ ∑ k ∈ range (2 * n), (-1)^k * a k) := by
apply Monotone_of_succ
intro n
induction' n with n hn
rewrite [show ∑ k ∈ range (2 * 0), (-1) ^ k * a k = 0 by bound]
rewrite [show 2 * (0 + 1) = 2 by ring_nf]
rewrite [sum_range_succ, sum_range_succ]
rewrite [show ∑ x ∈ range 0, (-1) ^ x * a x = 0 by bound]
rewrite [show 0 + (-1) ^ 0 * a 0 + (-1) ^ 1 * a 1 = a 0 - a 1 by ring_nf]
linarith [ha (show 0 ≤ 1 by bound)]
rewrite [show 2 * (n + 1 + 1) = 2 * (n + 1) + 1 + 1 by ring_nf]
rewrite [sum_range_succ, sum_range_succ]
rewrite [show ∑ x ∈ range (2 * (n + 1)), (-1) ^ x * a x + (-1) ^ (2 * (n + 1)) * a (2 * (n + 1)) +
    (-1) ^ (2 * (n + 1) + 1) * a (2 * (n + 1) + 1) = ∑ x ∈ range (2 * (n + 1)), (-1) ^ x * a x + ((-1) ^ (2 * (n + 1)) * a (2 * (n + 1)) +
    (-1) ^ (2 * (n + 1) + 1) * a (2 * (n + 1) + 1)) by ring_nf]
rewrite [show ((-1) ^ (2 * (n + 1)) * a (2 * (n + 1)) +
    (-1) ^ (2 * (n + 1) + 1) * a (2 * (n + 1) + 1))
    = a (2 * (n + 1)) + -a (2 * (n + 1) + 1) by bound]
have f1 : 0 ≤ a (2 * (n + 1)) + -a (2 * (n + 1) + 1) := by
  linarith [show a (2 * (n + 1) + 1) ≤ a (2 * (n + 1)) by apply ha (by bound)]
linarith [f1]

Conclusion "
"
