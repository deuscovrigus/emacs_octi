pymacs:
	cd ./lisp/plugins/Pymacs
	make install
all:
	emacs -e "(progn (package-initialize)(package-install 'auctex))"
	emacs -e "(progn (package-initialize)(package-install 'jedi))"
	emacs -e "(progn (package-initialize)(package-install 'magit))"
	emacs -e "(progn (package-initialize)(package-install 'zenburn-theme))"
