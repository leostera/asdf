WATS=$(shell find . -name "*.wat")
WASM=$(WATS:%.wat=%.wasm)

all: $(WASM)

%.wasm: %.wat
	wat2wasm $< -o $@

clean:
	rm $(WASM)
