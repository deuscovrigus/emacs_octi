all: emacs pymacs

pymacs:
	cd ./lisp/plugins/Pymacs ; make

	# python pppp -C ppppconfig.py Pymacs.py.in pppp.rst.in pymacs.el.in pymacs.rst.in contrib tests
	# python setup.py --quiet build

python-mode:
	chmod 755 ./lisp/plugins/python-mode/byte-compile-directory.sh
	cd ./lisp/plugins/python-mode; ./byte-compile-directory.sh
emacs:
	emacs  --batch --load packages.el --eval "(install-packages)"
