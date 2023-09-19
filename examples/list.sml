(* This example simply stores all the options in a key-value list,
which can then be parsed later if desired.*)

val options : ((string*string) GetOpt.opt_descr) list =
  [ { short = [#"a"]
    , long = []
    , arg = GetOpt.NO_ARG (fn () => ("a", "blank"))
    , desc = "a option"
    }
  , { short = [#"b"]
    , long = []
    , arg = GetOpt.REQ_ARG (fn s => ("b", s), "STRING")
    , desc = "b option"
    }
  , { short = [#"c"]
    , long = []
    , arg = GetOpt.OPT_ARG (fn NONE => ("c", "blank") | SOME s => ("c", s), "STRING")
    , desc = "c option"
    }
  ]

val (opts, nonopts, errors) =
  GetOpt.getopt GetOpt.REQUIRE_ORDER options (CommandLine.arguments ())

fun err s = TextIO.output (TextIO.stdErr, s)

val () =
  case errors of
    [] =>
      ( List.app (fn (x,y) => print ("Option " ^ x ^ ": " ^ y ^ "\n")) opts
      ; List.app (fn s => print ("Non-option arg: " ^ s ^ "\n")) nonopts
      )
  | _ =>
      ( List.app err errors
      ; err "\n"
      ; err (GetOpt.usage options)
      ; OS.Process.exit OS.Process.failure
      )
