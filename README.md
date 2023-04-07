These are my dotfiles.  There are many like them, but these are mine.

They're set up for elaborate color prompts, bash, zsh, emacs, python
and git, and work on Linux (Ubuntu, Debian, possibly Fedora, Mint) and
macOS.  Parts of them probably originated on a 4.2bsd VAX 11/780 and a
3b2 running System V in the early 80s, but like Abe Lincoln's axe, the
handle has been replaced three times and the head twice.

# Installing

`./setup.sh && make`

Any existing (non-symlink) dotfiles will be set aside and symbolic
links will be created that point to these dotfiles.  So keep them
checked out.  "make clean" will delete emacs cruft in this directory.
"make really-clean" will delete the set aside files from your home
directory, PLUS any emacs cruft in this directory.

To install on macOS, you'll need to install the XCode command line
tools, but I usually already have XCode installed.  Sometimes the
script will seem to hang as it pops up the UI for accepting the XCode
EULA.


# Notes

`Setup.sh && make` should be "idempotent," i.e., you should be able to
run them as often as you like without breaking anything.

I want to install emacs 28 everywhere to avoid flapping of `(quote`
vs. `'` in emacs lisp files.

Now that setup.sh can check for previously installed packages, I'm
kind of moving away from installing stuff with the Makefile and just
having setup.sh install everything.
