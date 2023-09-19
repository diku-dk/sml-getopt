# Command line option parsing for Standard ML

This is an SML library for parsing command line options, in the style
of `getopt`.  It is designed to make it possible to fully follow
modern command line option conventions, as described in the GNU
[Standards for Command Line
Interfaces](https://www.gnu.org/prep/standards/html_node/Command_002dLine-Interfaces.html).
At the same time, it is rather flexible in how can interpret the
provided options.  This flexibility does make it a little cumbersome
in some cases (see examples below), but your users will likely
appreciate the consistency with other programs.

The implementation is based on [a Haskell library by Sven
Panne](https://hackage.haskell.org/package/base/docs/System-Console-GetOpt.html).

## Overview of MLB files

* `lib/github.com/diku-dk/sml-getopt/getopt.mlb`

  - signature [`GETOPT`](lib/github.com/diku-dk/sml-getopt/getopt.sig)
  - structure `GetOpt :> GETOPT`

## Examples

[See here](examples/)
