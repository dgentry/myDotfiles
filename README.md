These are my dotfiles.  There are many like them, but these are mine.

They're set up for color, bash, emacs, rvm/ruby, python and git, and
seem to work on Linux (Ubuntu and Mint) and Mac OS X.  Parts of them
probably originated on a 4.2bsd VAX 11/780 and a 3b2 running System V
in the early 80s, but like Abe Lincoln's axe, the handle has been
replaced three times and the head twice.

To install, type "make".  Any existing (non-symlink) dotfiles will be
set aside and symbolic links will be created that point to these
dotfiles.  So keep them checked out.  "make clean" will delete emacs
cruft in this directory.  "make really-clean" will delete the set
aside files from your home directory, PLUS any emacs cruft in this
directory.

On raspbian, I needed to install at least:
nmap
emacs

On mac, I needed to install at least:
XCode
