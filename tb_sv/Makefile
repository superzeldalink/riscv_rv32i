PRG ?= fibonacci
VER ?= pipelined

# Target executable
TARGET = simv

# Set the number of threads to use for parallel compilation (2 * cores)
CORES = $(shell getconf _NPROCESSORS_ONLN)
THREADS = $(shell echo $$((2 * $(CORES))))

# VCS flags
VCSFLAGS = -full64 -sverilog -kdb -debug_access+all -debug_all -debug_acc+pp+fsdb +lint=all,noVCDE +warn=all -j$(THREADS) \
		-deraceclockdata -timescale=1ns/1ps +v2k +define+SIMULATION
COMMON_FLAGS +=

# Simulator
SIM = vcs

# Altera FPGA library files (for simulation)
INC_V = 
INC_V_FLAGS = $(addprefix -v , $(INC_V))
INC_SV =
INC_SV_FLAGS = $(addprefix -v , $(INC_SV))

# Verilog and SystemVerilog source files directory
SRC_DIR := .

# Output filelist
FILELIST := -f filelist.f -f ${RV32I_HOME}/src/filelist_$(VER).f

cp:
	cp test_programs/$(PRG)/imem.hex ./ 2>/dev/null || :
	cp test_programs/$(PRG)/dmem.hex ./ 2>/dev/null || :
	cp test_programs/$(PRG)/tb.sv ./ 2>/dev/null || :
	cp test_programs/$(PRG)/imem.hex ../quartus/ 2>/dev/null || :
	cp test_programs/$(PRG)/dmem.hex ../quartus/ 2>/dev/null || :

prep_tb:
	@sed -i 's/single_cycle/$(VER)/g' tb.sv
	@sed -i 's/pipelined/$(VER)/g' tb.sv

build : prep_tb $(SRC)
	$(SIM) $(VCSFLAGS) $(INC_V_FLAGS) $(INC_SV_FLAGS) $(FILELIST) -o $(TARGET)

lint:
	$(SIM) test_top -lint+all $(INC_V_FLAGS) $(INC_SV_FLAGS) $(ALL_VERILOG_FILES) $(SRC)

sim: build
	./$(TARGET)

wave-vcd:
	gtkwave top.vcd

wave-fsdb:
	verdi -dbdir simv.daidir/ -ssf top.fsdb

clean :
	-rm -r csrc
	-rm -r DVEfiles
	-rm -r verdiLog
	-rm -r vfastLog
	-rm $(TARGET)
	-rm -r $(TARGET).daidir
	-rm ucli.key
	-rm top.fsdb
	-rm top.vcd
	-rm top.vcd.fsdb
	-rm novas.conf
	-rm novas.rc
	-rm inter.fsdb

run: build sim
all: build sim wave-fsdb

# Specify phony targets (targets that are not files)
.PHONY: clean generate_filelist lint
