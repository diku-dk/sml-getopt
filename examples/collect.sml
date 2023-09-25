(* Collecting non-options based on surrounding options.

$ examples/collect --foo 1 2 3 --bar 4 5 6
Foo: 1 2 3
Bar: 4 5 6

 *)

datatype Opt =
  SET_FOO
| SET_BAR
| COLLECT of string

val options: Opt GetOpt.opt_descr list =
  [ { short = []
    , long = ["foo"]
    , arg = GetOpt.NO_ARG (fn () => SET_FOO)
    , desc = "Collect foos"
    }
  , { short = []
    , long = ["bar"]
    , arg = GetOpt.NO_ARG (fn () => SET_BAR)
    , desc = "Collect bars"
    }
  ]

val () =
  let
    val (opts, _, errors) =
      GetOpt.getopt (GetOpt.RETURN_IN_ORDER (fn s => COLLECT s)) options
        (CommandLine.arguments ())
  in
    if null errors then
      let
        fun get (COLLECT s :: _) =
          ( print ("Non-option " ^ s ^ " precedes --foo or --bar.\n")
          ; OS.Process.exit OS.Process.failure
          )
          | get (SET_FOO :: opts) =
            get_foos opts
          | get (SET_BAR :: opts) =
            get_bars opts
          | get [] = ([], [])
          and get_foos [] = ([], [])
            | get_foos (SET_FOO :: opts) = get_foos opts
            | get_foos (SET_BAR :: opts) = get_bars opts
            | get_foos (COLLECT s :: opts) =
              let val (foos, bars) = get_foos opts
              in (s :: foos, bars)
              end
          and get_bars [] = ([], [])
            | get_bars (SET_FOO :: opts) = get_foos opts
          | get_bars (SET_BAR :: opts) = get_bars opts
          | get_bars (COLLECT s :: opts) =
          let val (foos, bars) = get_bars opts
          in (foos, s :: bars)
          end
        val (foos, bars) = get opts
      in
        print ("Foo:" ^ concat (map (fn s => " " ^ s) foos) ^ "\n");
        print ("Bar:" ^ concat (map (fn s => " " ^ s) bars) ^ "\n")
      end
    else
      ( List.app print errors
      ; print (GetOpt.usage options)
      ; OS.Process.exit OS.Process.failure
      )
  end
