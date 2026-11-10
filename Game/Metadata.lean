import GameApi

--import Game.CustomTactic.Rw  -- weaker `rw` which behaves like Lean's `rewrite` tactic (i.e. uses no `rfl`)
import Game.CustomTactic.Linarith -- modified `linarith` tactic

import Mathlib.Basic.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp
import Mathlib.Analysis.RCLike.Basic
import Mathlib.Analysis.SpecialFunctions.Log.Base
import Mathlib.Tactic.Cases

/-! Use this file to add things that should be available in all levels.

For example, this demo imports the mathlib tactics

*Note*: As long as `Game.lean` exists and ends with the `MakeGame` command,
you are completely free how you structure your lean project, this is merely
a suggestion.

*Bug*: However, things are bugged out if the levels of different worlds are imported
in a random order. Therefore, you should keep the structure of one file Lean file per world
which imports all its levels.
-/
