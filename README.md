# JangoSteve's dotfiles

These are my dotfiles. The structure and method for keeping track of
these was inspired largely by
[ryanb](https://github.com/ryanb/dotfiles) and [holman](https://github.com/holman/dotfiles), but with some modifications.

## Organization and naming

All my dotfiles go somewhere in my home folder `~/` (on Mac OSX). I
wanted a simple way to keep track of these files that didn't make too
many assumptions about the files' target names or locations (for
example, I didn't want to automatically assume that they'd all start
with a dot). This led to the conventions I made up.

## Naming conventions

Anything in the `home` folder of this project will be symlinked by the
install script to your actual home folder (stored in `ENV['HOME']`) in
the same relative location it exists in this project to the `/home`
folder, with one modification.

It was hard to browse my dotfiles in this repo with them all starting
with a `.`, so within this repo, I changed them to start with `_.`
instead. Anywhere you see `_.` in directory and filenames within the
`/home` folder,
will be replaced with just a `.` in the target destination.

## Installation

1. `git clone git://github.com/JangoSteve/dotfiles.git`
2. `cd dotfiles`
3. `rake install`
