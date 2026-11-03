# Weather icons for the bash prompt, plus a `weather` forecast command.
# Data from https://wttr.in (no API key). Location is guessed from your IP;
# set WEATHER_LOCATION (zip, city, or airport code) to pin it.
#
# The prompt never waits on the network: weather_status reads a cache file,
# and refreshes it in the background when it's more than 30 minutes old.
#
# U+2600	☀	e2 98 80	BLACK SUN WITH RAYS
# U+2601	☁	e2 98 81	CLOUD
# U+2602	☂	e2 98 82	UMBRELLA
# U+2603	☃	e2 98 83	SNOWMAN
# U+2604	☄	e2 98 84	COMET
# U+2605	★	e2 98 85	BLACK STAR
# U+2606	☆	e2 98 86	WHITE STAR
# U+2607	☇	e2 98 87	LIGHTNING
# U+2608	☈	e2 98 88	THUNDERSTORM
# U+2609	☉	e2 98 89	SUN
# U+2614	☔	e2 98 94	UMBRELLA WITH RAIN DROPS
#
# U+2744	❄	e2 9d 84	SNOWFLAKE
# U+2745	❅	e2 9d 85	TIGHT TRIFOLIATE SNOWFLAKE
# U+2746	❆	e2 9d 86	HEAVY CHEVRON SNOWFLAKE
#
# U+263C	☼	e2 98 bc	WHITE SUN WITH RAYS
# U+263D	☽	e2 98 bd	FIRST QUARTER MOON
# U+263E	☾	e2 98 be	LAST QUARTER MOON

WEATHER_CACHE="${WEATHER_CACHE:-$HOME/.cache/weather_prompt}"

# Full forecast, e.g. `weather` or `weather 10001`
weather(){
  curl -s "https://wttr.in/${1:-$WEATHER_LOCATION}?u&F"
}

# Fetch current conditions and write "icon|temp" to the cache.
# wttr.in's %x gives a plain-text condition code; map it to a single-width
# symbol from the table above (emoji are double-width and break the fill).
weather_fetch(){
  local data code temp sunrise sunset now icon
  data=$(curl -s -m 10 "https://wttr.in/${WEATHER_LOCATION}?format=%x|%t|%S|%s|%T&u") || return
  IFS='|' read -r code temp sunrise sunset now <<< "$data"
  temp=${temp//[^0-9-]/}
  [[ -n $code && -n $temp ]] || return

  case "$code" in
    o)               icon="☀" ;;
    m)               icon="☼" ;;
    mm|mmm)          icon="☁" ;;
    =)               icon="≡" ;;
    *!*)             icon="☈" ;;
    \**)             icon="❄" ;;
    x*)              icon="❅" ;;
    /*|.)            icon="☂" ;;
    *)               icon="?" ;;
  esac

  # Clear sky after dark gets a moon instead of a sun. %T is the location's
  # local time (e.g. "13:32:50-0500"), so this works for any time zone.
  now=${now:0:8}
  if [[ $icon == "☀" || $icon == "☼" ]] && [[ $now < $sunrise || $now > $sunset ]]; then
    icon="☾"
  fi

  mkdir -p "$(dirname "$WEATHER_CACHE")"
  echo "$icon|$temp" > "$WEATHER_CACHE.tmp" && mv "$WEATHER_CACHE.tmp" "$WEATHER_CACHE"
}

# Called from prompt_command (ps1.sh). Sets $weather to e.g. "☁ 72°" and
# $weather_width to its on-screen width. Only checks the cache's age every
# 5 minutes so most prompts cost no subprocesses.
weather_status(){
  local icon temp
  if (( SECONDS >= ${_weather_next_check:-0} )); then
    _weather_next_check=$(( SECONDS + 300 ))
    if [[ ! -f $WEATHER_CACHE || -n $(find "$WEATHER_CACHE" -mmin +30 2>/dev/null) ]]; then
      # Double fork so job control doesn't print "[1] 12345" / "Done"
      ( weather_fetch >/dev/null 2>&1 & )
    fi
  fi

  weather=""
  weather_width=0
  [[ -f $WEATHER_CACHE ]] || return 0
  IFS='|' read -r icon temp < "$WEATHER_CACHE"
  [[ -n $icon && -n $temp ]] || return 0
  weather="$icon ${temp}°"
  weather_width=$(( ${#temp} + 3 ))
}
