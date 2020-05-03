#!/bin/bash
echo "cd to basedir";
cd "/content/drive/My Drive/FakeImageDetector/data/manipulated_sequences/Face2Face/c23/";

videodir="./videos/"

echo "VideoDir: $videodir";

for entry in $(find $videodir -name "*mp4"); do
  echo "Processing entry $entry";
  let length=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 $entry | perl -nl -MPOSIX -e 'print ceil($_);')
  for second in $(seq 0 2 $length); do
  	mkdir -p  $(dirname "$entry")/../images/;
    ffmpeg -accurate_seek -ss $second -i $entry -frames:v 1 $(dirname "$entry")/../images/$(basename "$entry" .mp4)_$second.bmp
  done
done