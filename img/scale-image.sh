#!/bin/sh
#
#  This will crop and scale the input image to be a 600x600 square.
#  The cropping will automagically center the image.
#  Assumes input files are 'prefix.ext' with no spaces, etc.
#  Output goes to 'prefix.scaled.jpg' (regardless of input suffix).
#
#  If run with no input file, will show the large images in the directory.
#
#  The 'magick' command is from https://imagemagick.org/ (also in homebrew).
#
for xx in $@ ; do
  if   [ -e "$xx" ] ; then
    pfx=$( echo $xx | cut -d. -f 1 )
    sfx=$( echo $xx | cut -d. -f 2 )

    if [ ! -e "$pfx.$sfx" ] ; then
      echo "Input '$xx' not prefix.suffix = '$pfx.$sfx'."
      exit 1
    fi

    magick $pfx.$sfx -resize 600x600^ -gravity center -extent 600x600 -quality 85 $pfx.scaled.jpg
    magick $pfx.$sfx -resize 600x600^ -gravity center -extent 600x600 -quality 85 $pfx.scaled.webp

  elif [ -z "$xx" ] ; then
    magick identify -format '%W x %H %m %i\n' *[gG] | awk '{ if (($1 > 600) || ($3 > 600)) { printf "%4dx%4d %6s  %s\n", $1, $3, $4, $5 }}'

  else
    echo "'$xx' not found."
  fi
done
