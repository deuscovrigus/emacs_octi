SITE_PACKAGE_DIR:=$(shell python -m site --user-site)

all: emacs elpy

elpy:
	pip3 install -r https://raw.githubusercontent.com/jorgenschaefer/elpy/master/requirements3.txt

emacs:
	emacs  --batch --load packages.el --eval "(install-packages)"
