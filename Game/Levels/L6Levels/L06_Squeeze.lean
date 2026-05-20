import Game.Levels.L6Levels.L05_AbsLt

World "Lecture6"
Level 7
Title "Big Boss : Squeeze Theorem"

Introduction "
# Level 7 Big Boss: Squeeze Theorem

Welcome to another Big Boss level! You're about to prove one of the most elegant and powerful theorems in real analysis: the Squeeze Theorem (also known as the Sandwich Theorem or Pinching Theorem). This theorem beautifully captures the intuitive idea that if you trap a sequence between two other sequences that both converge to the same limit, then the trapped sequence must also converge to that limit.

The Squeeze Theorem is a perfect showcase for how the logical tools you've been developing—working with conjunctions, absolute values, and inequalities—come together to prove deep mathematical results. You'll need to orchestrate all your skills: extracting information from convergence conditions, managing multiple epsilon-N arguments simultaneously, and combining inequalities with absolute value manipulations.

**The Intuitive Picture:**
Imagine three runners on a track. Runner A and Runner C are both heading to the same finish line L, and Runner B is always between them. No matter how A and C weave back and forth, as long as they both end up at L and B stays between them, B must also end up at L. There's simply nowhere else for B to go!

**The Mathematical Challenge:**
The formal proof requires careful epsilon management. Given any tolerance `ε`, you need to show that `b (n)` gets within `ε` of `L`. Since `a (n)` and `c (n)` both get within `ε` of `L`, and `b (n)` is squeezed between them, you can use the transitivity of inequalities to show that `b (n)` is also within `ε` of `L`.

"


/-- If `a c : ℕ → ℝ`, with `a` and `c` both converging to `L`,
and `b` is another sequence, squeezed between `a` and `c`, then `b` also converges to `L`. -/
TheoremDoc SqueezeThm as "SqueezeThm" in "aₙ"


/-- Prove this
-/
Statement SqueezeThm (a b c N : ℕ → ℝ) (L : ℝ) (aToL : SeqLim a L)
(cToL : SeqLim c L) (aLeb : ∀ n ≥ N, a n ≤ b n) (bLec : ∀ n ≥ N, b n ≤ c n) :
  SeqLim b L := by
intro ε hε
specialize aToL ε hε
specialize cToL ε hε
choose Na hNa using aToL
choose Nc hNc using cToL
use Na + Nc
intro n hn
have hna : Na ≤ n := by bound
have hnc : Nc ≤ n := by bound
specialize hNa n hna
specialize hNc n hnc
rewrite [abs_lt] at hNa
rewrite [abs_lt] at hNc
rewrite [abs_lt]
split_ands
specialize aLeb n
bound
specialize bLec n
bound


Conclusion "
# 🏆 Squeeze Theorem Conquered! 🏆

Magnificent! The Squeeze Theorem is not just mathematically beautiful—it's also incredibly practical and will serve you throughout your mathematical journey.

**Why This Is a Big Deal:**
The Squeeze Theorem is a workhorse of mathematical analysis. It's the tool that lets us prove challenging convergence results by reducing them to easier problems. Can't directly show that a complex sequence converges? Find two simpler sequences that squeeze it, and you're done!

**Technical Mastery:**
Notice how your proof elegantly combined multiple techniques: epsilon-N arguments, absolute value manipulation with `abs_lt`, logical decomposition with `split_ands`, and inequality reasoning. This synthesis of tools is what makes advanced mathematical proof possible.

**The Power of Transitivity:**
The heart of your proof was recognizing that if `L - ε < a(n) ≤ b(n) ≤ c(n) < L + ε`, then by transitivity, `L - ε < b(n) < L + ε`, which is exactly what we needed. This kind of inequality chaining is fundamental to analysis.

**Real-World Applications:**
This theorem proves convergence for sequences that would be nearly impossible to handle directly. For example:
- `sin(1/n) → 0` (squeezed between `-1/n` and `1/n`)
- Recursive sequences where exact formulas are intractable
- Sequences defined by complex geometric or probabilistic processes

**Looking Forward:**
The Squeeze Theorem will reappear throughout analysis: in proving continuity results, establishing uniform convergence, and even in advanced topics like measure theory. You've now mastered not just the theorem itself, but the proof techniques that make it work.

You're developing the kind of mathematical sophistication that allows you to see structure and opportunity where others see only complexity. That's the mark of a true mathematician!
"
