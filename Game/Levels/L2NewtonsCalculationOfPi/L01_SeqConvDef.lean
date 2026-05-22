import Game.Metadata


World "NewtonsCalculationOfPi"
Level 1
Title "The Convergence of a Sequence"

Introduction "
# Level 1: The Main Definition

Our first step to making Newton's argument rigorous is
to spell out *exactly* what we mean by a sequence
$a_n$ converging to a limit. It will take a little work to build up to the definition, and more importantly, *why*
that might seem like a reasonable definition to have.

But first: for some reason (likely Euler is to blame), mathematics has *two* completely different conventions for how to write functions. For general functions $f : \\mathbb R \\to\\mathbb R$,
we write $f(x)$, with parentheses. But when working with sequences, $a_n$, meaning,
$a_0, a_1, a_2, \\dots$, we bizarrely switch instead to subscripts.
Why? Historical accident.
A sequence is nothing but a function whose \"domain\" (that is, the set of
inputs to the function) is the natural numbers; so we will break
with tradition and unify the two conventions, henceforth writing
$a : \\mathbb N \\to \\mathbb R$ for sequences of real numbers, $a (0), a (1),
a (2), \\dots$.

Now, back to limits. The definition that mathematicians eventually came up with
for what it means for a sequence to converge, was so intricate (at least
at first sight) that it had to be invented *twice*!
The eventual formulation crystallized through the work of Karl Weierstrass in the 1860s, who transformed analysis from an intuitive art into a rigorous science. However, the seeds of this idea appeared much earlier in the work of Bernard Bolzano. In the 1810s and 1820s, Bolzano was developing remarkably modern ideas about continuity and limits, but he was too far ahead of his time for the mathematical community to accept these abstract concepts.
Only by Weierstrass's time -- a half-century later -- did these ideas catch on.

Without further ado, here it is:

**Definition** (`SeqLim`):
Given a sequence `a : ℕ → ℝ` and a real number `L : ℝ`, we
write `SeqLim a L` and
say that the sequence `a` **converges** to the limit `L`,
 if:

For every `ε > 0`, there exists some `N : ℕ` such that, for all `n ≥ N`, we have `|a (n) - L| < ε`.


This definition is probably not the first, or second, or tenth thing you might've come up with!
But over time, I hope you'll come to see that it
 embodies a beautiful negotiation between precision and effort.

 I like to think of it as a conversation between an Engineer and a Machinist:

 The Engineer arrives with specifications: \"We're going to make this widget, and I need its length to be 1 foot, with an error tolerance
 of 1/100 of an inch\".

 The Machinist replies: \"Sure, I can do that, but I'll have to run my special equipment for at least 10 hours to guarantee that tolerance.\"

 The Enginner
 thinks for a moment: \"I'm sorry, I misspoke, can we change the tolerance
 to 1/1000 of an inch?\"

 The Machinist replies: \"Oof, yeah we can do it, but it'll cost ya. I'll need at least 40 hours of operation, but after that, I'll guarantee it.\"

As long as this conversation can continue regardless of *whatever* tolerance `ε > 0` the Engineer requires, with the Machinist
always being able to reply with a finite minimum number of hours `N`,
after which the tolerance will be achieved, we can say
that the equipment **converges**.

Now let's read Weierstrauss's (or is it Bolzano's?) definition again. We have some process
that at time `n` returns a reading `a (n)` (think: widget length). Our ultimate goal is to make the length `L`. If
for any tolerance `ε > 0`, no matter how small, there will always exist some minimum
time `N`, so that, for any future time, `n ≥ N`,
we are guaranteed to be within that tolerance, `|a (n) - L| < ε`, that's exactly the condition under which we'll
say that the sequence `a (n)` **converges** to `L`.

[![A Sequence Converging](images/SeqLim.jpg)](https://en.wikipedia.org/wiki/Limit_of_a_sequence)

What makes this definition so powerful is its universality. The Machinist is essentially promising: 'Give me *any* tolerance requirement, no matter how stringent, and I can meet it -- though I might need more resources (larger `N`) for tighter specifications.'


Notice something else about the definition: It makes no mention of something happening \"eventually\", or \"at infinity\" or any other wishy-washy squirm words. We have traded the ambiguity of speaking about infinity for the precision of existential and universal quantifiers. No more hand-waving about what happens \"as `n` gets large\" - instead, we have a concrete challenge: given *any* tolerance `ε`, can you find a specific threshold `N`? *That* idea was the key breakthrough that allowed Calculus to enter the realm of rigorous mathematics.

In Lean, the definition is written like so:

`def SeqLim (a : ℕ → ℝ) (L : ℝ) : Prop :=
  ∀ ε > 0, ∃ N, ∀ n ≥ N, |a n - L| < ε`

This syntax should be familiar from the `have` tactic you already know and love.
The special symbol `def` (instead of `have`) means that we're about to define something, and
`SeqLim` is its name (for sequence limit, of course; but we could have called it whatever we want). Then our assumptions are a sequence `a : ℕ → ℝ` and
some real number `L : ℝ`. Then after the colon `:` goes our output, which in this case is `Prop`, that is, a statement (proposition) that can be true or false. So `SeqLim` is really a function that takes a sequence and hypothetical limiting value, and returns true or false based on whether
the condition is satisfied. Then comes a colon-equals `:=`, after which the
exact condition to be tested is specified. And the condition is what we already said, for all epsilon, yadda yadda. The big difference is that you can write `have` inside a proof, but you can't write `def` inside a proof;
`def` is reserved for making global definitions that
can be referenced forever once they're introduced.
Notice that on the right hand side, the list
of Definitions now includes `SeqLim`, and, as usual,
if you forget what it means, you can click on it for a reminder.

Let's try out the definition in practice!

**Your Task**

Prove that the constant sequence converges to the same constant.
That is, suppose that you have a sequence `a : ℕ → ℝ`, and there's a real number
`L`, and a hypothesis that, for all values of `n`, we have  `a (n) = L`; then prove that `a` does converge, and converges to `L`. This is the simplest possible case: if our 'factory' always produces the exact target value `L`, then we can meet any tolerance requirement immediately!

You may find it useful to call on a new tactic called `change`. It allows you to replace a goal (or, when coupled with `at`, a hypothesis) by its definition. In our example here,
you will see the goal as `SeqLim a L`. What are you supposed to do with that,
how can you make progress? Well, if you remember how `SeqLim` is defined,
then you can replace the goal with the definition, by writing

`change ∀ ε > 0, ∃ N, ∀ n ≥ N, |a n - L| < ε`

Lean will then change the goal to its definition.
Remember that `ε`, `N`, and `n` are all dummy variables
here, so you can have some fun:

`change ∀ Alice > 0, ∃ Bob, ∀ blah ≥ Bob, |a blah - L| < Alice`

This may come in handy later. (Not Alice and Bob *per se*, but the ability to give better names for dummy variables, so as not to clash with already existing variable names...)

**⚠️⚠️⚠️ CAUTION ⚠️⚠️⚠️** Remember how Lean *must* have space after a function name, it won't accept `f(x)` but instead requires `f (x)`? Well... it's the other way around for absolute
values. Lean won't accept a space after an absolute value.
So if you write `| a n - L|`, you'll get an error message.
Same with `|a n - L |` -- the space at the end is the problem. Sorry! I didn't write the syntax.

**Normalizing Numerical Values**: And one last tactic you might also find useful is `norm_num` (for normalizing numerical values); it evaluates numerical expressions and proves equalities/inequalities involving concrete numbers. For example, if you're stuck with an `|0|` at some point,
and you want to convert it to plain old `0`, try calling `norm_num`.

Ok, get to it!
"


/-- The `change` tactic changes a goal to something definitionally equal to it. If the definition of `X` is `Y`, that is, `X := Y`, and the Goal is `X`, you can write `change Y` and the Goal will change to `Y`. You can also
do this at a hypothesis; if you have a hypothesis `h : X`, you can write `change Y at h`, and `h` will change to `h : Y`. -/
TacticDoc change

/-- `(a : ℕ → ℝ) (L : ℝ) := ∀ ε > 0, ∃ N, ∀ n ≥ N, |a n - L| < ε`

For a sequence `a : ℕ → ℝ` and a real number `L : ℝ`, we say that `SeqLim a L` holds if: for every `ε > 0`, there exists `N : ℕ` such that for all `n ≥ N`, we have `|a n - L| < ε`. -/
DefinitionDoc SeqLim as "SeqLim"

NewDefinition SeqLim

def SeqLim (a : ℕ → ℝ) (L : ℝ) : Prop :=
  ∀ ε > 0, ∃ N : ℕ, ∀ n ≥ N, |a n - L| < ε

/-- The `norm_num` tactic can normalize numerical constants and functions of them. -/
TacticDoc norm_num

NewTactic change norm_num

/--
For any sequence `a : ℕ → ℝ` and constant `L : ℝ`, and
hypothesis `h : ∀ n, a n = L`, the theorem `ConstLim`
proves that `SeqLim a L`, that is, the (constant) sequence `a` converges to `L`.
-/
TheoremDoc ConstLim as "ConstLim" in "aₙ"


/-- Prove that the constant sequence converges to its constant value.
This is the Machinist's dream scenario: we're already producing exactly what's required! -/
Statement ConstLim (a : ℕ → ℝ) (L : ℝ) (a_const : ∀ n, a n = L) : SeqLim a L := by
  Hint (hidden := true) "Try starting with `change ∀ ε > 0, ∃ N : ℕ, ∀ n ≥ N, |a n - L| < ε`"
  change ∀ ε > 0, ∃ N : ℕ, ∀ n ≥ N, |a n - L| < ε
  intro ε hε
  use 1
  intro n hn
  specialize a_const n
  rewrite [a_const]
  ring_nf
  clear hn a_const n a L
  Hint (hidden := true) "This is where you might find it useful to call `norm_num` and normalize `|0|` to `0`."
  norm_num
  Hint (hidden := true) "While you may see `0 < ε` in the goal and `ε > 0` in the hypothesis `hε`, Lean will still know that these two things are exactly the same..."
  apply hε




Conclusion "
# 🎉 Excellent Work! 🎉

You've just completed your first rigorous limit proof! Let's reflect on what you accomplished and the key insights from this foundational example.

**What you just proved:**
You showed that if a sequence always outputs the same value `L`, then it converges to `L`. The Machinist's response to any tolerance demand `ε > 0` is beautifully simple: 'I can meet that specification immediately with any production run length `N`, because I'm already producing exactly what you want!'

**Key Insights from this proof:**

1. **The `change` tactic**: You learned how to unfold a definition to see what you're really trying to prove. `SeqLim a L` became the concrete epsilon-N condition.

2. **The logical structure**: The proof followed the natural flow of the definition:
   - `intro ε hε` handled 'for every ε > 0'
   - `use 1` provided the witness `N` (any number works!)
   - `intro n hn` handled '∀ n ≥ N'
   - Then algebraic manipulation showed that `|a n - L| = |L - L| = |0|`
   - Then numerical normalization gave that `|0| = 0`, and `hε` finally proved that `|a n - L| < ε`.

**The Beautiful Simplicity:**
This is the Machinist's dream scenario—no matter how demanding the engineer's tolerance requirements, the constant factory can satisfy them instantly. There's no trade-off between precision and effort because the output is already perfect!

You're building the foundation for all of calculus. Every limit, derivative, and integral ultimately rests on arguments like this one.

## Check in, in Natural Language

Let's step back from the formal Lean proof and understand what we just proved in plain English.

**Theorem (in natural language):** If a sequence has the same value for every term, then it converges to that constant value.

**Proof:** Suppose we have a sequence $a(n)$ where $a(n) = L$ for all $n$, and we want to show that this sequence converges to $L$.

By definition, we need to show that for any tolerance $\\varepsilon > 0$, we can find a point $N$ such that for all $n \\geq N$, we have $|a(n) - L| < \\varepsilon$.

This is almost trivially simple: since $a(n) = L$ for every $n$, we have:
$$|a(n) - L| = |L - L| = |0| = 0$$

Since $0 < \\varepsilon$ for any positive $\\varepsilon$, we can choose any $N$ we want (we chose $N = 1$ in the proof, but $N = 0$ or $N = 1000$ would work equally well).

Therefore, for any $n \\geq N$, we have $|a(n) - L| = 0 < \\varepsilon$, which proves convergence.
**QED**

"
