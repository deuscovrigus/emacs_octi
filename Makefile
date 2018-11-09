SITE_PACKAGE_DIR:=$(shell python -m site --user-site)

all: emacs pymacs

pymacs:
	@echo $(SITE_PACKAGE_DIR)
	cd ./lisp/plugins/Pymacs ; make
	cp ./lisp/plugins/Pymacs/Pymacs.py $(SITE_PACKAGE_DIR)


python-mode:
	@echo $(SITE_PACKAGE_DIR)
	chmod 755 ./lisp/plugins/python-mode/byte-compile-directory.sh
	cp ./lisp/plugins/python-mode/completion/pycomplete.py $(SITE_PACKAGE_DIR)
	cd ./lisp/plugins/python-mode; ./byte-compile-directory.sh
emacs:
	emacs  --batch --load packages.el --eval "(install-packages)"
