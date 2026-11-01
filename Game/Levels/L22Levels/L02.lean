import Game.Levels.L22Levels.L01

open Set

World "Lecture22"
Level 2
Title "Uniform Convergence"
Introduction "
# Level 2: Uniform Convergence

Welcome to one of the most profound and beautiful theorems in real analysis! After seeing how nicely continuous functions compose, you might think that continuous functions always \"play well\" together. But as we hinted in our introduction dialogue, this isn't always the case when infinite processes are involved.

## The Crisis We're Solving

Remember Cauchy's mistake? In the early 1800s, even the great Augustin-Louis Cauchy \"proved\" that the pointwise limit of continuous functions must be continuous. His proof looked rock-solid—until counterexamples like $f_n(x) = x^n$ on $[0,1]$ shattered the illusion.

The problem isn't with Cauchy's logic—it's with pointwise convergence itself. When we say $f_n \\to F$ pointwise, we're saying:

**Pointwise**: \"For each point $x$, eventually the functions $f_n(x)$ get close to $F(x)$\"

But \"eventually\" might mean very different things at different points! At some points, $f_n$ might converge to $F$ after just 10 steps. At nearby points, it might take 1000 steps. This non-uniformity destroys continuity.

## The Beautiful Solution: Uniform Convergence

**Uniform convergence** fixes this by demanding the same rate of convergence everywhere:

**Uniform**: \"There's a single moment in time after which all the functions $f_n$ are close to $F$ at all points simultaneously\"

## The New Definition: `UnifConv`

`UnifConv (f : ℕ → ℝ → ℝ) (F : ℝ → ℝ) : Prop :=
  ∀ ε > 0, ∃ N, ∀ n ≥ N, ∀ x, |f n x - F x| < ε`

**Read this carefully**: For every tolerance $\\varepsilon > 0$, there exists a \"convergence moment\" $N$ such that for all later functions $f_n$ (with $n \\geq N$) and for all points $x$ simultaneously, we have $|f_n(x) - F(x)| < \\varepsilon$.

## The Quantifier Order Revolution

The difference between pointwise and uniform convergence is entirely about **quantifier order**:

- **Pointwise**: $\\forall \\varepsilon > 0, \\forall x, \\exists N, \\forall n \\geq N, |f_n(x) - F(x)| < \\varepsilon$
- **Uniform**: $\\forall \\varepsilon > 0, \\exists N, \\forall n \\geq N, \\forall x, |f_n(x) - F(x)| < \\varepsilon$

In pointwise convergence, $N$ can depend on both $x$ and $\\varepsilon$. In uniform convergence, $N$ depends only on $\\varepsilon$—the same $N$ must work for *every* point $x$.

## Why This Saves Continuity

Think back to our failed attempt to prove continuity with pointwise convergence. The breakdown was:

1. We picked $f_N$ to approximate $F(x)$ well at our point $x$
2. We used $f_N$'s continuity to control behavior near $x$
3. **DISASTER**: We needed $f_N$ to approximate $F(y)$ well at nearby points $y$, but our choice of $N$ was only guaranteed to work at $x$!

With uniform convergence:
1. We pick $f_N$ to approximate $F$ well **everywhere simultaneously**
2. We use $f_N$'s continuity to control behavior near $x$
3. **SUCCESS**: Since $f_N$ approximates $F$ uniformly, it automatically works at all nearby points $y$!

## The Theorem You'll Prove

**Theorem**: If each $f_n$ is continuous and $f_n$ converges uniformly to $F$, then $F$ is continuous.

This is the theorem that rehabilitated Cauchy's intuition. Continuous functions do preserve continuity under limits—you just need the right kind of limit!

## Your Proof Strategy: The $\\varepsilon/3$ Trick

To show $F$ is continuous at a point $x$, given $\\varepsilon > 0$, you'll want to show $|F(y) - F(x)| < \\varepsilon$ when $y$ is close to $x$.

Use the triangle inequality:
$$|F(y) - F(x)| \\leq |F(y) - f_N(y)| + |f_N(y) - f_N(x)| + |f_N(x) - F(x)|$$

Make each term less than $\\varepsilon/3$:
- **First term**: Uniform convergence gives you this everywhere
- **Second term**: Continuity of $f_N$ gives you this near $x$
- **Third term**: Uniform convergence gives you this everywhere

The magic is that uniform convergence gives you control over the first and third terms **simultaneously** for all points.

## A Historical Note

This distinction between pointwise and uniform convergence was one of the great clarifications of 19th-century analysis. It helped mathematicians understand exactly when their intuitions about limits and continuity could be trusted.

## Your Challenge

Prove that the uniform limit of continuous functions is continuous:

**Lean signature**: `(∀ n, FunCont (f n)) → UnifConv f F → FunCont F`

Ready to fix Cauchy's \"mistake\" and see how the right kind of convergence preserves continuity? The $\\varepsilon/3$ method awaits!
"

def UnifConv (f : ℕ → ℝ → ℝ) (F : ℝ → ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, ∀ x,
    |f n x - F x| < ε

/-- `(f : ℕ → ℝ → ℝ) (F : ℝ → ℝ) :=
∀ ε > 0, ∃ N, ∀ n ≥ N, ∀ x, |f n x - F x| < ε`

The sequence `f : ℕ → ℝ → ℝ` of functions converges uniformly to `F : ℝ → ℝ`.
-/
DefinitionDoc UnifConv as "UnifConv"

NewDefinition UnifConv

/--
If a sequence of functions `fₙ` converges uniformly to `F`, and each `fₙ` is continuous, then `F` is continuous.
-/
TheoremDoc Cont_of_UnifConv as "Cont_of_UnifConv" in "f(x)"

Statement Cont_of_UnifConv  (f : ℕ → ℝ → ℝ) (hf : ∀ n, FunCont (f n))
    (F : ℝ → ℝ) (hfF : UnifConv f F) : FunCont F:= by
intro x ε hε
choose N hN using hfF (ε / 3) (by bound)
choose δ hδ₁ hδ₂ using hf N x (ε / 3) (by bound)
use δ, hδ₁
intro y hy
have h1 : |F y - F x| ≤ |f N y - F y| + |f N y - f N x| + |f N x - F x| := by
    rewrite [show F y - F x = (F y - f N y) + ((f N y - f N x) + (f N x - F x)) by ring_nf]
    have f1 : |(F y - f N y) + ((f N y - f N x) + (f N x - F x))| ≤
        |(F y - f N y)| + |((f N y - f N x) + (f N x - F x))| := by apply abs_add_le
    have f2 : |((f N y - f N x) + (f N x - F x))| ≤ |f N y - f N x| + |f N x - F x| :=
        by apply abs_add_le
    have f3 : |F y - f N y| = |f N y - F y| := by apply abs_sub_comm
    linarith [f1, f2, f3]
have h2 : |f N y - F y| < ε / 3 := by apply hN N (by bound) y
have h3 : |f N x - F x| < ε / 3 := by apply hN N (by bound) x
have h4 : |f N y - f N x| < ε / 3 := by apply hδ₂ y hy
linarith [h1, h2, h3, h4]

Conclusion "
# Redemption and the Power of Uniformity

Magnificent! You've just completed one of the most important theorems in real analysis—the theorem that rescued Cauchy's intuition and clarified one of the fundamental relationships in mathematics.

## What You Just Accomplished

You proved that **uniform convergence preserves continuity**. This isn't just another theorem—it's the resolution to a mathematical crisis that puzzled the greatest minds of the 19th century. When Cauchy's \"proof\" that pointwise limits preserve continuity was shown to be false, mathematicians had to completely rethink what kinds of convergence were \"safe.\"

Your proof shows that the answer is: **uniform convergence**.

## The Beauty of the $\\varepsilon/3$ Method

Look back at your proof. Notice how the $\\varepsilon/3$ trick created perfect harmony:

```
|F(y) - F(x)| ≤ |F(y) - f_N(y)| + |f_N(y) - f_N(x)| + |f_N(x) - F(x)|
                     ↓                    ↓                    ↓
                  < ε/3              < ε/3                < ε/3
```

The magic is that uniform convergence gave you control over the **first and third terms simultaneously**. This is precisely what pointwise convergence couldn't do—it could only promise that each term could be made small, but not necessarily at the same time with the same choice of $N$.

## The Quantifier Order Victory

Remember the crucial difference:
- **Pointwise**: $\\forall x, \\exists N_{x,\\varepsilon}, \\ldots$ (each point gets its own $N$)
- **Uniform**: $\\exists N_\\varepsilon, \\forall x, \\ldots$ (one $N$ works everywhere)

Your proof exploited this difference beautifully. When you wrote:
```lean
choose N hN using hfF (ε / 3) (by bound)
```

You were extracting a **single** $N$ that worked for **all points** simultaneously. This is the heart of why uniform convergence is so powerful.

## Historical Vindication

Cauchy's original intuition was that \"limits of continuous functions should be continuous.\" He was absolutely right—he just didn't know about uniform convergence yet! Your theorem shows that:

1. Cauchy's intuition was mathematically sound
2. The problem was with pointwise convergence, not with the intuition
3. Uniform convergence is the \"correct\" notion of convergence for preserving nice properties

## The Deeper Mathematical Lesson

This theorem illustrates a profound principle: **the order of quantifiers matters tremendously**. Moving from $\\forall x, \\exists N$ to $\\exists N, \\forall x$ seems like a tiny change, but it's the difference between:
- A convergence that can destroy continuity (pointwise)
- A convergence that preserves continuity (uniform)

This is why mathematicians are so careful about logic and quantifiers—small changes can have enormous consequences.

## Technical Mastery

In your Lean proof, you demonstrated sophisticated technique:
- **Strategic decomposition**: Using the triangle inequality to break a complex problem into manageable pieces
- **Resource management**: Carefully allocating your $\\varepsilon$ budget as $\\varepsilon/3 + \\varepsilon/3 + \\varepsilon/3$
- **Logical precision**: Extracting the right witnesses from existential statements in the right order

The `choose` tactic and careful hypothesis management are becoming second nature to you!

## Looking Forward: Integration and Beyond

Your next challenge involves integration—and guess what? The distinction between pointwise and uniform convergence will be crucial there too. Many of the most important theorems in analysis (dominated convergence, monotone convergence, etc.) are essentially about finding the right conditions under which \"limit\" and \"integral\" can be swapped.

## A Moment of Mathematical Pride

You've just proven a theorem that eluded even Cauchy initially. The mathematical community spent decades clarifying exactly when limits preserve continuity, and you've now mastered this crucial insight.

Every time you work with power series, Fourier series, or any other infinite sum of functions, you're implicitly using the principles you just proved.

## The Ultimate Insight

The real lesson of this level isn't just about uniform convergence—it's about the incredible precision required in mathematics. The difference between two types of convergence, distinguished only by the order of two quantifiers, is the difference between a theorem that's true and one that's false.

This is why mathematics is both beautiful and challenging: every word, every symbol, every logical connection matters.

## Final Thought

Uniform convergence is more than just a technical condition—it's a way of saying \"all the convergence happens in harmony.\" When functions converge uniformly, they converge \"together,\" maintaining their nice properties. When they converge only pointwise, they can converge \"separately,\" potentially destroying structure.

You've now learned to distinguish between these two fundamentally different types of convergence, and that makes you a much more sophisticated analyst.

Ready for integration? Your mastery of uniform convergence will serve you well! 🌟
"
