#!/bin/sh

getLocales()
{
    FILES=/usr/share/i18n/locales/*
    for FILE in $FILES
    do
        CODE=$(basename $FILE)
        LANG=$(awk -F\" '/^[ ]*language/ { gsub(/ /, "_", $2); print $2; } ' $FILE)
        TERRITORY=$(awk -F\" '/^[ ]*territory/ { gsub(/ /, "_", $2); print $2; } ' $FILE)
        OPTION=$(echo $CODE | awk -F@ '{ if($2) { print "(" $2 ")"; } } ')
        if [ "$LANG" != "" -a "$TERRITORY" != "" ]
        then
            echo "$CODE $LANG/$TERRITORY$OPTION off "
        fi
    done
}

getZones()
{
    while read line; do
        ZONE=$(echo $line|awk '/^[A-Z]/ {print $3;}')
        if [ "$ZONE" != "" ]
        then
            echo "$ZONE $ZONE off "
        fi
    done < "/usr/share/zoneinfo/zone.tab"
}

getLocale()
{
    echo "Getting locales..."
    LOCALES=$(getLocales|sort)
    tempfile=/tmp/freepto-locale

    rm $tempfile
    dialog --title "Select locale" --radiolist "Select the Freepto locale:" 0 0 0 $LOCALES 2> $tempfile
    LOCALE=$(cat $tempfile)
    echo "$LOCALE"
}

getZone()
{
    ZONES=$(getZones|sort)
    dialog --title "Select zone" --radiolist "Select the Freepto zone:" 0 0 0 $ZONES

}

getLocales > locales
getZones > zones
