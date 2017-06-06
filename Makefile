SITE_PACKAGE_DIR:=$(shell python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()")

all: emacs pymacs

pymacs:
	cd ./lisp/plugins/Pymacs ; make
	cp ./lisp/plugins/Pymacs/Pymacs.py $(SITE_PACKAGE_DIR)
	@echo $(SITE_PACKAGE_DIR)

python-mode:
	chmod 755 ./lisp/plugins/python-mode/byte-compile-directory.sh
	cp ./lisp/plugins/python-mode/completion/pycomplete.py $(SITE_PACKAGE_DIR)
	cd ./lisp/plugins/python-mode; ./byte-compile-directory.sh
	@echo $(SITE_PACKAGE_DIR)
emacs:
	emacs  --batch --load packages.el --eval "(install-packages)"
