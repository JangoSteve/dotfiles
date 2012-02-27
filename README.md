# JangoSteve's dotfiles

These are my dotfiles. The structure and method for keeping track of
these was inspired largely by
[ryanb](https://github.com/ryanb/dotfiles) and [holman](https://github.com/holman/dotfiles), but with some changes.

## Installation

```
git clone git://github.com/JangoSteve/dotfiles.git
cd dotfiles
rake install
```

## Organization

All my dotfiles go somewhere in my home folder `~/`. I
wanted a simple way to keep track of these files that didn't make too
many assumptions about the files' target names or locations. For
example, I didn't want to automatically assume that they'd all start
with a dot. This led to the conventions I made up.

## Naming conventions

Anything in the `home` folder of this project will be symlinked by the
install script to your actual home folder (stored in `ENV['HOME']`). It
will go in the same relative location it is to the `/home`
folder, with one modification.

It was hard to browse my dotfiles in this repo with most of them being hidden,
so within this repo, they start with `_.` instead. Thus,
`/home/_.example/_.somefile` => `~/.example/.somefile`.

## ERB

There are some files, like `.giconfig`, that require specific credentials.
Inspired by ryanb's dotfiles, I
used erb to prompt the user to enter the required info when the install
script runs.
