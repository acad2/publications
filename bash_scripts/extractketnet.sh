origin=$(wget -S -O - "$1" 2> /dev/null | grep "\"file\":" | cut -s -f4 -d'"' | head -n 1)
streamer=$(wget -S -O - "$1" 2> /dev/null | grep "\"streamer\":" | cut -s -f4 -d'"' | head -n 1)
if [ $# -lt 2 ]
then
  title=$(wget -S -O - "$1" 2> /dev/null | grep "\"title\":" | cut -s -f4 -d'"' | head -n 1)
  title="$title.flv"
  echo "$title"
else
  title=$2
fi
rtmpdump -r "$streamer" --playpath "$origin" --live --buffer 36000000 -o "$title"
