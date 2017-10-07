.PHONY: build clean

ML_FILES 		   = $(shell find . -type f -maxdepth 1 -name "*.ml")
BYTECODE_FILES = $(ML_FILES:%.ml=%.byte)
NATIVE_FILES   = $(ML_FILES:%.ml=%.native)

FLAGS 		 = -g,-thread
OCAMLBUILD = ocamlbuild \
						 -cflags $(FLAGS) \
						 -lflags $(FLAGS) \
						 -use-ocamlfind

build:
		$(OCAMLBUILD) $(NATIVE_FILES)
		$(OCAMLBUILD) $(BYTECODE_FILES)

clean:
	rm -f $(NATIVE_FILES) $(BYTECODE_FILES)

distclean: clean
	rm -rf _build
