PRG ?= fibonacci
BP ?= GSHARE
PR_BIT ?= 2
BTB_BIT ?= 1
VER ?= pipelined

# List all Verilog and SystemVerilog files in the directory
ALL_FILES := $(wildcard *.sv) $(wildcard *.v) $(wildcard ../src/$(VER).sv) $(wildcard ../src/$(VER)/*.sv) $(wildcard ../src/common/*.sv) $(wildcard ../src/$(VER)/stages/*.sv) $(wildcard ../src/$(VER)/regs/*.sv) $(wildcard ../src/$(VER)/predictor/*.sv)

# Exclude specific file(s) from the list
EXCLUDE_FILES := tb.sv
FILES := $(filter-out $(EXCLUDE_FILES), $(ALL_FILES))

VERILATOR = verilator
VERILATOR_COV = verilator_coverage

### LINT FLAGS
LINT_FLAGS = -Wall --lint-only -sv
LINT_FLAGS += -I../src/
LINT_FLAGS += -DSIMULATION
LINT_FLAGS += -D$(BP)
LINT_FLAGS += -Dpredict_bit=$(PR_BIT)
LINT_FLAGS += -Dbtb_bit=$(BTB_BIT)

### VERILATE FLAGS
# Generate C++ in executable form
VERILATOR_FLAGS += -I../src/
VERILATOR_FLAGS += -sv -cc
# Optimize
VERILATOR_FLAGS += -x-initial unique
VERILATOR_FLAGS += -x-assign unique
VERILATOR_FLAGS += -O3 -CFLAGS -DCOVERAGE
# Warn abount lint issues; may not want this on less solid designs
# VERILATOR_FLAGS += -Wall
# Enable assertion
VERILATOR_FLAGS += --assert
# Make waveforms
VERILATOR_FLAGS += --trace-fst
VERILATOR_FLAGS += --build -j
VERILATOR_FLAGS += -Wno-WIDTHTRUNC
VERILATOR_FLAGS += -DSIMULATION
VERILATOR_FLAGS += -D$(BP)
VERILATOR_FLAGS += -Dpredict_bit=$(PR_BIT)
VERILATOR_FLAGS += -Dbtb_bit=$(BTB_BIT)

# Input files for Verilator
VERILATOR_INPUT = $(FILES) --top-module $(VER)

.PHONY: cp
cp:
	cp test_programs/$(PRG)/imem.hex ./ 2>/dev/null || :
	cp test_programs/$(PRG)/dmem.hex ./ 2>/dev/null || :
	cp test_programs/$(PRG)/tb.cpp ./ 2>/dev/null || :
	cp test_programs/$(PRG)/imem.hex ../quartus/ 2>/dev/null || :
	cp test_programs/$(PRG)/dmem.hex ../quartus/ 2>/dev/null || :

.PHONY: lint
lint:
	@echo "<> LINT CHECK ----------------"
	@$(VERILATOR) $(LINT_FLAGS) $(FILES)

prep_tb:
	@sed -i 's/pipelined/$(VER)/g' tb.cpp

.PHONY: build
build: prep_tb ./obj_dir/V$(VER)
./obj_dir/V$(VER): $(FILES) tb.cpp ../src/$(VER).sv
	@echo "<> BUILD ---------------------"
	@$(VERILATOR) $(VERILATOR_FLAGS) $(VERILATOR_INPUT) --exe tb.cpp

.PHONY: sim
sim: ./obj_dir/V$(VER)
	@echo "<> SIMULATING ----------------"
	@./obj_dir/V$(VER)

.PHONY: wave
wave: wave.fst
	@echo "<> WAVEFORMS -----------------"
	@gtkwave wave.fst wave.gtkw

.PHONY: clean
clean:
	@rm -rf obj_dir
	@rm -f *.fst
	@rm -f *.vcd
	@rm -f *.log
	@rm -f *.hex
	@echo "<> CLEAN ---------------------"

.PHONY: fst2vcd
fst2vcd:
	@fst2vcd wave.fst > wave.vcd

.PHONY: all
all: build sim wave

.PHONY: br_analyze
br_analyze: fst2vcd
	@python3 analyze_branch.py
