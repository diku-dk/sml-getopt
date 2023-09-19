(* This example uses reference cells to store the options. *)

val foo = ref true
val bar = ref 10
val baz = ref false

fun bad_usage () =
  ( TextIO.output (TextIO.stdErr, (GetOpt.usage (options ())))
  ; OS.Process.exit OS.Process.failure
  )

and set_foo "true" = foo := true
  | set_foo "false" = foo := false
  | set_foo _ = bad_usage ()

and set_bar NONE = bar := 42
  | set_bar (SOME s) =
      case Int.fromString s of
        SOME x => bar := x
      | NONE => bad_usage ()

and help () =
    (TextIO.output (TextIO.stdOut, (GetOpt.usage (options ())));
     OS.Process.exit OS.Process.success)

and options () : (unit GetOpt.opt_descr) list =
  [ { short = [#"f"]
    , long = ["foo"]
    , arg = GetOpt.REQ_ARG (set_foo, "BOOL")
    , desc = "Set foo to this value."
    }
  , { short = [#"b"]
    , long = ["bar"]
    , arg = GetOpt.OPT_ARG (set_bar, "INT")
    , desc = "Set bar to this value."
    }
  , { short = []
    , long = ["baz"]
    , arg = GetOpt.NO_ARG (fn () => baz := not (!baz))
    , desc = "Flip baz."
    }
  , { short = [#"h"]
    , long = ["help"]
    , arg = GetOpt.NO_ARG help
    , desc = "Print help text."
    }
  ]

val (_, nonopts, errors) =
  GetOpt.getopt GetOpt.REQUIRE_ORDER (options ()) (CommandLine.arguments ())

val () =
  case errors of
    [] =>
      ( print ("foo: " ^ Bool.toString (!foo) ^ "\n")
      ; print ("bar: " ^ Int.toString (!bar) ^ "\n")
      ; print ("baz: " ^ Bool.toString (!baz) ^ "\n")
      ; List.app (fn s => print ("Non-option arg: " ^ s ^ "\n")) nonopts
      )
  | _ => (List.app print errors; print "\n"; bad_usage ())
