import Game.Levels.L18Pset.L06
import Game.Levels.L13PsetIntro

open Finset

World "L18Pset"
Level 7
Title "AntitoneSeriesOdd"
Introduction "
# Level 7: `AntitoneSeriesOdd`

Prove `AntitoneSeriesOdd`:

"

DisabledTheorem AntitoneSeriesOdd

/-- Prove `AntitoneSeriesOdd`
-/
Statement {a : ℕ → ℝ} (ha : Antitone a) : Antitone (fun n ↦ ∑ k ∈ range (2 * n + 1), (-1)^k * a k) := by
apply Antitone_of_succ
intro n
induction' n with n hn
rewrite [show 2 * (0 + 1) + 1 = 3 by ring_nf]
rewrite [show 2 * 0 + 1 = 1 by ring_nf]
rewrite [sum_range_succ, sum_range_succ]
rewrite [show ∑ x ∈ range 1, (-1) ^ x * a x + (-1) ^ 1 * a 1 + (-1) ^ 2 * a 2 = ∑ x ∈ range 1, (-1) ^ x * a x + ((-1) ^ 1 * a 1 + (-1) ^ 2 * a 2) by ring_nf]
rewrite [show (-1) ^ 1 * a 1 + (-1) ^ 2 * a 2 = -a 1 + a 2 by ring_nf]
linarith [ha (show 1 ≤ 2 by bound)]
rw [show 2 * (n + 1 + 1) + 1 = 2 * (n + 1) + 1 + 2 by ring_nf]
rw [sum_range_succ, sum_range_succ]
rw [show ∑ x ∈ range (2 * (n + 1) + 1), (-1) ^ x * a x +
        (-1) ^ (2 * (n + 1) + 1) * a (2 * (n + 1) + 1) +
        (-1) ^ (2 * (n + 1) + 2) * a (2 * (n + 1) + 2) =
        ∑ x ∈ range (2 * (n + 1) + 1), (-1) ^ x * a x +
        ((-1) ^ (2 * (n + 1) + 1) * a (2 * (n + 1) + 1) +
        (-1) ^ (2 * (n + 1) + 2) * a (2 * (n + 1) + 2)) by ring_nf]
rw [show (-1 : ℝ) ^ (2 * (n + 1) + 1) * a (2 * (n + 1) + 1) =
        -a (2 * (n + 1) + 1) by bound]
rw [show (-1 : ℝ) ^ (2 * (n + 1) + 2) = 1 by ring_nf; bound]
have h1 : a (2 * (n + 1) + 2) ≤ a (2 * (n + 1) + 1) := ha (by bound)
linarith [h1]

Conclusion "
"
