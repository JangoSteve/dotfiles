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

# Based on code by Crouse at www.bashscripts.org

weather(){

 local zip=$1
 php -r '$xml = simplexml_load_file("http://api.wunderground.com/auto/wui/geo/ForecastXML/index.xml?query='${zip}'"); foreach($xml->txt_forecast->forecastday as $weather){ echo "{$weather->title}: "; echo $weather->fcttext; echo PHP_EOL . PHP_EOL;}' 

}

weather () { 
    elinks -dump "google.com/search?hl=en&q=weather+${1:-munich}" | sed -n '/Weather for/,${/Weather/{s/^ *//;s/-.*//;};/iGoogle/d;s/|.*//;p;/Humidity/q;}'
}
