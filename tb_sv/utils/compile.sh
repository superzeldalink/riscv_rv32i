#!/bin/bash

# Simple C to RV32I pipeline script
# Usage: ./compile_rv32i.sh <input.c>

if [ $# -ne 1 ]; then
    echo "Usage: $0 <input.c>"
    exit 1
fi

INPUT_FILE=$1
BASE_NAME=$(basename "$INPUT_FILE" .c)
GCC_ARGS=

# Check if input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: File '$INPUT_FILE' not found"
    exit 1
fi

echo "Compiling $INPUT_FILE to RV32I..."

# Step 1: Compile C to RISCV assembly
echo "Step 1: Generating assembly..."
riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -T ${RV32I_HOME}/tb/utils/linker.ld -ffreestanding -nostdlib ${GCC_ARGS} -S -o "${BASE_NAME}.s" "$INPUT_FILE"
if [ $? -ne 0 ]; then
    echo "Error in compilation step"
    exit 1
fi

# Step 2: Assemble to object file (use -m32 for 32-bit)
echo "Step 2: Assembling..."
riscv64-unknown-elf-as -march=rv32i -o "${BASE_NAME}.o" "${BASE_NAME}.s"
riscv64-unknown-elf-as -march=rv32i -o start.o ${RV32I_HOME}/tb/utils/start.s
if [ $? -ne 0 ]; then
    echo "Error in assembly step"
    exit 1
fi

# Step 3: Link to executable (specify emulation for 32-bit)
echo "Step 3: Linking..."
riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 \
    -ffreestanding -nostdlib \
    -T ${RV32I_HOME}/tb/utils/linker.ld \
    -o "${BASE_NAME}.elf" "${BASE_NAME}.o" start.o -lgcc
if [ $? -ne 0 ]; then
    echo "Error in linking step"
    exit 1
fi

# Step 4: Generate instruction memory (IMEM) hex
echo "Step 4: Generating IMEM hex..."
riscv64-unknown-elf-objcopy -O binary --only-section=.text "${BASE_NAME}.elf" text.bin
hexdump -v -e '1/4 "%08x" "\n"' text.bin > imem.hex

# Step 6: Generate data memory (DMEM)
echo "Step 6: Generating DMEM hex..."

riscv64-unknown-elf-objcopy -O binary \
  --only-section=.rodata \
  --only-section=.data \
  --only-section=.sdata \
  "${BASE_NAME}.elf" dmem.bin
hexdump -v -e '1/4 "%08x" "\n"' dmem.bin > dmem.hex

# Optional: allocate space for .bss (zeroed)
# dd if=/dev/zero bs=1 count=1024 >> dmem.bin 2>/dev/null

hexdump -v -e '1/4 "%08x" "\n"' "dmem.bin" > "dmem.hex"
 
# rm text.bin dmem.bin imem.bin ${BASE_NAME}.elf ${BASE_NAME}.o ${BASE_NAME}.bin

echo ""
echo "Pipeline complete!"
echo "Generated files:"
echo "  Assembly:     ${BASE_NAME}.s"
echo "  IMEM Hex:     imem.hex"
echo "  DMEM Hex:     dmem.hex"

# Clean up intermediate files (optional)
# rm -f "${BASE_NAME}.s" "${BASE_NAME}.o" "${BASE_NAME}.elf" "${BASE_NAME}.bin" "text.bin" "${BASE_NAME}_data.bin" "dmem.bin"