# Command line option parsing for Standard ML [![CI](https://github.com/diku-dk/sml-getopt/workflows/CI/badge.svg)](https://github.com/diku-dk/sml-getopt/actions)

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

## Use of the package

This library is set up to work well with the SML package manager
[smlpkg](https://github.com/diku-dk/smlpkg).  To use the package, in
the root of your project directory, execute the command:

```
$ smlpkg add github.com/diku-dk/sml-getopt
```

This command will add a _requirement_ (a line) to the `sml.pkg` file in your
project directory (and create the file, if there is no file `sml.pkg`
already).

To download the library into the directory
`lib/github.com/diku-dk/sml-getopt`, execute the command:

```
$ smlpkg sync
```

You can now reference the `mlb`-file using relative paths from within
your project's `mlb`-files.

Notice that you can choose either to treat the downloaded package as
part of your own project sources (vendoring) or you can add the
`sml.pkg` file to your project sources and make the `smlpkg sync`
command part of your build process.

## Examples

[See here](examples/)
