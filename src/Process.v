Require Import
  Coq.Strings.String
  Fiat.ADT
  Fiat.ADTNotation.

Inductive processStartError : Set :=
  | noSuchFile.
  (* etc *)

Inductive processState : Set :=
  | running : processState
  | errored : processStartError -> processState
  | reaped : processState.

Record processConf : Set := mkProcessConf
  { prog : string
  ; args : list string
    (* should be a proper dictionary *)
  ; env : list (string * string)
  }.

(* Obviously needs fleshing out *)
Definition exitStatus := unit.

Inductive StartProcessResult : processState -> Prop :=
  | runningOk : StartProcessResult running
  | erroredOk : forall x : processStartError, StartProcessResult (errored x).    

Definition ProcessSpec := Def ADT
  { rep := processState

  , Def Constructor1 "startProcess" (conf : processConf) : rep :=
    x <- { st | StartProcessResult st };
    ret x

  ,,Def Method0 "waitProcess" (r : rep) : rep * exitStatus :=
      st <- { x | True };
      ret (reaped, st)
  }%ADTParsing.
