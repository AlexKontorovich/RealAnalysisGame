import Game.Levels.L22Pset.L01

open Finset Set

World "L22Pset"
Level 2
Title "Continuity Exercise"
Introduction "
# Level 2: Continuity Exercise

Prove that `x ↦ x ^ 3` is continuous.

"

/-- Prove this
-/
Statement : FunCont (fun x ↦ x ^ 3) := by
intro x ε hε
let den : ℝ := 3 * |x| ^ 2 + 3 * |x| + 1
have denPos : 0 < den := by linarith [show 0 ≤ |x| by bound, show 0 ≤ |x| ^ 2 by bound]
let δ : ℝ := min 1 (ε / den)
have δle1 : δ ≤ 1 := by bound
have δle2 : δ ≤ ε / den := by bound
field_simp at δle2
have δpos : 0 < δ := by bound
use δ, δpos
intro y hy
rewrite [show y^3 - x^3 = (y - x) * (x ^ 2 + x * y + y ^ 2) by ring_nf]
rewrite [show |(y - x) * (x ^ 2 + x * y + y ^ 2)| = |y - x| * |x ^ 2 + x * y + y ^ 2| by apply abs_mul]
have hy' : |y| ≤ |x| + 1 := by 
  have hxy : |y| = |y - x + x| := by ring_nf
  have hxy' : |y - x + x| ≤ |y - x| + |x| := by apply abs_add
  linarith [hxy, hxy', hy, δle1]
have h' : |x ^ 2 + x * y + y ^ 2| ≤ den := by 
  have f0 : |x ^ 2 + x * y + y ^ 2| ≤ |x ^ 2 + x * y| + |y ^ 2| := by apply abs_add
  have f1 : |x ^ 2 + x * y| ≤ |x ^ 2| + |x * y| := by apply abs_add
  rewrite [show |x ^ 2| = |x| ^ 2 by rewrite [show x ^ 2 = x * x by ring_nf, abs_mul]; ring_nf] at f1
  have f2 : |x * y| ≤ |x| ^ 2 + |x| := by 
    rewrite [abs_mul, show |x| ^ 2 + |x| = |x| * (|x| + 1) by ring_nf]
    bound
  have f3 : |y ^ 2| ≤ (|x| + 1) ^ 2 := by 
    rewrite [show y ^ 2 = y * y by ring_nf, abs_mul, show (|x| + 1) ^ 2 = (|x| + 1) * (|x| + 1) by ring_nf]
    bound
  linarith [f0, f1, f2, f3]
by_cases hxy : x ^ 2 + x * y + y ^ 2 = 0
rewrite [hxy]
norm_num
apply hε
push_neg at hxy
have f0 : 0 < |x ^ 2 + x * y + y ^ 2| := by apply abs_pos_of_nonzero hxy
have f1 : |y - x| * |x ^ 2 + x * y + y ^ 2| < δ * |x ^ 2 + x * y + y ^ 2| := by bound
have f2 : δ * |x ^ 2 + x * y + y ^ 2| ≤ δ * den := by bound
linarith [δle2, f1, f2]


Conclusion "
"
