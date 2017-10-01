.PHONY: build clean

ML_FILES 		   = $(shell find . -type f -maxdepth 1 -name "*.ml")
BYTECODE_FILES = $(ML_FILES:%.ml=%.byte)
NATIVE_FILES   = $(ML_FILES:%.ml=%.native)

FLAGS = -g,-thread
OCAMLBUILD = ocamlbuild \
						 -cflags $(FLAGS) \
						 -lflags $(FLAGS) \
						 -use-ocamlfind

BENCH_PATTERN ?= "hello"
BENCH_FILE ?= ./fixtures/hello-one-line.txt

bench:
	time rg $(BENCH_PATTERN) $(BENCH_FILE) > /dev/null
	time grep $(BENCH_PATTERN) $(BENCH_FILE) > /dev/null
	time ./pry.byte -a "sand" $(BENCH_PATTERN) $(BENCH_FILE) > /dev/null
	time ./pry.native -a "sand" $(BENCH_PATTERN) $(BENCH_FILE) > /dev/null

build:
		$(OCAMLBUILD) $(NATIVE_FILES)
		$(OCAMLBUILD) $(BYTECODE_FILES)

clean:
	rm -f $(NATIVE_FILES) $(BYTECODE_FILES)

distclean: clean
	rm -rf _build
