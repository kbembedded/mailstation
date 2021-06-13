#!/bin/bash

# SPDX-License-Identifier: BSD-2-Clause

# This script will take the first file with the name "*codeflash*.bin" in each
# subdirectory, split it in to 16 KiB pages, and disassemble each page using
# z80dasm.
# Aside from the first page of CF, which is hardwired to 0x0000 base, all of the
# other CF pages should only ever be mapped to 0x4000 base, aka slot4000.

for DIR in */; do
(
  cd "${DIR}" || exit
  mkdir disasm
  FILE=$(ls ./*codeflash*.bin | head -n 1)
  (
    cd disasm
    split -d -b 16384 --additional-suffix .bin "../${FILE}" page
  )
  echo "Disassembling $(basename ${FILE})"
  for I in $(seq -w 0 63); do
    #dd if="${FILE}" of=disasm/page"${I}".bin bs=16384 count=1 skip="${I}"
    echo -e "; vim: syntax=z8a" > disasm/page"${I}".s
    z80dasm -alt -g 0x4000 disasm/page"${I}".bin >> disasm/page"${I}".s >/dev/null 2>&1
  done
  echo -e "; vim: syntax=z8a" > disasm/page00.s
  z80dasm -alt -g 0x0 disasm/page00.bin >> disasm/page00.s >/dev/null 2>&1
)
done
