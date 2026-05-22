# Game Redesign Proposal

This is a topic-first redesign of the current lecture levels. The goal is to
replace classroom-date worlds with mathematical worlds: each world should teach
one coherent cluster of ideas, and, when possible, end with a satisfying
`Big Boss` theorem.

The proposal keeps the existing levels in roughly their current mathematical
order, but it moves proof-tool levels to where they support the story and
splits long lecture runs into better subtopics.

## Design Principles

- A world should have a mathematical identity, not a lecture number.
- A world should usually end with a boss theorem. If the current material does
  not yet have a good endpoint, this file marks the missing boss explicitly.
- Earlier worlds should unlock concepts that are genuinely used later.
- Tactic tutorials should be front-loaded only when they are general proof
  grammar; specialized tactics can appear inside the world that needs them.
- Problem-set levels are not included here, but many would make good optional
  side quests attached to these worlds.

## Proposed Dependency Graph

```mermaid **I'm not sure what Mermaid is? Can you just lay out the dependency graph in ascii?**
graph TD
  Tutorial[Proof Tutorial]
  SeqIntro[Intro to Sequences]
  AbsSqueeze[Absolute Values and Squeeze]
  AlgLimits[Algebraic Limit Theorems]
  Cauchy[Cauchy Sequences]
  Subsequences[Subsequences]
  Bolzano[Bolzano-Weierstrass]
  Reals[The Real Numbers]
  SeriesIntro[Intro to Series]
  AbsAltSeries[Absolute and Alternating Series]
  Rearrangement[Riemann Rearrangement]
  Conditional[Conditional Convergence]
  FunLimits[Function Limits and Continuity]
  Derivatives[Derivatives]
  Uniformity[Uniformity]
  RiemannSums[Riemann Sums and Integration]
  Topology[Topology and Compactness]
  HeineBorel[Heine-Borel]
  Calculus[Calculus Capstone]
  Taylor[Taylor Series]
  Fourier[Fourier Series]

  Tutorial --> SeqIntro
  SeqIntro --> AbsSqueeze
  AbsSqueeze --> AlgLimits
  AlgLimits --> Cauchy
  AlgLimits --> Subsequences
  Cauchy --> Subsequences
  Subsequences --> Bolzano
  Cauchy --> Reals
  Bolzano --> Reals
  Reals --> SeriesIntro
  SeriesIntro --> AbsAltSeries
  AbsAltSeries --> Rearrangement
  Rearrangement --> Conditional
  Reals --> FunLimits
  FunLimits --> Derivatives
  FunLimits --> Uniformity
  Uniformity --> RiemannSums
  FunLimits --> RiemannSums
  Reals --> Topology
  Topology --> HeineBorel
  HeineBorel --> Uniformity
  HeineBorel --> RiemannSums
  Derivatives --> Calculus
  RiemannSums --> Calculus
  SeriesIntro --> Taylor
  Derivatives --> Taylor
  Taylor -. optional .-> Fourier
  Uniformity -. optional .-> Fourier
```

## World Plan

### 1. Proof Tutorial

Purpose: give the player basic Lean grammar before analysis starts.

Current levels to include: **We're going to change how we implement the tutorial, but this is fine for now**

- `Introduction to Lean`: `apply`
- `The rfl tactic`: `rfl`
- `The rewrite tactic`: `rewrite`
- `The ring_nf tactic`: `ring_nf`
- `The use tactic`: `use`
- `The intro tactic`: `intro`
- `The specialize tactic`: `specialize`
- `The choose tactic`: `choose`
- Optional early insertions from later lectures: `change`, `norm_num`, `split_ands`

Boss: `Big Boss: The Ultimate Tactic Challenge`.

Notes: I would keep `choose` here, even though it becomes truly important for
subsequences later. The player should already know that existential data can be
unpacked before the Cauchy/subsequence worlds start leaning on it heavily. **Yes, the other use of `choose` will be introduced in due course**

### 2. Intro to Sequences

Purpose: introduce epsilon definitions, basic examples, nonconvergence, and
the first algebraic limit theorem.

Current levels to include:

- `The Convergence of a Sequence`: `SeqLim`, `ConstLim`
- `Archimedean Property`: `ArchProp`, `push_cast`, `bound` **This will no longer be a theorem we prove; we'll quote it for now and later come back to prove it, once we've constructed the Real Numbers**
- `First Real Limit`: `OneOverNLimZero`, `linarith`, `field_simp`,
  `exact_mod_cast`
- `NonConvergence`: `SeqConv`, `(-1)^n` does not converge
- `Doubling a Convergent Sequence`: scalar multiplication by `2`
- `Split Ands`: conjunction goals, if not moved into Tutorial
- `Big Boss: The Sum of Convergent Sequences`: `SumLim`

Boss: `SumLim`.

Notes: this world should be the first place where epsilon bookkeeping feels
like a reusable pattern rather than a one-off computation.

### 3. Absolute Values and Squeeze

Purpose: teach the logic and inequalities needed to turn absolute-value
closeness into ordinary order estimates.

Current levels to include:

- `Left and Right`: disjunction goals
- `Dot Notation`: extracting hypotheses from conjunctions
- `Cases'`: case splitting on disjunctions
- `AbsLe`: `abs_lt`
- `Big Boss: Squeeze Theorem`: `SqueezeThm`

Boss: `SqueezeThm`.

Notes: this is a better home for `left`, `right`, dot notation, and `cases'`
than the algebraic-limit lecture wrapper, because these proof moves are exactly
what make squeeze arguments readable.

### 4. Algebraic Limit Theorems

Purpose: finish the standard algebra of convergent sequences and order
properties of limits.

Current levels to include:

- `Uniqueness of Limits`: `LimUnique`, `by_contra`
- `Eventually`: `EventuallyGeHalfLimPos`
- `Sequences of Absolute Values`: `AbsLim`, `abs_Lipschitz`
- `SeqInvLim`: reciprocal limits
- `ByCases`: `EventuallyGeHalfLim`, `by_cases`
- `Bounded`: `SeqBdd`, `Bdd_of_ConvNonzero`
- `Product of Sequences`: `ProdLimNeNe`
- `Order Limit Theorem`: `SeqBddBy`, `OrderLimLe`

Current boss: `ProdLimNeNe`.

Better future boss: a full algebraic limit theorem package, for example:

- `ProdLim`: product without nonzero hypotheses
- `QuotLim`: quotient limit
- `AlgLimitThm`: a bundled theorem that exposes sum, scalar, product, and
  quotient behavior from one world endpoint

Notes: `Bdd_of_ConvNonzero` currently has a nonzero limit hypothesis. A cleaner
future version should probably prove boundedness of any convergent sequence,
then use it for the product theorem.

### 5. Cauchy Sequences

Purpose: shift from knowing a limit to detecting convergence internally.

Current levels to include:

- `Limits are Cauchy`: `IsCauchy`, `IsCauchy_of_SeqConv`
- `Sums of Cauchy Sequences`: `IsCauchy_of_Sum`
- `Cauchy Implies Bounded`: `IsBdd_of_Cauchy`
- `Monotone and Bounded Implies Cauchy`: `Monotone`,
  `IsCauchy_of_MonotoneBdd`, `push_neg`
- `Iterated Gaps`: technical proof of `IterateGap`

Boss: `IsCauchy_of_MonotoneBdd`.

Notes: in the current files, `IterateGap` is documented before its proof-level
appears. In the redesigned world, the proof should appear before the boss or be
presented as a helper level immediately before the boss.

### 6. Subsequences

Purpose: build subsequences deliberately, then use them to extract monotone
structure.

Current levels to include:

- `Subsequences`: `Subseq`, `SubseqConv`
- `Subsequence Example`: extracting a convergent subsequence of `(-1)^n`,
  `let`
- `Iterated Subsequence`: `succ_iterate`, `subseq_of_succ`,
  `Subseq_of_Iterate`
- `Enhanced Choose`: building subsequences from infinitely many witnesses
- `Monotone Subsequence`: `IsAPeak`, `UnBddPeaks`,
  `MonotoneSubseq_of_BddPeaks`

Boss: `MonotoneSubseq_of_BddPeaks`.

Notes: this world should feel constructive. It starts with what a subsequence
is, then escalates into choosing and iterating index functions.

### 7. Bolzano-Weierstrass

Purpose: combine boundedness, monotone subsequences, and Cauchy behavior into
the central compactness theorem for sequences.

Current levels to include:

- `IsCauchy_of_AntitoneBdd`
- `AntitoneSubseq_of_UnBddPeaks`
- `BolzanoWeierstrass`

Boss: `BolzanoWeierstrass`.

Notes: this can be a short world. That is fine: it is a theorem payoff world,
not a toolbox world.

### 8. The Real Numbers

Purpose: explain why the previous Cauchy technology constructs/completes the
real line.

Current levels to include:

- `Completeness`: `Real_of_CauSeq`, `SeqLim_of_Real_of_Cau`,
  `Reals_are_Complete`

Boss: `Reals_are_Complete`.

Future additions:

- equivalence classes of Cauchy rational sequences, if this becomes playable
- rational density
- least upper bound property as an analytic theorem here, or later in topology

Notes: the current topology world later proves `HasLUB_of_BddNonempty`.
Pedagogically, that theorem could either live here as "Completeness II" or
remain in topology as the engine for Heine-Borel. I would keep it in topology
for the game flow, but cross-reference it here.

### 9. Intro to Series

Purpose: introduce series as limits of partial sums and prove first convergence
tests/examples.

Current levels to include:

- `Finite Sums`: `range`, `sum_range_succ`, `sum_nonneg`, `TermLeSum`
- `Series`: `Series`, `SeriesLim`, `SeriesConv`,
  `LimZero_of_SeriesConv`
- `Leibniz Series` finite identity
- `Leibniz Series` convergence
- `Series Order Theorem`
- `The Basel Problem`

Boss: current boss should be the Basel comparison proof.

Better future boss:

- `ComparisonTest`
- `GeometricSeries`
- `BaselBound` or a named convergence result for `sum 1 / n^2`

Notes: finite sums appear before series in the current lecture order, and they
should stay early. They are the grammar of all later series worlds.

### 10. Absolute and Alternating Series

Purpose: teach the two main ways series converge before rearrangements.

Current levels to include:

- `Absolute Convergence Implies Convergence`: `AbsSeriesConv`,
  `Conv_of_AbsSeriesConv`
- `Alternating Series Test`: `AlternatingSeriesTest`

Boss: `AlternatingSeriesTest`.

Notes: this world currently depends on several helper theorem docs from pset-like
material (`SeqEvenOdd`, `MonotoneSeriesEven`, etc.). In the redesign, those
helpers should become visible levels, short side quests, or hidden theorem
unlocks immediately before the boss.

### 11. Riemann Rearrangement

Purpose: show why absolute convergence makes infinite addition stable under
reordering.

Current levels to include:

- `More Flexible Cauchy`: `StrongCauchy_of_AbsSeriesConv`
- `Rearrangements`: `Injective`, `Surjective`, `Rearrangement`,
  `EventuallyCovers_of_Rearrangement`
- `Big Boss: Rearrangement Theorem`: `RearrangementThm`

Boss: `RearrangementThm`.

Notes: this is already shaped like a good world.

### 12. Conditional Convergence

Purpose: give the contrasting theorem: conditional convergence is flexible
enough to rearrange to any target.

Current levels to include:

- `Conditional Convergence Theorem`

Boss: the current conditional convergence theorem.

Needs development:

- positive and negative parts of a conditionally convergent series
- choosing enough positive or negative terms to cross a target
- constructing the rearrangement

Notes: this should be a separate world from `Riemann Rearrangement`. The player
should feel the sharp dichotomy: absolute convergence gives invariance;
conditional convergence gives controllable chaos. **Yes, this world should be an optional world off to the side of Rearrangement. And indeed, it needs further development to be cleanly playable.**

### 13. Function Limits and Continuity

Purpose: move from sequences to functions, prove the sequential criterion, and
establish basic continuous-function algebra.

Current levels to include:

- `Limits of Functions`: `FunLimAt`
- `Continuous Functions`: `FunContAt`
- `Sum of Continuous Functions`: `FunContAtAdd`
- `Sequential Criterion for Limits`, forward direction:
  `SeqLim_of_FunLimAt`
- `Sequential Criterion for Limits`, backward direction:
  `FunLim_of_SeqLim`
- `Continuity Everywhere`: `FunCont`
- `Continuous Composition`: `Cont_Comp`

Current boss: `Cont_Comp`.

Better future boss:

- `ContinuousAlgebra`: sums, products, scalar multiples, quotients
- `ContinuousPolynomial`: every polynomial is continuous

Notes: this world should come after real completeness, not just after sequence
manipulation, because it conceptually starts calculus on the completed real
line.

### 14. Derivatives

Purpose: define differentiability and start building derivative calculus.

Current levels to include:

- `Computing a Derivative`: `FunDerivAt`
- `The Derivative Function`: `FunDeriv`

Needs development:

- derivative implies continuity
- constant, identity, sum, product, chain rules
- Fermat's theorem
- Rolle's theorem
- Mean Value Theorem

Boss: future `MeanValueTheorem`.

Notes: right now this is more of a seed than a world. It should eventually be
one of the main roads into the Fundamental Theorem of Calculus.

### 15. Uniformity

Purpose: separate pointwise control from uniform control.

Current levels to include:

- `Uniform Convergence`: `UnifConv`, `Cont_of_UnifConv`
- `Compactness`: `UnifContOn_of_Compact`, once compactness is available

Boss: `Cont_of_UnifConv` for uniform convergence, then
`UnifContOn_of_Compact` after the compactness dependency is established.

Notes: this could be one world with two chapters, or two worlds:
`Uniform Convergence` and `Uniform Continuity`. If the game UI benefits from
shorter worlds, split it. **Wait, the whole point of the original game was for everything to arrive "just in time". So Uniformity and Compactness came only after they were actually needed, in Riemann Integration!**

### 16. Riemann Sums and Integration

Purpose: define the Riemann integral via sums and prove convergence under
uniform continuity.

Current levels to include:

- `Integration`: `RiemannSum`, `HasIntegral`, `IntegrableOn`,
  integrability of `fun x => x`
- `Riemann Sum Refinement`: `RiemannSumRefinement`
- `Integration Converges`: `HasIntegral_of_UnifContOn`
- `Uniform Convergence Implies Integrability`: `Integrable_of_UnifConv`

Boss: `HasIntegral_of_UnifContOn`, with `Integrable_of_UnifConv` as an
advanced follow-up boss.

Notes: the current `Integration` level introduces several finite-sum theorem
docs. Those should probably be unlocked in `Intro to Series` or a shared
finite-sums toolkit before this world starts.

### 17. Topology and Compactness

Purpose: introduce open balls, open and closed sets, compactness, and the least
upper bound property in the form needed for Heine-Borel.

Current levels to include:

- `Compactness`: `Ball`, `IsCompact`, `mem_Union`, `FinMinPos`
- `Heine-Borel Part 1a`: compact implies bounded
- `Heine-Borel Part 1b`: compact implies closed
- `Least Upper Bound Property`: `IsUB`, `IsLUB`,
  `HasLUB_of_BddNonempty`

Boss: `HasLUB_of_BddNonempty`, if this is kept inside topology.

Alternative: move `HasLUB_of_BddNonempty` to `The Real Numbers` and make this
world end with `IsClosed_of_Compact`.

### 18. Heine-Borel

Purpose: prove the full compactness characterization for closed bounded
subsets of the real line.

Current levels to include:

- `Closed intervals are compact`: `IsCompact_of_ClosedInterval`
- `Closed subsets of compact sets are compact`:
  `IsCompact_of_ClosedSubset`

Boss: a future single theorem, perhaps:

- `HeineBorel`: `IsCompact S <-> IsClosed S /\ Bdd S`
- or, more game-friendly, `IsCompact_of_ClosedBdd`

Notes: the current two levels are strong, but the world wants a final named
theorem that says "this is Heine-Borel" in one place.

### 19. Calculus Capstone

Purpose: assemble continuity, compactness, derivatives, and integrals into the
theorems students expect from calculus.

Current levels to include:

- `Intermediate Value Theorem`: `IVT`

Needs development:

- Extreme Value Theorem
- uniform continuity on closed intervals as a corollary of Heine-Borel
- integrability of continuous functions on closed intervals
- Fundamental Theorem of Calculus, Part I
- Fundamental Theorem of Calculus, Part II

Boss: future `FundamentalTheoremOfCalculus`.

Notes: this is the natural ending of the core game. The story started by asking
what makes calculus rigorous; this world should answer that question directly.

## Optional Advanced Worlds

### Taylor Series

Status: recommended optional world.

Why it belongs: the Newton pi story is already in the game, and Taylor series
would reconnect the opening narrative to rigorous convergence.

Likely dependencies:

- `Intro to Series`
- `Absolute and Alternating Series`
- `Derivatives`
- maybe `Uniformity`

Possible boss:

- Taylor's theorem with remainder
- power series are differentiable inside their radius of convergence
- a rigorous version of Newton's binomial expansion

### Fourier Series

Status: optional, probably after the main game.

Why it belongs: Fourier is central to the opening motivation, but a full
Fourier world could easily become a second course.

Likely dependencies:

- `Taylor Series` or at least advanced series maturity
- `Uniformity`
- integration

Possible scope:

- trigonometric polynomial approximation
- pointwise versus uniform convergence
- a carefully chosen example showing why Cauchy's intuition failed

Recommendation: keep Fourier as an epilogue or future expansion, not part of
the first complete game.

## Proposed World Names and Bosses

| Order | World | Current boss | Needs new boss? |
| --- | --- | --- | --- |
| 1 | Proof Tutorial | `Big Boss: The Ultimate Tactic Challenge` | no |
| 2 | Intro to Sequences | `SumLim` | no |
| 3 | Absolute Values and Squeeze | `SqueezeThm` | no |
| 4 | Algebraic Limit Theorems | `ProdLimNeNe` | yes, full ALT/quotient |
| 5 | Cauchy Sequences | `IsCauchy_of_MonotoneBdd` | probably no |
| 6 | Subsequences | `MonotoneSubseq_of_BddPeaks` | no |
| 7 | Bolzano-Weierstrass | `BolzanoWeierstrass` | no |
| 8 | The Real Numbers | `Reals_are_Complete` | no |
| 9 | Intro to Series | Basel comparison level | yes, named theorem |
| 10 | Absolute and Alternating Series | `AlternatingSeriesTest` | no |
| 11 | Riemann Rearrangement | `RearrangementThm` | no |
| 12 | Conditional Convergence | conditional convergence theorem | needs supporting levels |
| 13 | Function Limits and Continuity | `Cont_Comp` | yes, continuous algebra |
| 14 | Derivatives | none yet | yes, MVT |
| 15 | Uniformity | `Cont_of_UnifConv` / `UnifContOn_of_Compact` | maybe split |
| 16 | Riemann Sums and Integration | `HasIntegral_of_UnifContOn` | no |
| 17 | Topology and Compactness | `HasLUB_of_BddNonempty` | maybe |
| 18 | Heine-Borel | interval/subset compactness | yes, named `HeineBorel` |
| 19 | Calculus Capstone | `IVT` currently | yes, FTC |
| 20 | Taylor Series | future | yes |
| 21 | Fourier Series | future optional | yes |

## Migration Notes

1. Create new world wrapper files by topic, for example
   `Game/Levels/W01_ProofTutorial.lean`, rather than mutating the old lecture
   wrappers immediately.
2. Move or re-export existing level files gradually. The old files can keep
   their physical paths while the new wrappers import them in redesigned order.
3. Introduce new dependencies according to the graph above. Avoid making every
   world import all previous worlds; that will hide missing prerequisite
   structure.
4. Add explicit boss levels where the current material ends abruptly:
   algebraic limits, series comparison, continuous algebra, derivatives,
   Heine-Borel, and FTC.
5. Once the topic worlds compile, update `Game.lean` to import the topic
   wrappers and define dependencies between topic worlds instead of lecture
   worlds.

## Highest-Value New Levels

If we want the redesign to feel complete without boiling the ocean, these are
the best next additions:

- `Bdd_of_Conv`: remove the nonzero-limit restriction from boundedness.
- `ProdLim`: product theorem without nonzero hypotheses.
- `QuotLim`: quotient theorem.
- `ComparisonTest`: a reusable series comparison theorem.
- `HeineBorel`: closed and bounded iff compact, or at least
  `IsCompact_of_ClosedBdd`.
- `DerivativeImpliesContinuous`.
- `MeanValueTheorem`.
- `ContinuousIntegrableOnCompact`.
- `FundamentalTheoremOfCalculus`.

That sequence would turn the current excellent skeleton into a genuinely
complete real analysis game arc.
