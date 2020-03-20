#!/bin/bash

# SPDX-License-Identifier: BSD-2-Clause
# Copyright (c) 2020 KBEmbedded

# Converts a TTF font file to a bitmap compatible with the Mailstation
# Uses Imagemagick for the conversion process
#
# Note that this may not work quite right without tuning arguments to 'convert'
# This script has only been used for the current fonts in this project
#
# Currently only generates standard ASCII symbols, the output include file only
# ends up with printable characters, starting with space " "
#
# Usage:
#   ttf_to_header.sh <fontfile.ttf> <width> <height>

if [ $# -ne 3 ]; then
  echo "Usage:"
  echo "  ${0} <fontfile.ttf> <width> <height>"
  echo ""
  echo "This script might need tuning for some font files. Be sure"
  echo "to test each character as it would be printed on the Mailstation."
  echo "Additional development may be needed to add support for a new font size"
  echo "if it does not currently exist. Similar sized fonts may not be drop-in"
  echo "compatible with existing fonts."
  echo ""
  echo "Note! This script passes to Imagemagick a size that is 1 px wider than the"
  echo "actual font width. This is because Imagemagick seems to add an additional"
  echo "column (maybe kerning? I'm not sure) that causes weird truncation of chars."
  echo "This could be problematic with fonts greater than 7 bits wide, but, I doubt"
  echo "that such a font would look good on the MS anyway."
  exit 1
fi

if [ ! -x "$(command -v convert)" ]; then
  echo "Error: convert is not available (is Imagemagick installed?)"
  exit 1
fi

(( WIDTHMOD=${2}+1 ))
OUTBIN=msfont_"${2}"x"${3}".bin
OUTH=msfont_"${2}"x"${3}".h
SIZE="${WIDTHMOD}"x"${3}"

rm "${OUTBIN}" >/dev/null 2>&1

for I in $(seq 32 126); do
	CHAR=$(printf "\x$(printf %x ${I})")
	if [ "${CHAR}" == "\\" ]; then CHAR="\\\\"; fi
	if [ "${CHAR}" == " " ]; then
		echo "HACK! The space character from TTF fonts ends up being all 1s rather than 0s."
		echo "  Writing ${3} bytes to output in place of space. Note! This hack is a hack!"
		if [ "${2}" -gt 8 ]; then
			echo "Hack! Cannot handle the space character hack for fonts wider than 8 bits. Failing"
			exit 1;
		fi
		dd if=/dev/zero bs=1 count="${3}" of=label.bin >/dev/null 2>&1
	else
		convert -font "${1}" -size "${SIZE}" -pointsize "${3}" -gravity center label:"${CHAR}" -monochrome MONO:label.bin
	fi
	cat label.bin >> "${OUTBIN}"
done

rm label.bin
rm "${OUTH}" >/dev/null 2>&1

echo "#ifndef __MSFONT_${2}X${3}_H__" >> "${OUTH}"
echo "#define __MSFONT_${2}X${3}_H__" >> "${OUTH}"

xxd -i "${OUTBIN}" | sed -e 's/unsigned char/const uint8_t/' -e 's/unsigned int/const uint16_t/' >> "${OUTH}"

echo "#endif //__MSFONT_${2}X${3}_H__" >> "${OUTH}"

rm "${OUTBIN}" >/dev/null 2>&1
