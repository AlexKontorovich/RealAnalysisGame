# Lecture Level Documentation

This file catalogs the lecture levels imported by the lecture wrapper files in `Game/Levels`: Lecture 1 (`RealAnalysisStory`), Lecture 2 (`NewtonsCalculationOfPi`), and `Lecture3` through `Lecture25`. Problem-set worlds and the duplicate `L1RealAnalysisStory copy` folder are intentionally excluded.

## Theorem Types

These are the theorem-inventory buckets currently encoded by `TheoremDoc ... in "..."`:

- `Theorems`: general-purpose facts not tied to one analytic object.
- `aₙ`: sequence, convergence, Cauchy, boundedness, monotonicity, and subsequence facts.
- `|x|`: absolute-value and metric inequalities.
- `∑aₙ`: finite sums, series, and rearrangements.
- `f(x)`: function limits, continuity, and differentiability facts.
- `x∈U`: set, topology, compactness, and cover facts.
- `∫f`: Riemann-sum and integration facts.

## Level Catalog

### Lecture 1: The Story of Real Analysis

#### Level 1: Introduction to Lean
- Source: `Game/Levels/L1RealAnalysisStory/L00_the_problem.lean`
- Goal: `(x : ℝ) (h : x = 5) : x = 5`
- New tactic material: `apply`

#### Level 2: The rfl tactic
- Source: `Game/Levels/L1RealAnalysisStory/L02_rfl.lean`
- Goal: `(x y : ℝ) : x ^ 2 + 2 * y = x ^ 2 + 2 * y`
- New tactic material: `rfl`

#### Level 3: The `rewrite` tactic
- Source: `Game/Levels/L1RealAnalysisStory/L03_rw.lean`
- Goal: `(x y : ℝ) (Bob : x = 2) : x + y = 2 + y`
- New tactic material: `rewrite`

#### Level 4: The ring_nf tactic
- Source: `Game/Levels/L1RealAnalysisStory/L04_ring_nf.lean`
- Goal: `(x y : ℝ) : (x + y)^3 = x^3 + 3*x^2*y + 3*x*y^2 + y^3`
- New tactic material: `ring_nf`

#### Level 5: The use tactic
- Source: `Game/Levels/L1RealAnalysisStory/L05_use.lean`
- Goal: `(x y : ℝ) : ∃ (c : ℝ), (x + y)^4 = x^4 + 4*x^3*y + c*x^2*y^2 + 4*x*y^3 + y^4`
- New tactic material: `use`

#### Level 6: The intro tactic
- Source: `Game/Levels/L1RealAnalysisStory/L06_intro.lean`
- Goal: `∀ ε : ℝ, ε > 0 → (ε + 1)^2 = (ε + 1)^2`
- New tactic material: `intro`

#### Level 7: The specialize tactic
- Source: `Game/Levels/L1RealAnalysisStory/L07_specialize.lean`
- Goal: `(t : ℝ) (t_pos : t > 0) (f : ℝ → ℝ) (hf : ∀ x > 0, f (x) = x^2) : f (t) = t^2`
- New tactic material: `specialize`

#### Level 8: The choose tactic
- Source: `Game/Levels/L1RealAnalysisStory/L08_choose.lean`
- Goal: `(f : ℝ → ℝ) (h : ∃ c : ℝ, f c = 2) : ∃ x : ℝ, (f x) ^ 2 = 4`
- New tactic material: `choose`

#### Level 9: Big Boss: The Ultimate Tactic Challenge
- Source: `Game/Levels/L1RealAnalysisStory/L09_big_boss.lean`
- Goal: `(f : ℝ → ℝ) (h_existential : ∃ (a : ℝ), f (a) = 3) (h_universal : ∀ x > 0, f (x + 1) = f (x) + 9) : ∃ (b : ℝ), ∀ y > 0, f (y + 1)^2 = (f (y) + (f b)^2)^2`

### Lecture 2: Newton's Computation of π

#### Level 1: The Convergence of a Sequence
- Source: `Game/Levels/L2NewtonsCalculationOfPi/L01_SeqConvDef.lean`
- Goal: `ConstLim (a : ℕ → ℝ) (L : ℝ) (a_const : ∀ n, a n = L) : SeqLim a L`
- Definitions introduced/documented: `SeqLim`
- Theorem docs: `ConstLim` (`aₙ`)
- New tactic material: `change`, `norm_num`

### Lecture 3: More fun with Sequences

#### Level 1: Archimedean Property
- Source: `Game/Levels/L3Levels/L01_ArchProp.lean`
- Goal: `ArchProp {ε : ℝ} (hε : 0 < ε) : ∃ (N : ℕ), 1 / ε < N`
- Theorem docs: `ArchProp` (`Theorems`)
- New tactic material: `push_cast`, `bound`

#### Level 2: First Real Limit
- Source: `Game/Levels/L3Levels/L02_OneOverN.lean`
- Goal: `OneOverNLimZero (a : ℕ → ℝ) (ha : ∀ n, a n = 1 / n) : SeqLim a 0`
- Theorem docs: `OneOverNLimZero` (`aₙ`)
- New tactic material: `linarith`, `field_simp`, `exact_mod_cast`

### Lecture 4: Even more fun with Sequences

#### Level 1: NonConvergence
- Source: `Game/Levels/L4Levels/L01_NonConverge.lean`
- Goal: `(a : ℕ → ℝ) (ha : ∀ n, a n = (-1) ^ n) : ¬ SeqConv a`
- Definitions introduced/documented: `SeqConv`
- Theorem docs: `abs_add` (`|x|`), `abs_neg` (`|x|`)
- Supporting theorems newly unlocked: `abs_add`, `abs_neg`

### Lecture 5: Algebraic Limit Theorem, Part I

#### Level 1: Doubling a Convergent Sequence
- Source: `Game/Levels/L5Levels/L01_DoubleSeqConv.lean`
- Goal: `(a b : ℕ → ℝ) (L : ℝ) (h : SeqLim a L) (b_scaled : ∀ n, b n = 2 * a n) : SeqLim b (2 * L)`
- Theorem docs: `abs_mul` (`|x|`)
- Supporting theorems newly unlocked: `abs_mul`

### Lecture 6: Algebraic Limit Theorem, Part II

#### Level 1: Big Boss: The Sum of Convergent Sequences
- Source: `Game/Levels/L6Levels/L00_SumOfSeqs.lean`
- Goal: `SumLim (a b c : ℕ → ℝ) (L M : ℝ) (ha : SeqLim a L) (hb : SeqLim b M) (hc : ∀ n, c n = a n + b n) : SeqLim c (L + M)`
- Theorem docs: `SumLim` (`aₙ`)

#### Level 2: Split Ands
- Source: `Game/Levels/L6Levels/L01_SplitAnds.lean`
- Goal: `(x y : ℝ) (hx : x = 2) (hy : y = 3) : x = 2 ∧ y = 3`
- New tactic material: `split_ands`

#### Level 3: Left and Right
- Source: `Game/Levels/L6Levels/L02_LeftRight.lean`
- Goal: `(x y : ℝ) (hx : x = 2) (hy : y = 3) : x = 3 ∨ y = 3`
- New tactic material: `left`, `right`

#### Level 4: Dot Notation
- Source: `Game/Levels/L6Levels/L03_DotNotation.lean`
- Goal: `(x y : ℝ) (h : x = 2 ∧ y = 3) : y = 3`

#### Level 5: Cases'
- Source: `Game/Levels/L6Levels/L04_Cases'.lean`
- Goal: `(x y : ℝ) (h : x = 2 ∨ y = 3) : (x - 2) * (y - 3) = 0`
- New tactic material: `cases'`

#### Level 6: AbsLe
- Source: `Game/Levels/L6Levels/L05_AbsLt.lean`
- Goal: `(a : ℕ → ℝ) (L : ℝ) (ha : SeqLim a L) : ∃ N, ∀ n ≥ N, a n ≥ L - 1`
- Theorem docs: `abs_lt` (`|x|`)
- Supporting theorems newly unlocked: `abs_lt`

#### Level 7: Big Boss : Squeeze Theorem
- Source: `Game/Levels/L6Levels/L06_Squeeze.lean`
- Goal: `SqueezeThm (a b c : ℕ → ℝ) (L : ℝ) (aToL : SeqLim a L) (cToL : SeqLim c L) (aLeb : ∀ n, a n ≤ b n) (bLec : ∀ n, b n ≤ c n) : SeqLim b L`
- Theorem docs: `SqueezeThm` (`aₙ`)

### Lecture 7: Algebraic Limit Theorem, Part III

#### Level 1: Uniqueness of Limits
- Source: `Game/Levels/L7Levels/L00_Uniqueness.lean`
- Goal: `LimUnique (a : ℕ → ℝ) (L M : ℝ) (aToL : SeqLim a L) (aToM : SeqLim a M) : L = M`
- Theorem docs: `abs_pos_of_nonzero` (`|x|`), `LimUnique` (`aₙ`)
- Supporting theorems newly unlocked: `abs_pos_of_nonzero`
- New tactic material: `by_contra`

#### Level 2: Eventually
- Source: `Game/Levels/L7Levels/L01_Eventually.lean`
- Goal: `EventuallyGeHalfLimPos (a : ℕ → ℝ) (L : ℝ) (aToL : SeqLim a L) (LneZero: L ≠ 0) : ∃ N, ∀ n ≥ N, |L| / 2 ≤ |a (n)|`
- Theorem docs: `EventuallyGeHalfLimPos` (`aₙ`)

#### Level 3: Sequences of Absolute Values
- Source: `Game/Levels/L7Levels/L02_SeqOfAbs.lean`
- Goal: `AbsLim (a : ℕ → ℝ) (L : ℝ) (aToL : SeqLim a L) (b : ℕ → ℝ) (bEqAbsa : ∀ n, b n = |a n|) : SeqLim b |L|`
- Theorem docs: `abs_Lipschitz` (`|x|`), `AbsLim` (`aₙ`)
- Supporting theorems newly unlocked: `abs_Lipschitz`

#### Level 4: SeqInvLim
- Source: `Game/Levels/L7Levels/L03_SeqInvLim.lean`
- Goal: `InvLim (a : ℕ → ℝ) (L : ℝ) (aToL : SeqLim a L) (LneZero : L ≠ 0) (b : ℕ → ℝ) (bEqInva : ∀ n, b n = 1 / a n) : SeqLim b (1 / L)`
- Theorem docs: `abs_div` (`|x|`), `nonzero_of_abs_pos` (`|x|`), `InvLim` (`aₙ`)
- Supporting theorems newly unlocked: `nonzero_of_abs_pos`, `abs_div`

#### Level 5: ByCases
- Source: `Game/Levels/L7Levels/L04_ByCases.lean`
- Goal: `EventuallyGeHalfLim (a : ℕ → ℝ) (L : ℝ) (aToL : SeqLim a L) : ∃ N, ∀ n ≥ N, |L| / 2 ≤ |a (n)|`
- Theorem docs: `EventuallyGeHalfLim` (`aₙ`)
- New tactic material: `by_cases`

### Lecture 8: Induction

#### Level 1: NotEven
- Source: `Game/Levels/L8Levels/L03_Induction'.lean`
- Goal: `IdLeTwoPow (n : ℕ) : n < 2 ^ n`
- Theorem docs: `ge_one_of_nonzero` (`Theorems`), `IdLeTwoPow` (`Theorems`)
- Supporting theorems newly unlocked: `ge_one_of_nonzero`
- New tactic material: `induction'`

### Lecture 9: Algebraic Limit Theorem, Part IV

#### Level 1: Finite Sums
- Source: `Game/Levels/L9Levels/L04_FiniteSums.lean`
- Goal: `TermLeSum {X : Type*} [NormedField X] [LinearOrder X] [IsStrictOrderedRing X] (a : ℕ → X) (N : ℕ) : ∀ n < N, |a n| ≤ ∑ k ∈ range N, |a k|`
- Definitions introduced/documented: `range`
- Theorem docs: `sum_range_succ` (`∑aₙ`), `sum_nonneg` (`∑aₙ`), `TermLeSum` (`∑aₙ`)
- Supporting theorems newly unlocked: `Finset.sum_range_succ`, `Finset.sum_nonneg`
- New tactic material: `contradiction`

#### Level 2: Bounded
- Source: `Game/Levels/L9Levels/L05_BddOfConv.lean`
- Goal: `Bdd_of_ConvNonzero (a : ℕ → ℝ) (L : ℝ) (ha : SeqLim a L) (hL : L ≠ 0) : SeqBdd a`
- Definitions introduced/documented: `SeqBdd`
- Theorem docs: `Bdd_of_ConvNonzero` (`aₙ`)

### Lecture 10: Algebraic Limit Theorem, Part V

#### Level 1: Big Boss : Product of Sequences
- Source: `Game/Levels/L10Levels/L06_Prod.lean`
- Goal: `ProdLimNeNe (a b c : ℕ → ℝ) (L M : ℝ) (hL : L ≠ 0) (hM : M ≠ 0) (ha : SeqLim a L) (hb : SeqLim b M) (hc : ∀ n, c n = a n * b n): SeqLim c (L * M)`
- Theorem docs: `ProdLimNeNe` (`aₙ`)

#### Level 2: Order Limit Theorem
- Source: `Game/Levels/L10Levels/L07_Order.lean`
- Goal: `OrderLimLe (a : ℕ → ℝ) (L : ℝ) (ha : SeqLim a L) (K : ℝ) (hK : SeqBddBy a K) : L ≤ K`
- Definitions introduced/documented: `SeqBddBy`
- Theorem docs: `OrderLimLe` (`aₙ`)

#### Level 3: Subsequences
- Source: `Game/Levels/L10Levels/L08_Mono.lean`
- Goal: `SubseqConv (a : ℕ → ℝ) (L : ℝ) (ha : SeqLim a L) (σ : ℕ → ℕ) (hσ : Subseq σ) : SeqLim (a ∘ σ) L`
- Definitions introduced/documented: `Subseq`
- Theorem docs: `SubseqConv` (`aₙ`)

#### Level 4: Subsequence Example
- Source: `Game/Levels/L10Levels/L09_Subseq.lean`
- Goal: `(a : ℕ → ℝ) (ha : ∀ n, a n = (-1) ^ n) : ∃ σ L, Subseq σ ∧ SeqLim (a ∘ σ) L`
- New tactic material: `«let»`

### Lecture 11: The Real Numbers I

#### Level 1: Big Boss : Limits are Cauchy
- Source: `Game/Levels/L11Levels/L01_IsCauchyOfLim.lean`
- Goal: `IsCauchy_of_SeqConv {a : ℕ → ℝ} (ha : SeqConv a) : IsCauchy a`
- Definitions introduced/documented: `IsCauchy`
- Theorem docs: `abs_sub_comm` (`|x|`), `IsCauchy_of_SeqConv` (`aₙ`)
- Supporting theorems newly unlocked: `abs_sub_comm`

#### Level 2: Level 2 : Sums of Cauchy sequences
- Source: `Game/Levels/L11Levels/L02_IsCauchyOfSum.lean`
- Goal: `IsCauchy_of_Sum {X : Type*} [NormedField X] [LinearOrder X] [IsStrictOrderedRing X] (a b : ℕ → X) (ha : IsCauchy a) (hb : IsCauchy b) : IsCauchy (a + b)`
- Theorem docs: `IsCauchy_of_Sum` (`aₙ`)

#### Level 3: Level 3 : Cauchy Implies Bounded
- Source: `Game/Levels/L11Levels/L03_IsBddOfCauchy.lean`
- Goal: `IsBdd_of_Cauchy {X : Type*} [NormedField X] [LinearOrder X] [IsStrictOrderedRing X] (a : ℕ → X) (ha : IsCauchy a) : SeqBdd a`
- Theorem docs: `IsBdd_of_Cauchy` (`aₙ`)

### Lecture 12: Cauchy Sequences II

#### Level 1: Iterated Subsequence
- Source: `Game/Levels/L12Levels/L00_SubseqIterate.lean`
- Goal: `Subseq_of_Iterate (σ : ℕ → ℕ) (hσ : ∀ n, n < σ n) (n₀ : ℕ) : Subseq (fun n ↦ σ^[n] n₀)`
- Theorem docs: `succ_iterate` (`aₙ`), `subseq_of_succ` (`aₙ`), `Subseq_of_Iterate` (`aₙ`)
- Supporting theorems newly unlocked: `subseq_of_succ`, `succ_iterate`

#### Level 2: Enhanced Choose
- Source: `Game/Levels/L12Levels/L01_Choose.lean`
- Goal: `(p : ℕ → Prop) (h : ∀ N, ∃ n > N, p n) : ∃ σ, Subseq σ ∧ ∀ n, p (σ n)`

#### Level 3: Monotone and Bounded Implies Cauchy
- Source: `Game/Levels/L12Levels/L01_MonotoneBdd.lean`
- Goal: `IsCauchy_of_MonotoneBdd {X : Type*} [NormedField X] [LinearOrder X] [IsStrictOrderedRing X] [FloorSemiring X] {a : ℕ → X} {M : X} (ha : Monotone a) (hM : ∀ n, a n ≤ M) : IsCauchy a`
- Definitions introduced/documented: `Monotone`
- Theorem docs: `Monotone_of_succ` (`aₙ`), `IterateGap` (`aₙ`), `IsCauchy_of_MonotoneBdd` (`aₙ`)
- Supporting theorems newly unlocked: `Monotone_of_succ`, `IterateGap`
- New tactic material: `push_neg`

#### Level 4: Iterated Gaps
- Source: `Game/Levels/L12Levels/L02_IterateGap.lean`
- Goal: `{X : Type*} [NormedField X] [LinearOrder X] [IsStrictOrderedRing X] (a : ℕ → X) (ha : Monotone a) (ε : X) (εpos : ε > 0) (τ : ℕ → ℕ) (hτ : ∀ n, τ n ≥ n) (σ : ℕ → ℕ) (hσ : ∀ n, σ n ≥ τ n) (hgap : ∀ n, ε ≤ |a (σ n) - a (τ n)|) : ∀ (k : ℕ), k * ε ≤ a (σ^[k] 0) - a 0`

### Lecture 13: Monotone Subsequence

#### Level 1: Monotone Subsequence
- Source: `Game/Levels/L13Levels/L03_MonotoneSubseq.lean`
- Goal: `MonotoneSubseq_of_BddPeaks {X : Type*} [NormedField X] [LinearOrder X] [IsStrictOrderedRing X] [FloorSemiring X] (a : ℕ → X) (ha : ¬ UnBddPeaks a) : ∃ σ, Subseq σ ∧ Monotone (a ∘ σ)`
- Definitions introduced/documented: `if then else`, `IsAPeak`, `UnBddPeaks`
- Theorem docs: `lt_of_not_ge` (`Theorems`), `MonotoneSubseq_of_BddPeaks` (`aₙ`)
- Supporting theorems newly unlocked: `lt_of_not_ge`

### Lecture 14: Bolzano-Weierstrass

#### Level 1: Bolzano-Weierstrass
- Source: `Game/Levels/L14Levels/L01_BolzanoWeierstrass.lean`
- Goal 1: `IsCauchy_of_AntitoneBdd {X : Type*} [NormedField X] [LinearOrder X] [IsStrictOrderedRing X] [FloorSemiring X] {a : ℕ → X} {M : X} (ha : Antitone a) (hM : ∀ n, M ≤ a n) : IsCauchy a`
- Goal 2: `BolzanoWeierstrass {X : Type*} [NormedField X] [LinearOrder X] [IsStrictOrderedRing X] [FloorSemiring X] (a : ℕ → X) (ha : SeqBdd a) : ∃ σ, Subseq σ ∧ IsCauchy (a ∘ σ)`
- Theorem docs: `abs_le` (`|x|`), `IsCauchy_of_AntitoneBdd` (`aₙ`), `AntitoneSubseq_of_UnBddPeaks` (`aₙ`), `BolzanoWeierstrass` (`aₙ`)
- Supporting theorems newly unlocked: `AntitoneSubseq_of_UnBddPeaks`, `IsCauchy_of_AntitoneBdd`, `abs_le`

### Lecture 15: The Real Numbers

#### Level 1: Completeness
- Source: `Game/Levels/L15Levels/L01_check.lean`
- Goal: `Reals_are_Complete (q : ℕ → ℕ → ℚ) (x : ℕ → ℝ) (hq : ∀ n, IsCauchy (q n)) (hx : ∀ n, x n = Real_of_CauSeq (hq n)) (hxCau : IsCauchy x) : ∃ (y : ℕ → ℚ) (hy : IsCauchy y), SeqLim x (Real_of_CauSeq hy)`
- Definitions introduced/documented: `Real_of_CauSeq`
- Theorem docs: `SeqLim_of_Real_of_Cau` (`aₙ`), `Reals_are_Complete` (`aₙ`)
- Supporting theorems newly unlocked: `SeqLim_of_Real_of_Cau`

### Lecture 16: Series

#### Level 1: Series
- Source: `Game/Levels/L16Levels/L01_check.lean`
- Goal: `LimZero_of_SeriesConv (a : ℕ → ℝ) (ha : SeriesConv a) : SeqLim a 0`
- Definitions introduced/documented: `Series`, `SeriesLim`, `SeriesConv`
- Theorem docs: `LimZero_of_SeriesConv` (`∑aₙ`)

### Lecture 17: Series II

#### Level 1: Leibniz Series
- Source: `Game/Levels/L17Levels/L01.lean`
- Goal: `LeibnizSeriesFinite {a : ℕ → ℝ} (ha : ∀ n, a n = 1 / ((n + 1) * (n + 2))) : ∀ n, ∑ k ∈ range n, a k = 1 - 1 / (n + 1)`
- Theorem docs: `LeibnizSeriesFinite` (`∑aₙ`)

#### Level 2: Leibniz Series
- Source: `Game/Levels/L17Levels/L02.lean`
- Goal: `LeibnizSeries (a : ℕ → ℝ) (ha : ∀ n, a n = 1 / ((n + 1) * (n + 2))) : SeriesConv a`
- Theorem docs: `LeibnizSeries` (`∑aₙ`)

#### Level 3: Series Order Theorem
- Source: `Game/Levels/L17Levels/L03.lean`
- Goal: `SeriesOrderThm {a b : ℕ → ℝ} (hab : ∀ n, a n ≤ b n) : ∀ n, Series a n ≤ Series b n`
- Theorem docs: `SeriesOrderThm` (`∑aₙ`)

#### Level 4: The Basel Problem
- Source: `Game/Levels/L17Levels/L04.lean`
- Goal: `(a : ℕ → ℝ) (ha : ∀ n, a n = 1 / ((n + 2) ^ 2)) : SeriesConv a`
- Theorem docs: `SeqConv_of_IsCauchy` (`aₙ`), `SeqConv_of_MonotoneBdd` (`aₙ`)
- Supporting theorems newly unlocked: `SeqConv_of_MonotoneBdd`, `SeqConv_of_IsCauchy`

### Lecture 18: Infinite Addition

#### Level 1: Absolute Convergence Implies Convergence
- Source: `Game/Levels/L18Levels/L01.lean`
- Goal: `Conv_of_AbsSeriesConv {a : ℕ → ℝ} (ha : AbsSeriesConv a) : SeriesConv a`
- Definitions introduced/documented: `AbsSeriesConv`
- Theorem docs: `DiffOfSeries` (`∑aₙ`), `Series_abs_add` (`∑aₙ`), `Conv_of_AbsSeriesConv` (`∑aₙ`)
- Supporting theorems newly unlocked: `DiffOfSeries`, `Series_abs_add`

#### Level 2: Alternating Series Test
- Source: `Game/Levels/L18Levels/L02.lean`
- Goal: `AlternatingSeriesTest {a : ℕ → ℝ} (ha : Antitone a) (aLim : SeqLim a 0) : SeriesConv (fun n ↦ (-1)^n * a n)`
- Theorem docs: `AntitoneLimitBound` (`aₙ`), `CoherenceOfReals` (`aₙ`), `SeqEvenOdd` (`aₙ`), `MonotoneSeriesEven` (`∑aₙ`), `AntitoneSeriesOdd` (`∑aₙ`), `BddSeriesEven` (`∑aₙ`), `BddSeriesOdd` (`∑aₙ`), `DiffGoesToZero` (`∑aₙ`), `AlternatingSeriesTest` (`∑aₙ`)
- Supporting theorems newly unlocked: `AntitoneLimitBound`, `CoherenceOfReals`, `SeqEvenOdd`, `MonotoneSeriesEven`, `AntitoneSeriesOdd`, `BddSeriesEven`, `BddSeriesOdd`, `DiffGoesToZero`

### Lecture 19: Rearrangements

#### Level 1: More Flexible Cauchy
- Source: `Game/Levels/L19Levels/L01.lean`
- Goal: `StrongCauchy_of_AbsSeriesConv {a : ℕ → ℝ} (ha : AbsSeriesConv a) {ε : ℝ} (hε : ε > 0) : ∃ N, ∀ (S : Finset ℕ), (∀ k ∈ S, k ≥ N) → ∑ k ∈ S, |a k| < ε`
- Theorem docs: `sum_le_sum_of_nonneg` (`∑aₙ`), `sum_le_mem_of_nonneg` (`∑aₙ`), `mem_Ico` (`x∈U`), `StrongCauchy_of_AbsSeriesConv` (`∑aₙ`)
- Supporting theorems newly unlocked: `sum_le_sum_of_nonneg`, `sum_le_mem_of_nonneg`, `Finset.mem_Ico`

#### Level 2: Rearrangements
- Source: `Game/Levels/L19Levels/L02.lean`
- Goal: `EventuallyCovers_of_Rearrangement {σ : ℕ → ℕ} (hσ : Rearrangement σ) (M : ℕ) : ∃ N, ∀ n ≥ N, (range M) ⊆ image σ (range n)`
- Definitions introduced/documented: `Injective`, `Surjective`, `Rearrangement`
- Theorem docs: `EventuallyCovers_of_Rearrangement` (`∑aₙ`)

#### Level 3: **Big Boss**: Rearrangement Theorem
- Source: `Game/Levels/L19Levels/L03.lean`
- Goal: `RearrangementThm {a : ℕ → ℝ} (ha : AbsSeriesConv a) : ∃ L, ∀ (σ : ℕ → ℕ) (_ : Rearrangement σ), SeriesLim (a ∘ σ) L`
- Theorem docs: `Series_image` (`∑aₙ`), `sum_sdiff` (`∑aₙ`), `abs_sum_le_sum_abs` (`∑aₙ`), `RearrangementThm` (`∑aₙ`)
- Supporting theorems newly unlocked: `Finset.sum_sdiff`, `Finset.abs_sum_le_sum_abs`, `Series_image`

#### Level 4: Conditional Convergence Theorem
- Source: `Game/Levels/L19Levels/L04.lean`
- Goal: `{a : ℕ → ℝ} (ha1 : SeriesConv a) (ha2 : ¬ AbsSeriesConv a) : ∀ L, ∃ (σ : ℕ → ℕ) (hσ : Rearrangement σ), SeriesLim (a ∘ σ) L`

### Lecture 20: Function Limits

#### Level 1: Limits of Functions
- Source: `Game/Levels/L20Levels/L01.lean`
- Goal: `∃ L, FunLimAt (fun x ↦ (x^2 - 1)/(x - 1)) L 1`
- Definitions introduced/documented: `FunLimAt`

#### Level 2: Continuous Functions
- Source: `Game/Levels/L20Levels/L02.lean`
- Goal: `FunContAt (fun x ↦ x^2 - 1) 2`
- Definitions introduced/documented: `FunContAt`

#### Level 3: Sum of Continuous Functions
- Source: `Game/Levels/L20Levels/L03.lean`
- Goal: `FunContAtAdd {f g : ℝ → ℝ} {c : ℝ} (hf : FunContAt f c) (hg : FunContAt g c) : FunContAt (fun x ↦ f x + g x) c`
- Theorem docs: `FunContAtAdd` (`f(x)`)

#### Level 4: Sequential Criterion for Limits (Forward Direction)
- Source: `Game/Levels/L20Levels/L04.lean`
- Goal: `SeqLim_of_FunLimAt {f : ℝ → ℝ} {L c : ℝ} (hf : FunLimAt f L c) : ∀ x : ℕ → ℝ, (∀ n, x n ≠ c) → SeqLim x c → SeqLim (fun n ↦ f (x n)) L`
- Theorem docs: `SeqLim_of_FunLimAt` (`f(x)`)

### Lecture 21: Function Limits II

#### Level 1: Sequential Criterion for Limits (Backward Direction)
- Source: `Game/Levels/L21Levels/L05.lean`
- Goal: `FunLim_of_SeqLim {f : ℝ → ℝ} {L c : ℝ} (h : ∀ x : ℕ → ℝ, (∀ n, x n ≠ c) → SeqLim x c → SeqLim (fun n ↦ f (x n)) L) : FunLimAt f L c`
- Theorem docs: `FunLim_of_SeqLim` (`f(x)`)

#### Level 2: Computing a Derivative
- Source: `Game/Levels/L21Levels/L06.lean`
- Goal: `FunDerivAt (fun x ↦ x^2 - 1) 4 2`
- Definitions introduced/documented: `FunDerivAt`

#### Level 3: The Derivative Function
- Source: `Game/Levels/L21Levels/L07.lean`
- Goal: `(f g : ℝ → ℝ) (hf : ∀ x, f x = x ^ 2 - 1) (hg : ∀ x, g x = 2 * x) : FunDeriv f g`
- Definitions introduced/documented: `FunDeriv`

#### Level 4: Continuity Everywhere
- Source: `Game/Levels/L21Levels/L08.lean`
- Goal: `FunCont (fun x ↦ x^2 - 1)`
- Definitions introduced/documented: `FunCont`

### Lecture 22: Uniformity

#### Level 1: Continuous Composition
- Source: `Game/Levels/L22Levels/L01.lean`
- Goal: `Cont_Comp (f g : ℝ → ℝ) (hf : FunCont f) (hg : FunCont g) : FunCont (f ∘ g)`
- Theorem docs: `Cont_Comp` (`f(x)`)

#### Level 2: Uniform Convergence
- Source: `Game/Levels/L22Levels/L02.lean`
- Goal: `Cont_of_UnifConv (f : ℕ → ℝ → ℝ) (hf : ∀ n, FunCont (f n)) (F : ℝ → ℝ) (hfF : UnifConv f F) : FunCont F`
- Definitions introduced/documented: `UnifConv`
- Theorem docs: `Cont_of_UnifConv` (`f(x)`)

#### Level 3: Integration
- Source: `Game/Levels/L22Levels/L03.lean`
- Goal: `{a b : ℝ} (hab : a < b) : IntegrableOn (fun x ↦ x) a b`
- Definitions introduced/documented: `RiemannSum`, `HasIntegral`, `IntegrableOn`
- Theorem docs: `sum_add_distrib` (`∑aₙ`), `sum_const` (`∑aₙ`), `card_range` (`∑aₙ`), `sum_div` (`∑aₙ`), `sum_mul` (`∑aₙ`), `sum_range_add_one` (`∑aₙ`)
- Supporting theorems newly unlocked: `Finset.sum_add_distrib`, `Finset.sum_const`, `Finset.card_range`, `Finset.sum_div`

### Lecture 23: Uniformity II: Continuity

#### Level 1: Riemann Sum Refinement
- Source: `Game/Levels/L23Levels/L01.lean`
- Goal: `RiemannSumRefinement (f : ℝ → ℝ) {a b : ℝ} (hab : a < b) {n k : ℕ} (hn : n ≠ 0) (hk : k ≠ 0) {ε δ : ℝ} (hε : ε > 0) (hδ : δ > 0) (hunif : ∀ x ∈ Icc a b, ∀ y ∈ Icc a b, |y - x| < δ → |f y - f x| < ε) (hfine : 2 * (b - a) / n < δ) : |RiemannSum f a b (n * k) - RiemannSum f a b n| < (b - a) * ε`
- Theorem docs: `sum_of_prod` (`∑aₙ`), `RiemannSumRefinement` (`∫f`)
- Supporting theorems newly unlocked: `sum_of_prod`

#### Level 2: Integration Converges!
- Source: `Game/Levels/L23Levels/L02.lean`
- Goal: `HasIntegral_of_UnifContOn (f : ℝ → ℝ) (a b : ℝ) (hab : a < b) (hf : UnifContOn f (Icc a b)) : IntegrableOn f a b`
- Definitions introduced/documented: `UnifContOn`
- Theorem docs: `HasIntegral_of_UnifContOn` (`∫f`)

#### Level 3: Compactness
- Source: `Game/Levels/L23Levels/L03.lean`
- Goal: `UnifContOn_of_Compact (f : ℝ → ℝ) (hf : FunCont f) (S : Set ℝ) (hS : IsCompact S) : UnifContOn f S`
- Definitions introduced/documented: `Ball`, `IsCompact`, `Type`
- Theorem docs: `mem_Union` (`x∈U`), `FinMinPos` (`Theorems`), `UnifContOn_of_Compact` (`f(x)`)
- Supporting theorems newly unlocked: `RealAnalysisGame.FinMinPos`, `RealAnalysisGame.mem_Union`

### Lecture 24: Topology

#### Level 1: Heine-Borel Theorem: Part 1a
- Source: `Game/Levels/L24Levels/L01.lean`
- Goal: `Bdd_of_Compact (S : Set ℝ) (hcomp : IsCompact S) : ∃ M, ∀ s ∈ S, |s| < M`
- Theorem docs: `FinMax` (`Theorems`), `Bdd_of_Compact` (`x∈U`)
- Supporting theorems newly unlocked: `RealAnalysisGame.FinMax`

#### Level 2: Heine-Borel Theorem: Part 1b
- Source: `Game/Levels/L24Levels/L02.lean`
- Goal: `IsClosed_of_Compact (S : Set ℝ) (hcomp : IsCompact S) : IsClosed S`
- Definitions introduced/documented: `IsOpen`, `IsClosed`
- Theorem docs: `IsClosed_of_Compact` (`x∈U`)

#### Level 3: Least Upper Bound Property
- Source: `Game/Levels/L24Levels/L03.lean`
- Goal: `HasLUB_of_BddNonempty {S : Set ℝ} (hS : S.Nonempty) {M : ℝ} (hM : IsUB S M) : ∃ L, IsLUB S L`
- Definitions introduced/documented: `IsUB`, `IsLUB`
- Theorem docs: `HasLUB_of_BddNonempty` (`x∈U`)

#### Level 4: Heine-Borel Theorem: Part 2a
- Source: `Game/Levels/L24Levels/L04.lean`
- Goal: `IsCompact_of_ClosedInterval {a b : ℝ} (hab : a < b) : IsCompact (Icc a b)`
- Theorem docs: `IsCompact_of_ClosedInterval` (`x∈U`)

#### Level 5: Heine-Borel Theorem: Part 2b
- Source: `Game/Levels/L24Levels/L05.lean`
- Goal: `IsCompact_of_ClosedSubset {S T : Set ℝ} (hST : S ⊆ T) (hT : IsCompact T) (hS : IsClosed S) : IsCompact S`
- Definitions introduced/documented: `Finset.lefts`
- Theorem docs: `mem_lefts` (`x∈U`), `IsCompact_of_ClosedSubset` (`x∈U`)
- Supporting theorems newly unlocked: `mem_lefts`

### Lecture 25: Swapping Limits and Integrals

#### Level 1: Uniform Convergence Implies Integrability
- Source: `Game/Levels/L25Levels/L01.lean`
- Goal: `Integrable_of_UnifConv {f : ℕ → ℝ → ℝ} {F : ℝ → ℝ} {a b : ℝ} (hab : a < b) {ℓ : ℕ → ℝ} (hfint : ∀ n, HasIntegral (f n) a b (ℓ n)) (hfF : UnifConv f F) : ∃ (L : ℝ), SeqLim ℓ L ∧ HasIntegral F a b L`
- Theorem docs: `Integrable_of_UnifConv` (`∫f`)

#### Level 2: Intermediate Value Theorem
- Source: `Game/Levels/L25Levels/L02.lean`
- Goal: `IVT {f : ℝ → ℝ} (hf : FunCont f) {a b : ℝ} (hab : a < b) (hfa : f a < 0) (hfb : 0 < f b): ∃ c ∈ Ioo a b, f c = 0`
- Theorem docs: `IVT` (`f(x)`)

## Theorem Inventory

### `Theorems`
- `ArchProp` - Lecture 3.1, Archimedean Property (`Game/Levels/L3Levels/L01_ArchProp.lean`)
- `IdLeTwoPow` - Lecture 8.1, NotEven (`Game/Levels/L8Levels/L03_Induction'.lean`)
- `ge_one_of_nonzero` - Lecture 8.1, NotEven (`Game/Levels/L8Levels/L03_Induction'.lean`)
- `lt_of_not_ge` - Lecture 13.1, Monotone Subsequence (`Game/Levels/L13Levels/L03_MonotoneSubseq.lean`)
- `FinMinPos` - Lecture 23.3, Compactness (`Game/Levels/L23Levels/L03.lean`)
- `FinMax` - Lecture 24.1, Heine-Borel Theorem: Part 1a (`Game/Levels/L24Levels/L01.lean`)

### `aₙ`
- `ConstLim` - Lecture 2.1, The Convergence of a Sequence (`Game/Levels/L2NewtonsCalculationOfPi/L01_SeqConvDef.lean`)
- `OneOverNLimZero` - Lecture 3.2, First Real Limit (`Game/Levels/L3Levels/L02_OneOverN.lean`)
- `SumLim` - Lecture 6.1, Big Boss: The Sum of Convergent Sequences (`Game/Levels/L6Levels/L00_SumOfSeqs.lean`)
- `SqueezeThm` - Lecture 6.7, Big Boss : Squeeze Theorem (`Game/Levels/L6Levels/L06_Squeeze.lean`)
- `LimUnique` - Lecture 7.1, Uniqueness of Limits (`Game/Levels/L7Levels/L00_Uniqueness.lean`)
- `EventuallyGeHalfLimPos` - Lecture 7.2, Eventually (`Game/Levels/L7Levels/L01_Eventually.lean`)
- `AbsLim` - Lecture 7.3, Sequences of Absolute Values (`Game/Levels/L7Levels/L02_SeqOfAbs.lean`)
- `InvLim` - Lecture 7.4, SeqInvLim (`Game/Levels/L7Levels/L03_SeqInvLim.lean`)
- `EventuallyGeHalfLim` - Lecture 7.5, ByCases (`Game/Levels/L7Levels/L04_ByCases.lean`)
- `Bdd_of_ConvNonzero` - Lecture 9.2, Bounded (`Game/Levels/L9Levels/L05_BddOfConv.lean`)
- `ProdLimNeNe` - Lecture 10.1, Big Boss : Product of Sequences (`Game/Levels/L10Levels/L06_Prod.lean`)
- `OrderLimLe` - Lecture 10.2, Order Limit Theorem (`Game/Levels/L10Levels/L07_Order.lean`)
- `SubseqConv` - Lecture 10.3, Subsequences (`Game/Levels/L10Levels/L08_Mono.lean`)
- `IsCauchy_of_SeqConv` - Lecture 11.1, Big Boss : Limits are Cauchy (`Game/Levels/L11Levels/L01_IsCauchyOfLim.lean`)
- `IsCauchy_of_Sum` - Lecture 11.2, Level 2 : Sums of Cauchy sequences (`Game/Levels/L11Levels/L02_IsCauchyOfSum.lean`)
- `IsBdd_of_Cauchy` - Lecture 11.3, Level 3 : Cauchy Implies Bounded (`Game/Levels/L11Levels/L03_IsBddOfCauchy.lean`)
- `Subseq_of_Iterate` - Lecture 12.1, Iterated Subsequence (`Game/Levels/L12Levels/L00_SubseqIterate.lean`)
- `subseq_of_succ` - Lecture 12.1, Iterated Subsequence (`Game/Levels/L12Levels/L00_SubseqIterate.lean`)
- `succ_iterate` - Lecture 12.1, Iterated Subsequence (`Game/Levels/L12Levels/L00_SubseqIterate.lean`)
- `IsCauchy_of_MonotoneBdd` - Lecture 12.3, Monotone and Bounded Implies Cauchy (`Game/Levels/L12Levels/L01_MonotoneBdd.lean`)
- `IterateGap` - Lecture 12.3, Monotone and Bounded Implies Cauchy (`Game/Levels/L12Levels/L01_MonotoneBdd.lean`)
- `Monotone_of_succ` - Lecture 12.3, Monotone and Bounded Implies Cauchy (`Game/Levels/L12Levels/L01_MonotoneBdd.lean`)
- `MonotoneSubseq_of_BddPeaks` - Lecture 13.1, Monotone Subsequence (`Game/Levels/L13Levels/L03_MonotoneSubseq.lean`)
- `AntitoneSubseq_of_UnBddPeaks` - Lecture 14.1, Bolzano-Weierstrass (`Game/Levels/L14Levels/L01_BolzanoWeierstrass.lean`)
- `BolzanoWeierstrass` - Lecture 14.1, Bolzano-Weierstrass (`Game/Levels/L14Levels/L01_BolzanoWeierstrass.lean`)
- `IsCauchy_of_AntitoneBdd` - Lecture 14.1, Bolzano-Weierstrass (`Game/Levels/L14Levels/L01_BolzanoWeierstrass.lean`)
- `Reals_are_Complete` - Lecture 15.1, Completeness (`Game/Levels/L15Levels/L01_check.lean`)
- `SeqLim_of_Real_of_Cau` - Lecture 15.1, Completeness (`Game/Levels/L15Levels/L01_check.lean`)
- `SeqConv_of_IsCauchy` - Lecture 17.4, The Basel Problem (`Game/Levels/L17Levels/L04.lean`)
- `SeqConv_of_MonotoneBdd` - Lecture 17.4, The Basel Problem (`Game/Levels/L17Levels/L04.lean`)
- `AntitoneLimitBound` - Lecture 18.2, Alternating Series Test (`Game/Levels/L18Levels/L02.lean`)
- `CoherenceOfReals` - Lecture 18.2, Alternating Series Test (`Game/Levels/L18Levels/L02.lean`)
- `SeqEvenOdd` - Lecture 18.2, Alternating Series Test (`Game/Levels/L18Levels/L02.lean`)

### `|x|`
- `abs_add` - Lecture 4.1, NonConvergence (`Game/Levels/L4Levels/L01_NonConverge.lean`)
- `abs_neg` - Lecture 4.1, NonConvergence (`Game/Levels/L4Levels/L01_NonConverge.lean`)
- `abs_mul` - Lecture 5.1, Doubling a Convergent Sequence (`Game/Levels/L5Levels/L01_DoubleSeqConv.lean`)
- `abs_lt` - Lecture 6.6, AbsLe (`Game/Levels/L6Levels/L05_AbsLt.lean`)
- `abs_pos_of_nonzero` - Lecture 7.1, Uniqueness of Limits (`Game/Levels/L7Levels/L00_Uniqueness.lean`)
- `abs_Lipschitz` - Lecture 7.3, Sequences of Absolute Values (`Game/Levels/L7Levels/L02_SeqOfAbs.lean`)
- `abs_div` - Lecture 7.4, SeqInvLim (`Game/Levels/L7Levels/L03_SeqInvLim.lean`)
- `nonzero_of_abs_pos` - Lecture 7.4, SeqInvLim (`Game/Levels/L7Levels/L03_SeqInvLim.lean`)
- `abs_sub_comm` - Lecture 11.1, Big Boss : Limits are Cauchy (`Game/Levels/L11Levels/L01_IsCauchyOfLim.lean`)
- `abs_le` - Lecture 14.1, Bolzano-Weierstrass (`Game/Levels/L14Levels/L01_BolzanoWeierstrass.lean`)

### `∑aₙ`
- `TermLeSum` - Lecture 9.1, Finite Sums (`Game/Levels/L9Levels/L04_FiniteSums.lean`)
- `sum_nonneg` - Lecture 9.1, Finite Sums (`Game/Levels/L9Levels/L04_FiniteSums.lean`)
- `sum_range_succ` - Lecture 9.1, Finite Sums (`Game/Levels/L9Levels/L04_FiniteSums.lean`)
- `LimZero_of_SeriesConv` - Lecture 16.1, Series (`Game/Levels/L16Levels/L01_check.lean`)
- `LeibnizSeriesFinite` - Lecture 17.1, Leibniz Series (`Game/Levels/L17Levels/L01.lean`)
- `LeibnizSeries` - Lecture 17.2, Leibniz Series (`Game/Levels/L17Levels/L02.lean`)
- `SeriesOrderThm` - Lecture 17.3, Series Order Theorem (`Game/Levels/L17Levels/L03.lean`)
- `Conv_of_AbsSeriesConv` - Lecture 18.1, Absolute Convergence Implies Convergence (`Game/Levels/L18Levels/L01.lean`)
- `DiffOfSeries` - Lecture 18.1, Absolute Convergence Implies Convergence (`Game/Levels/L18Levels/L01.lean`)
- `Series_abs_add` - Lecture 18.1, Absolute Convergence Implies Convergence (`Game/Levels/L18Levels/L01.lean`)
- `AlternatingSeriesTest` - Lecture 18.2, Alternating Series Test (`Game/Levels/L18Levels/L02.lean`)
- `AntitoneSeriesOdd` - Lecture 18.2, Alternating Series Test (`Game/Levels/L18Levels/L02.lean`)
- `BddSeriesEven` - Lecture 18.2, Alternating Series Test (`Game/Levels/L18Levels/L02.lean`)
- `BddSeriesOdd` - Lecture 18.2, Alternating Series Test (`Game/Levels/L18Levels/L02.lean`)
- `DiffGoesToZero` - Lecture 18.2, Alternating Series Test (`Game/Levels/L18Levels/L02.lean`)
- `MonotoneSeriesEven` - Lecture 18.2, Alternating Series Test (`Game/Levels/L18Levels/L02.lean`)
- `StrongCauchy_of_AbsSeriesConv` - Lecture 19.1, More Flexible Cauchy (`Game/Levels/L19Levels/L01.lean`)
- `sum_le_mem_of_nonneg` - Lecture 19.1, More Flexible Cauchy (`Game/Levels/L19Levels/L01.lean`)
- `sum_le_sum_of_nonneg` - Lecture 19.1, More Flexible Cauchy (`Game/Levels/L19Levels/L01.lean`)
- `EventuallyCovers_of_Rearrangement` - Lecture 19.2, Rearrangements (`Game/Levels/L19Levels/L02.lean`)
- `RearrangementThm` - Lecture 19.3, **Big Boss**: Rearrangement Theorem (`Game/Levels/L19Levels/L03.lean`)
- `Series_image` - Lecture 19.3, **Big Boss**: Rearrangement Theorem (`Game/Levels/L19Levels/L03.lean`)
- `abs_sum_le_sum_abs` - Lecture 19.3, **Big Boss**: Rearrangement Theorem (`Game/Levels/L19Levels/L03.lean`)
- `sum_sdiff` - Lecture 19.3, **Big Boss**: Rearrangement Theorem (`Game/Levels/L19Levels/L03.lean`)
- `card_range` - Lecture 22.3, Integration (`Game/Levels/L22Levels/L03.lean`)
- `sum_add_distrib` - Lecture 22.3, Integration (`Game/Levels/L22Levels/L03.lean`)
- `sum_const` - Lecture 22.3, Integration (`Game/Levels/L22Levels/L03.lean`)
- `sum_div` - Lecture 22.3, Integration (`Game/Levels/L22Levels/L03.lean`)
- `sum_mul` - Lecture 22.3, Integration (`Game/Levels/L22Levels/L03.lean`)
- `sum_range_add_one` - Lecture 22.3, Integration (`Game/Levels/L22Levels/L03.lean`)
- `sum_of_prod` - Lecture 23.1, Riemann Sum Refinement (`Game/Levels/L23Levels/L01.lean`)

### `f(x)`
- `FunContAtAdd` - Lecture 20.3, Sum of Continuous Functions (`Game/Levels/L20Levels/L03.lean`)
- `SeqLim_of_FunLimAt` - Lecture 20.4, Sequential Criterion for Limits (Forward Direction) (`Game/Levels/L20Levels/L04.lean`)
- `FunLim_of_SeqLim` - Lecture 21.1, Sequential Criterion for Limits (Backward Direction) (`Game/Levels/L21Levels/L05.lean`)
- `Cont_Comp` - Lecture 22.1, Continuous Composition (`Game/Levels/L22Levels/L01.lean`)
- `Cont_of_UnifConv` - Lecture 22.2, Uniform Convergence (`Game/Levels/L22Levels/L02.lean`)
- `UnifContOn_of_Compact` - Lecture 23.3, Compactness (`Game/Levels/L23Levels/L03.lean`)
- `IVT` - Lecture 25.2, Intermediate Value Theorem (`Game/Levels/L25Levels/L02.lean`)

### `x∈U`
- `mem_Ico` - Lecture 19.1, More Flexible Cauchy (`Game/Levels/L19Levels/L01.lean`)
- `mem_Union` - Lecture 23.3, Compactness (`Game/Levels/L23Levels/L03.lean`)
- `Bdd_of_Compact` - Lecture 24.1, Heine-Borel Theorem: Part 1a (`Game/Levels/L24Levels/L01.lean`)
- `IsClosed_of_Compact` - Lecture 24.2, Heine-Borel Theorem: Part 1b (`Game/Levels/L24Levels/L02.lean`)
- `HasLUB_of_BddNonempty` - Lecture 24.3, Least Upper Bound Property (`Game/Levels/L24Levels/L03.lean`)
- `IsCompact_of_ClosedInterval` - Lecture 24.4, Heine-Borel Theorem: Part 2a (`Game/Levels/L24Levels/L04.lean`)
- `IsCompact_of_ClosedSubset` - Lecture 24.5, Heine-Borel Theorem: Part 2b (`Game/Levels/L24Levels/L05.lean`)
- `mem_lefts` - Lecture 24.5, Heine-Borel Theorem: Part 2b (`Game/Levels/L24Levels/L05.lean`)

### `∫f`
- `RiemannSumRefinement` - Lecture 23.1, Riemann Sum Refinement (`Game/Levels/L23Levels/L01.lean`)
- `HasIntegral_of_UnifContOn` - Lecture 23.2, Integration Converges! (`Game/Levels/L23Levels/L02.lean`)
- `Integrable_of_UnifConv` - Lecture 25.1, Uniform Convergence Implies Integrability (`Game/Levels/L25Levels/L01.lean`)

## Novel Tactic Inventory

The game introduces tactics in a few recurring proof-workflow families:

### Direct proof and rewriting
- `apply` - first introduced in Lecture 1.1, Introduction to Lean (`Game/Levels/L1RealAnalysisStory/L00_the_problem.lean`)
- `rfl` - first introduced in Lecture 1.2, The rfl tactic (`Game/Levels/L1RealAnalysisStory/L02_rfl.lean`)
- `rewrite` - first introduced in Lecture 1.3, The `rewrite` tactic (`Game/Levels/L1RealAnalysisStory/L03_rw.lean`)
- `ring_nf` - first introduced in Lecture 1.4, The ring_nf tactic (`Game/Levels/L1RealAnalysisStory/L04_ring_nf.lean`)

### Quantifiers and witnesses
- `intro` - first introduced in Lecture 1.6, The intro tactic (`Game/Levels/L1RealAnalysisStory/L06_intro.lean`)
- `use` - first introduced in Lecture 1.5, The use tactic (`Game/Levels/L1RealAnalysisStory/L05_use.lean`)
- `specialize` - first introduced in Lecture 1.7, The specialize tactic (`Game/Levels/L1RealAnalysisStory/L07_specialize.lean`)
- `choose` - first introduced in Lecture 1.8, The choose tactic (`Game/Levels/L1RealAnalysisStory/L08_choose.lean`)

### Arithmetic and coercions
- `norm_num` - first introduced in Lecture 2.1, The Convergence of a Sequence (`Game/Levels/L2NewtonsCalculationOfPi/L01_SeqConvDef.lean`)
- `push_cast` - first introduced in Lecture 3.1, Archimedean Property (`Game/Levels/L3Levels/L01_ArchProp.lean`)
- `bound` - first introduced in Lecture 3.1, Archimedean Property (`Game/Levels/L3Levels/L01_ArchProp.lean`)
- `linarith` - first introduced in Lecture 3.2, First Real Limit (`Game/Levels/L3Levels/L02_OneOverN.lean`)
- `field_simp` - first introduced in Lecture 3.2, First Real Limit (`Game/Levels/L3Levels/L02_OneOverN.lean`)
- `exact_mod_cast` - first introduced in Lecture 3.2, First Real Limit (`Game/Levels/L3Levels/L02_OneOverN.lean`)

### Logical decomposition and cases
- `split_ands` - first introduced in Lecture 6.2, Split Ands (`Game/Levels/L6Levels/L01_SplitAnds.lean`)
- `left` - first introduced in Lecture 6.3, Left and Right (`Game/Levels/L6Levels/L02_LeftRight.lean`)
- `right` - first introduced in Lecture 6.3, Left and Right (`Game/Levels/L6Levels/L02_LeftRight.lean`)
- `cases'` - first introduced in Lecture 6.5, Cases' (`Game/Levels/L6Levels/L04_Cases'.lean`)
- `by_cases` - first introduced in Lecture 7.5, ByCases (`Game/Levels/L7Levels/L04_ByCases.lean`)
- `by_contra` - first introduced in Lecture 7.1, Uniqueness of Limits (`Game/Levels/L7Levels/L00_Uniqueness.lean`)
- `contradiction` - first introduced in Lecture 9.1, Finite Sums (`Game/Levels/L9Levels/L04_FiniteSums.lean`)

### Induction and local construction
- `induction'` - first introduced in Lecture 8.1, NotEven (`Game/Levels/L8Levels/L03_Induction'.lean`)
- `«let»` - first introduced in Lecture 10.4, Subsequence Example (`Game/Levels/L10Levels/L09_Subseq.lean`)

### Negation management
- `push_neg` - first introduced in Lecture 12.3, Monotone and Bounded Implies Cauchy (`Game/Levels/L12Levels/L01_MonotoneBdd.lean`)

### Goal shaping
- `change` - first introduced in Lecture 2.1, The Convergence of a Sequence (`Game/Levels/L2NewtonsCalculationOfPi/L01_SeqConvDef.lean`)

## Definition Inventory

- `SeqLim` - Lecture 2.1, The Convergence of a Sequence (`Game/Levels/L2NewtonsCalculationOfPi/L01_SeqConvDef.lean`)
- `SeqConv` - Lecture 4.1, NonConvergence (`Game/Levels/L4Levels/L01_NonConverge.lean`)
- `range` - Lecture 9.1, Finite Sums (`Game/Levels/L9Levels/L04_FiniteSums.lean`)
- `SeqBdd` - Lecture 9.2, Bounded (`Game/Levels/L9Levels/L05_BddOfConv.lean`)
- `SeqBddBy` - Lecture 10.2, Order Limit Theorem (`Game/Levels/L10Levels/L07_Order.lean`)
- `Subseq` - Lecture 10.3, Subsequences (`Game/Levels/L10Levels/L08_Mono.lean`)
- `IsCauchy` - Lecture 11.1, Big Boss : Limits are Cauchy (`Game/Levels/L11Levels/L01_IsCauchyOfLim.lean`)
- `Monotone` - Lecture 12.3, Monotone and Bounded Implies Cauchy (`Game/Levels/L12Levels/L01_MonotoneBdd.lean`)
- `IsAPeak` - Lecture 13.1, Monotone Subsequence (`Game/Levels/L13Levels/L03_MonotoneSubseq.lean`)
- `UnBddPeaks` - Lecture 13.1, Monotone Subsequence (`Game/Levels/L13Levels/L03_MonotoneSubseq.lean`)
- `if then else` - Lecture 13.1, Monotone Subsequence (`Game/Levels/L13Levels/L03_MonotoneSubseq.lean`)
- `Real_of_CauSeq` - Lecture 15.1, Completeness (`Game/Levels/L15Levels/L01_check.lean`)
- `Series` - Lecture 16.1, Series (`Game/Levels/L16Levels/L01_check.lean`)
- `SeriesConv` - Lecture 16.1, Series (`Game/Levels/L16Levels/L01_check.lean`)
- `SeriesLim` - Lecture 16.1, Series (`Game/Levels/L16Levels/L01_check.lean`)
- `AbsSeriesConv` - Lecture 18.1, Absolute Convergence Implies Convergence (`Game/Levels/L18Levels/L01.lean`)
- `Injective` - Lecture 19.2, Rearrangements (`Game/Levels/L19Levels/L02.lean`)
- `Rearrangement` - Lecture 19.2, Rearrangements (`Game/Levels/L19Levels/L02.lean`)
- `Surjective` - Lecture 19.2, Rearrangements (`Game/Levels/L19Levels/L02.lean`)
- `FunLimAt` - Lecture 20.1, Limits of Functions (`Game/Levels/L20Levels/L01.lean`)
- `FunContAt` - Lecture 20.2, Continuous Functions (`Game/Levels/L20Levels/L02.lean`)
- `FunDerivAt` - Lecture 21.2, Computing a Derivative (`Game/Levels/L21Levels/L06.lean`)
- `FunDeriv` - Lecture 21.3, The Derivative Function (`Game/Levels/L21Levels/L07.lean`)
- `FunCont` - Lecture 21.4, Continuity Everywhere (`Game/Levels/L21Levels/L08.lean`)
- `UnifConv` - Lecture 22.2, Uniform Convergence (`Game/Levels/L22Levels/L02.lean`)
- `HasIntegral` - Lecture 22.3, Integration (`Game/Levels/L22Levels/L03.lean`)
- `IntegrableOn` - Lecture 22.3, Integration (`Game/Levels/L22Levels/L03.lean`)
- `RiemannSum` - Lecture 22.3, Integration (`Game/Levels/L22Levels/L03.lean`)
- `UnifContOn` - Lecture 23.2, Integration Converges! (`Game/Levels/L23Levels/L02.lean`)
- `Ball` - Lecture 23.3, Compactness (`Game/Levels/L23Levels/L03.lean`)
- `IsCompact` - Lecture 23.3, Compactness (`Game/Levels/L23Levels/L03.lean`)
- `Type` - Lecture 23.3, Compactness (`Game/Levels/L23Levels/L03.lean`)
- `IsClosed` - Lecture 24.2, Heine-Borel Theorem: Part 1b (`Game/Levels/L24Levels/L02.lean`)
- `IsOpen` - Lecture 24.2, Heine-Borel Theorem: Part 1b (`Game/Levels/L24Levels/L02.lean`)
- `IsLUB` - Lecture 24.3, Least Upper Bound Property (`Game/Levels/L24Levels/L03.lean`)
- `IsUB` - Lecture 24.3, Least Upper Bound Property (`Game/Levels/L24Levels/L03.lean`)
- `Finset.lefts` - Lecture 24.5, Heine-Borel Theorem: Part 2b (`Game/Levels/L24Levels/L05.lean`)
