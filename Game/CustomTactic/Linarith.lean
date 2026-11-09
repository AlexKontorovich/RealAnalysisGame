import Mathlib.Tactic.Linarith
import Mathlib.Util.ElabWithoutMVars

open Mathlib.Tactic in

@[inherit_doc Mathlib.Tactic.linarith]
syntax (name := Game.linarith) "linarith" "!"? linarithArgsRest : tactic

-- This is copied from the Mathlib tactic `linarith`
-- the keyword `only` has been removed but the tactic behaves as if it was always specified
open Lean Mathlib Syntax Elab Tactic in
elab_rules (kind := Game.linarith) : tactic
  | `(tactic| linarith $[!%$bang]? $cfg:optConfig $[[$args,*]]?) => withMainContext do
    let args ← ((args.map (TSepArray.getElems)).getD {}).mapM (elabTermWithoutNewMVars `linarith)
    let cfg := (← Mathlib.Tactic.elabLinarithConfig cfg).updateReducibility bang.isSome
    commitIfNoEx do liftMetaFinishingTactic <| Linarith.linarith true args.toList cfg
  | `(tactic| linarith $[!%$bang]? $cfg:optConfig only%$o $[[$args,*]]?) =>
    throwError "In this game, `linarith` has no `only` keyword!"
