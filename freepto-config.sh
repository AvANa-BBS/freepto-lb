#!/bin/bash
#set -x

tempfile=/tmp/freepto-config
trap "rm -f $tempfile" 0 1 2 5 15

usage() {
    cat <<EOF
$0 [-u username] [-f linux_flavours] [-l locale] [-z timezone] [-k keymap] [-h]
EOF
}

deleteTempFile()
{
    if [ -f $tempfile ]
        then rm $tempfile
    fi
}

getTempFile()
{
    if [ ! -f $tempfile ]
    then
        echo "Error: $tempfile not found."
        exit 1
    fi
    echo $(cat $tempfile)
}

# Set defaults values
USERNAME="paranoid"
LINUX_FLAVOURS="686-pae"
LOCALE="it_IT"
ZONE="Europe/Rome"
KEYMAP="it"

# Get config params
# If there's at least one arg, the UI dialog will not be lunched
if [ $# -gt 0 ]
then
    while getopts "u:f:l:z:k:h" OPT
    do
        case $OPT in
            h)
            usage
            exit 1
            ;;
            u)
            USERNAME="$OPTARG"
            ;;
            f)
            KERNEL="$OPTARG"
            ;;
            l)
            LOCALE="$OPTARG"
            ;;
            z)
            ZONE="$OPTARG"
            ;;
            k)
            KEYMAP="$OPTARG"
            ;;
        esac
    done
else
    # Get username
    while [ "$TMP_USERNAME" == "" ]
    do
        deleteTempFile
        dialog --title "Select username"  --inputbox "Enter the username that will be created in freepto:" 16 51 $USERNAME 2> $tempfile
        if [ "$?" -eq 1 ]; then exit 1; fi
        TMP_USERNAME=`getTempFile`
    done
    USERNAME=$TMP_USERNAME

    # Get kernel
    while [ "$TMP_LINUX_FLAVOURS" == "" ]
    do
        deleteTempFile
        dialog --title "Select kernel" --clear --radiolist "Select the linux flavours" 50 50 50 686-pae 686-pae off 486 486 off 2> $tempfile
        if [ "$?" -eq 1 ]; then exit 1; fi
        TMP_LINUX_FLAVOURS=`getTempFile`
    done
    LINUX_FLAVOURS=$TMP_LINUX_FLAVOURS

    # Get locale
    LOCALES=$(cat i18n/locales)
    while [ "$TMP_LOCALE" == "" ]
    do
        deleteTempFile
        dialog --title "Select locale" --clear --radiolist "Select the Freepto locale:" 50 50 50 $LOCALES 2> $tempfile
        if [ "$?" -eq 1 ]; then exit 1; fi
        TMP_LOCALE=`getTempFile`
    done
    LOCALE=$TMP_LOCALE

    # Get timezone
    ZONES=$(cat i18n/zones|sort)
    while [ "$TMP_ZONE" == "" ]
    do
        deleteTempFile
        dialog --title "Select zone" --clear --radiolist "Select the Freepto zone:" 50 50 50 $ZONES 2> $tempfile
        if [ "$?" -eq 1 ]; then exit 1; fi
        TMP_ZONE=`getTempFile`
    done
    ZONE=$TMP_ZONE

    # Get keymap
    KEYMAPS=$(cat i18n/keymaps|sort)
    while [ "$TMP_KEYMAP" == "" ]
    do
        deleteTempFile
        dialog --title "Select keymap" --clear --radiolist "Select the Freepto keymap:" 50 50 50 $KEYMAPS 2> $tempfile
        if [ "$?" -eq 1 ]; then exit 1; fi
        TMP_KEYMAP=`getTempFile`
    done
    KEYMAP=$TMP_KEYMAP

fi

# Show conf
cat << EOF
Used config
===========

Username        $USERNAME
Linux flavours  $LINUX_FLAVOURS
Locale          $LOCALE
Timezone        $ZONE
Keymap          $KEYMAP

EOF


# Run config!
lb config noauto \
    -a i386 \
    -b hdd \
    -d wheezy \
    --linux-flavours "$LINUX_FLAVOURS" \
    --security true \
    --apt-indices false \
    --mode debian \
    --memtest none \
    --source false \
    --backports true \
    --checksums sha256 \
    --system live \
    --apt-source-archives false \
    --debian-installer false \
    --debian-installer-gui false \
    --bootappend-install noprompt \
    --bootappend-live "\
    boot=live \
    config \
    noeject \
    persistence-encryption=luks \
    persistence-media=removable-usb \
    username=$USERNAME \
    hostname=freepto \
    user-fullname=$USERNAME \
    persistence \
    live-config.timezone='$ZONE' \
    live-config.locales=$LOCALE live-config.timezone=$ZONE live-config.keyboard-layouts=$KEYMAP \
    live-config.hooks=filesystem \
    " \
    --archive-areas "main contrib non-free" \
    --apt-recommends true


