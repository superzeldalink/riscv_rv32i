MEMORY
{
  IMEM (rx)  : ORIGIN = 0x00000000, LENGTH = 8K
  DMEM (rwx) : ORIGIN = 0x10000000, LENGTH = 2K
}

ENTRY(_start)

SECTIONS
{
  /* Force instructions to start at 0x0 */
  .text :
  {
    . = ORIGIN(IMEM);

    KEEP(*(.text._start))   /* put _start exactly first */
    KEEP(*(.init))
    KEEP(*(.text.main))     /* optional: ensure main comes early */
    *(.text*)               /* everything else */
    KEEP(*(.fini))
  } > IMEM

  .rodata : { *(.rodata*) } > DMEM
  .data   : { *(.data*)   } > DMEM
  .bss (NOLOAD) : { *(.bss*) *(COMMON) } > DMEM

  .stack (NOLOAD) :
  {
    . = ORIGIN(DMEM) + LENGTH(DMEM);
    _stack_top = .;
  } > DMEM
}
