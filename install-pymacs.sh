#!/usr/bin/env bash

# Install pymacs stuff that emacs needs (outside emacs)

pip install rope ropemacs --user python
pip install -e "git+https://github.com/pinard/Pymacs.git#egg=Pymacs"
echo $VIRTUAL_ENV
cd src
cd pymacs/
make
cd ../..
echo "Finished in:" $(pwd)
cd
python -c 'import Pymacs'
