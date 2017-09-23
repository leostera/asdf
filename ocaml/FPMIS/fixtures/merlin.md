This page regroups all the information required to "configure" your projects,
i.e. inform Merlin about the structure of your projects.

hello

## Basic configuration

N.B. this section is a reminder of information already present in the wiki pages
[vim from scratch](vim-from-scratch) and [emacs from
scratch](emacs-from-scratch).

### Source path

If the files of your project are spread among several directories, you will need
to tell Merlin where to find them; you can do that with the `S` directive in
your `.merlin` file.

For example:

``` S parsing S typing ```

will add the `parsing` and `typing` directories to the source path of Merlin.
That will allow you to use the commands `merlin-switch-to-ml[i]` in emacs and
`:ML[I]` in vim.

#### Globbing in path

Usage of [glob](http://en.wikipedia.org/wiki/Glob_(programming)) expressions is
allowed in paths. You can for instance type `S src/*` to add immediate
subdirectories.

`S src/**` is also supported and will recursively add all subdirectories.

### Build path

For Merlin to be able to give you the type of identifiers or to offer completion
from other file of your projects, it needs to know where to find the cmi files
of the other modules of your project. You can use the `B` directive for that.

For example:

``` B _build/parsing B _build/typing ```

Globbing also works for build paths, for instance `B _build/*`.

### Packages

To use a findlib package you only need to use the `PKG` directive followed by
one or more package names.  For example:

``` PKG lwt lwt.unix ```

### Syntax extensions

As said in the other guides, Merlin has specifics support for syntax extensions,
however not all are enabled by default. Those which aren't enabled are the ones
introducing new keywords.  For the moment these extensions are:

- lwt (camlp4 extension) - meta (MetaOCaml dialect)

You can use the directive `EXT` in your .merlin to selectively activate these
extensions.  For example: `EXT lwt`.

Note: nowadays, PPX are the preferred way to extend the language. They can be
specified like any other package or using `FLG -ppx path-to-executable`. Other
syntax extensions are deprecated and may disappear soon.

## The FLG directive

The FLG directive allow you to activate flags like you would when calling Merlin
directly from the command line; i.e. adding `FLG -rectypes` will cause Merlin to
be launched with the `-rectypes` flag.

You can get a full list of flags (and their meaning) by calling `ocamlmerlin
-help`.

## The REC directive

The `REC` directive will continue search of `.merlin` files in parent
directories.  This is useful to map project configuration to the directory
structure of a project.

For instance consider this hierarchy: ``` ./.merlin            # no REC
./lib/.merlin        # with REC ./lib/first/.merlin  # with REC
./lib/second/.merlin # with REC ./src/.merlin        # with REC ```

where `./lib/.merlin`, `./lib/first/.merlin`, `./lib/second/.merlin` and
`./src/.merlin` contain a `REC` directive (on its own line).

Files in: - `./` will be edited with only `./.merlin` configuration active, -
`./src` will be edited with both `./.merlin` and `./src/.merlin` active, -
`./lib/first` will be edited with `./.merlin`, `./lib/.merlin` and
`./lib/first/.merlin` active, - …

## (Deprecated) The PRJ directive

The `PRJ name` directive was once added to enable edition of different projects
at the same time in Merlin.  Some state had to be isolated when editing
different and potentially conflicting files in one instance of Merlin.  The
`PRJ` directive takes as argument a key indexing global state.

When editing ml files configured by different `.merlin` files with the same
`PRJ` key, they would all be loaded in the same namespace.  The `PRJ` directive
is now deprecated. Instead, the path of the `.merlin` file is used as the key.
