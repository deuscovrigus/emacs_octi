all: emacs pymacs
	git submodule update
pymacs:
	cd ./lisp/plugins/Pymacs
	make install
emacs:
	emacs  --batch --load packages.el --eval "(install-packages)"
