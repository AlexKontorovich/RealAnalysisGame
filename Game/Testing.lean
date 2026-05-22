import Mathlib

/-
The goal of this file is to build up the entire Game and test the various closing tactics against the situations in which they occur. They should be just strong enough but not too strong!
-/

macro "split_abs" "[" t:term,* "]" : tactic => `(tactic| (
  simp only [abs_lt, abs_le, $[$t:term],*]
  split_ifs <;> linarith
))

macro "triangle_ineq" : tactic => `(tactic| (
  simp only [abs, max_def]
  split_ifs <;> linarith
))

macro "contradiction" "[" t:term,* "]" : tactic => `(tactic| (
  linarith only [$t,*]
))

macro "conclude" "[" t:term,* "]" : tactic => do
  `(tactic| (iterate 5 (try (first
    | (fail_if_no_progress triangle_ineq)
    | rel [$t,*]
    | (fail_if_no_progress simp [$[$t:term],*]; norm_num)
    | (fail_if_no_progress field_simp [$[$t:term],*])
    | ring_nf | norm_num | norm_cast
    | linarith only [$t,*] | nlinarith only [$t,*]
    | positivity | abel | omega)); done)
    )

--------------- TESTS ----------------------------

-- Problem 1 needs:
example (f : ℝ → ℝ) (c : ℝ) (hf : ∀ x, f x = c) (y : ℝ) : |f y - c| = 0 := by
  -- conclude [hf] -- FAILS!?
  simp [hf] -- SUCCEEDS

-- Problem 3 needs:
example (a : ℕ → ℝ) (ha : ∀ (n : ℕ), a n = 1/n) (n : ℕ) : |a n - 0| = 1 / n := by
  -- conclude [ha] -- FAILS!?
  simp [ha] -- SUCCEEDS

-- Problem 3 needs:
example (N : ℕ) (Npos : N > 0) (n : ℕ) (hn : n > N) : (1 : ℝ) / n ≤ 1 / N := by
--  conclude [] -- FAILS; good!
  conclude [hn] -- SUCCEEDS; good

-- `NegOnePowDNC` needs:
example (a : ℕ → ℝ) (ha : ∀ (n : ℕ), a n = (-1) ^ n) (N : ℕ) : a (2 * N) = 1 := by
  -- conclude [ha] -- FAILS!?
  simp [ha] -- SUCCEEDS

-- `NegOnePowDNC` needs:
example (a : ℕ → ℝ) (ha : ∀ (n : ℕ), a n = (-1) ^ n) (N : ℕ) : a (2 * N + 1) = -1 := by
  -- conclude [] -- FAILS; good!
  conclude [ha] -- SUCCEEDS; good

-- `NegOnePowDNC` needs:
example : (2 : ℝ) = |1 - (-1)| := by
  conclude [] -- SUCCEEDS; good

-- `NegOnePowDNC` needs:
example (L : ℝ) : |1 - (-1)| ≤|1 - L| + |(-1) - L| := by
  conclude [] -- SUCCEEDS; good

-- `NegOnePowDNC` needs:
example (L a2n a2n1 : ℝ) (ha2n : a2n = 1) (ha2n1 : a2n = -1) :
    |1 - L| + |(-1) - L| = |a2n - L| + |a2n1 - L| := by
  -- conclude [] -- SUCCEEDS! It shouldn't
  conclude [ha2n, a2n1] -- SUCCEEDS

-- `NegOnePowDNC` needs:
example (L a2n a2n1 : ℝ) (ha2n : |a2n - L| ≤ 1/2) (ha2n1 : |a2n1 - L| ≤ 1/2) :
    |a2n - L| + |a2n1 - L| ≤ 1/2 + 1/2 := by
  -- conclude [ha2n, a2n1] -- FAILS!?
  linarith only [ha2n, ha2n1] -- SUCCEEDS

-- `DoubleSeqConv` step 0: simple `linarith`
example (ε : ℝ) (hε : ε > 0) : 0 < ε / 2 := by
  -- conclude [hε] -- FAILS!?
  linarith only [hε] -- SUCCEEDS

-- `DoubleSeqConv` step 1: rewrite b n via hb n
example (a b : ℕ → ℝ) (L : ℝ) (N : ℕ) (n : ℕ) (hb : b n = 2 * a n) :
    |b n - 2 * L| = 2 * |a n - L| := by
  -- conclude [] -- SUCCEEDS; it shouldn't!
  conclude [hb] -- SUCCEEDS

-- `DoubleSeqConv` step 2: multiplying an inequality by a positive number
example (a : ℕ → ℝ) (L ε : ℝ) (n : ℕ) (hN : |a n - L| < ε / 2) :
    2 * |a n - L| < 2 * (ε / 2) := by
  -- conclude [hN] -- FAILS!?
  simp [hN] -- SUCCEEDS

-- `SumLim` step 1: rewrite c n via hc n
example (a b c : ℕ → ℝ) (L M : ℝ) (n : ℕ) (hc : c n = a n + b n) :
    |c n - (L + M)| = |a n + b n - (L + M)| := by
  -- conclude [] -- SUCCEEDS; it shouldn't!
  conclude [hc] -- SUCCEEDS

-- `SumLim` step 2: abs of ring-equal expressions
example (a b : ℕ → ℝ) (L M : ℝ) (n : ℕ) :
    |a n + b n - (L + M)| = |(a n - L) + (b n - M)| := by
  conclude [] -- SUCCEEDS (ring_nf normalizes inside abs)

-- `SumLim` step 3: triangle inequality
example (a b : ℕ → ℝ) (L M : ℝ) (n : ℕ) :
    |(a n - L) + (b n - M)| ≤ |a n - L| + |b n - M| := by
  conclude [] -- SUCCEEDS (triangle_ineq)

-- `SumLim` step 4: adding two half-epsilon bounds
-- conclude FAILS: triangle_ineq fires first, expands abs in goal into cases,
-- then linarith can't close them because h1/h2 are still in |·| form
example (a b : ℕ → ℝ) (L M ε : ℝ) (n : ℕ)
    (h1 : |a n - L| < ε / 2) (h2 : |b n - M| < ε / 2) :
    |a n - L| + |b n - M| < ε / 2 + ε / 2 := by
  -- conclude [h1, h2] -- FAILS
  linarith only [h1, h2] -- SUCCEEDS

-- SumLim step 5: arithmetic
-- conclude FAILS: ring_nf normalizes to ε*(1+1) = ε*2 but can't close it
-- (norm_num won't close an equation with a free variable ε)
example (ε : ℝ) : ε / 2 + ε / 2 = ε := by
  -- conclude [] -- FAILS
  linarith only -- SUCCEEDS

---------------------

def FunLimAt (f : ℝ → ℝ) (L : ℝ) (c : ℝ) : Prop :=
  ∀ ε > 0, ∃ δ > 0, ∀ y ≠ c, |y - c| < δ → |f y - L| < ε

def FunCont (f : ℝ → ℝ) : Prop :=
  ∀ x, ∀ ε > 0, ∃ δ > 0, ∀ y, |y - x| < δ → |f y - f x| < ε

-- **DECISION**: Should `ε` be implicit argument? Con: it is the most common variable to be used in the proof, so it would be nice to have it available without having to write `ε` every time. Pro: it is a variable that is often used in multiple places in the same proof, so it would be nice to have it available as an explicit argument.
-- def SeqLim (a : ℕ → ℝ) (L : ℝ) : Prop :=
--   ∀ {ε : ℝ}, ε > 0 → ∃ N, ∀ n ≥ N, |a n - L| < ε

-- **WORLD 1** Sequence convergence and limits, first steps

def SeqLim (a : ℕ → ℝ) (L : ℝ) : Prop :=
  ∀ ε > 0, ∃ N, ∀ n ≥ N, |a n - L| < ε

def SeqConv (a : ℕ → ℝ) : Prop :=  ∃ L, SeqLim a L

theorem ArchProp {ε : ℝ} (hε : ε > 0) : ∃ N > (0 : ℕ), 1 / (N : ℝ) < ε := by sorry

theorem SeqConstLim (a : ℕ → ℝ) (c : ℝ) (ha : ∀ n, a n = c) :
    SeqLim a c := by
  intro ε hε
  use 0
  intro n hn
  have h1 := (calc
    |a n - c| = 0 := by simp [ha] -- conclude [ha] FAILS
    _ < ε := by conclude [hε])
  apply h1

theorem SeqLimOneOverN (a : ℕ → ℝ) (ha : ∀ n, a n = 1 / n) :
    SeqLim a 0 := by
  intro ε hε
  choose N Npos hN using ArchProp hε
  use N
  intro n hn
  have h1 := (calc
    |a n - 0| = 1 / n := by simp [ha] -- conclude [ha] FAILS
    _ ≤ 1 / N := by conclude [hn]
    _ < ε := by conclude [hN])
  apply h1

theorem NegOnePowDNC (a : ℕ → ℝ) (ha : ∀ n, a n = (-1) ^ n) : ¬ SeqConv a := by
  intro h
  choose L hL using h
  specialize hL (1/2) (by simp)
  choose N hN using hL
  have h1 := (calc
    a (2*N+1) = -1 := by conclude [ha])
  have h2 := (calc
    a (2*N) = 1 := by simp [ha]) -- conclude [ha]) -- FAILS!
  have h1p := (calc
    |a (2 * N + 1) - L| < 1/2 := by
            apply hN _ (by linarith only)) -- conclude [hN])
  have h2p := (calc
    |a (2 * N) - L| < 1/2 := by
            apply hN _ (by linarith only)) -- conclude [hN])
  have h3 := (calc
    (2 : ℝ) = |1 - (-1)| := by conclude []
    _ ≤ |1 - L| + |-1 - L| := by conclude []
    _ = |a (2 * N) - L| + |a (2 * N + 1) - L| := by conclude [h1, h2]
    _ ≤ 1/2 + 1/2 := by linarith only [h1p, h2p])
  contradiction [h3]

theorem DoubleSeqConv (a b : ℕ → ℝ) (L : ℝ)
    (ha : SeqLim a L) (hb : ∀ n, b n = 2 * a n) :
    SeqLim b (2 * L) := by
  intro ε hε
  have hε2 := (calc 0 < ε / 2 := by linarith only [hε]) -- conclude [hε])
  specialize ha _ hε2
  choose N hN using ha
  use N
  intro n hn
  specialize hN n hn
  specialize hb n
  have h1 := (calc
    |b n - 2 * L| = 2 * |a n - L| := by conclude [hb]
    _ < 2 * (ε / 2) := by simp [hN] -- conclude [hN]
    _ = ε := by conclude [])
  apply h1

-- **BIG BOSS** `SumLim`
theorem SumLim (a b c : ℕ → ℝ) (L M : ℝ)
    (ha : SeqLim a L) (hb : SeqLim b M) (hc : ∀ n, c n = a n + b n) :
    SeqLim c (L + M) := by
  intro ε hε
  have hε2 : 0 < ε / 2 := by linarith only [hε] -- conclude [hε] FAILS
  choose Na hNa using ha _ hε2
  choose Nb hNb using hb _ hε2
  use Na + Nb
  intro n hn
  have hna : Na ≤ n := by linarith only [hn] -- conclude [hn] FAILS
  have hnb : Nb ≤ n := by linarith only [hn] -- conclude [hn] FAILS
  specialize hNa n hna
  specialize hNb n hnb
  calc |c n - (L + M)|
      = |a n + b n - (L + M)| := by simp [hc] -- conclude [hc n]  -- FAILS
    _ = |(a n - L) + (b n - M)| := by conclude []     -- SUCCEEDS
    _ ≤ |a n - L| + |b n - M| := by conclude []       -- SUCCEEDS
    _ < ε / 2 + ε / 2 := by linarith only [hNa, hNb]   -- conclude FAILS (step 4)
    _ = ε := by linarith only [] -- conclude [] FAILS (step 5)

-- **WORLD 2** Working with absolute values in convergence

-- `split_ands` NEW:
example (x y : ℝ) (hx : x = 2) (hy : y = 3) :
    x = 2 ∧ y = 3 := by
split_ands
apply hx
apply hy

-- `right` and `left` NEW:
example (x y : ℝ) (hx : x = 2) (hy : y = 3) :
    x = 3 ∨ y = 3 := by
right
apply hy

-- Dot notation NEW:
example  (x y : ℝ) (h : x = 2 ∧ y = 3) :
    y = 3 := by
apply h.2

-- `cases'` NEW:
example (x y : ℝ) (h : x = 2 ∨ y = 3) :
    (x - 2) * (y - 3) = 0 := by
cases' h with h1 h2
rewrite [h1]
ring_nf
rewrite [h2]
ring_nf

/-
Need: `split_abs` block/tactic that rewrites `|x| < y` into `-y < x ∧ x < y` and `|x| ≤ y` into `-y ≤ x ∧ x ≤ y`. This is the key to working with absolute values in convergence proofs, and it will allow us to apply our And/Or toolkit to these situations.
-/

theorem SeqLimLe (a : ℕ → ℝ) (L : ℝ) (ha : SeqLim a L) :
  ∃ N, ∀ n ≥ N, a n > L - 1 := by
specialize ha 1 (by simp)
choose N hN using ha
use N
intro n hn
specialize hN n hn
have h := (calc L - 1 < a n := by sorry ) --split_abs [hN]) -- conclude [hN]
apply h

-- **BIG BOSS**: `SqueezeTheorem`
theorem SqueezeTheorem (a b c : ℕ → ℝ) (L : ℝ)
    (ha : SeqLim a L) (hb : SeqLim b L) (hc : ∃ N, ∀ n ≥ N, a n ≤ c n ∧ c n ≤ b n) :
    SeqLim c L := by
  intro ε hε
  choose Na hNa using ha _ hε
  choose Nb hNb using hb _ hε
  choose N hN using hc
  use Na + Nb + N
  intro n hn
  have hna : Na ≤ n := by linarith only [hn] -- conclude [hn] FAILS
  have hnb : Nb ≤ n := by linarith only [hn] -- conclude [hn] FAILS
  have hnc : N ≤ n := by linarith only [hn] -- conclude [hn] FAILS
  specialize hNa n hna
  specialize hNb n hnb
  specialize hN n hnc
  -- `split_ands` -- FAILS
  rw [abs_lt] at ⊢ hNa hNb
  split_ands
  · have h1 := (calc
      -ε < a n - L := by conclude [hNa.1]
      _ ≤ c n - L := by conclude [hN.1])
    apply h1
  · have h1 := (calc
      c n - L ≤ b n - L := by conclude [hN.2]
      _ < ε := by conclude [hNb.2])
    apply h1



#exit

-- attribute [grind .] inv_lt_of_inv_lt₀
attribute [grind =] one_mul
attribute [grind =] Nat.cast_le._simp_1
attribute [grind =] Mathlib.Tactic.Qify.intCast_le._simp_1
attribute [grind =] Mathlib.Tactic.Rify.ratCast_le._simp_1
attribute [grind =] Int.cast_natCast
attribute [grind =] Rat.cast_natCast
