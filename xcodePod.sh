#!/bin/bash

NEW_CHOOSE_FILE="# use_frameworks!"
FILENAME="Podfile"

function initTheFile()
{
    if test -e $FILENAME
    then
    echo "The $FILENAME is existing!"
    else
    pod init
    fi
}

function toWrite()
{
    echo "You write item is $searchItem"
    sed -i "" "/${NEW_CHOOSE_FILE}/a\ 
${searchItem}
" $FILENAME
    NEW_CHOOSE_FILE=$searchItem
}

function openTheXcodeFile()
{
    filepath=$(cd "$(dirname "$0")"; pwd)
    fileName=`echo $filepath|awk -F '/' '{print $NF}'`
    open -a xcode "${fileName}.xcworkspace" 
}

clear
echo "\\033[32mStar the shell!!!"
echo "************************************************"
echo "\\033[0m"
initTheFile
open -a xcode podfile
while :
    do
    echo "please input pod item name:"
    echo "For example: Masonry AFNetworking MJRefresh..."
    echo "********* exit: to quitShell!!! *********"
    echo "---------------------------------------------"
    read searchItem
        if [ $searchItem = "exit" ]
        then
        exit
        else
        pod search $searchItem
        echo "do you want writ to $FILENAME ?"
        echo "-- y|Y|yes|Yes|YES: to write!!!"
        echo "-- n|N|NO|no      : ont write!!!"
        echo "-- c|C            : custom to write!!!"
        read choose
           case $choose in
            y|Y|yes|Yes|YES)
            searchItem="pod '${searchItem}'"
            toWrite
            ;;
            n|N|NO|no)
            echo "You dont write item $searchItem"
            ;;
            c|C)
            echo "Write custom item to file"
            read fileName
            searchItem=$fileName
            toWrite
            ;;
            *) echo "error"
            ;;
            esac
                echo "Do you want install podfile?"
                echo "-- y|Y|yes|Yes|YES: to install!!!"
                echo "-- n|N|NO|no      : continue to write!!!"
                read isInstall
                case $isInstall in
                y|Y|yes|Yes|YES)
                pod install
                openTheXcodeFile
                echo "\\033[32mFinish the shell!!!"
                echo "************************************************"
                echo "\\033[0m"
                exit
                ;;
                *)
                ;;
                esac
            echo "---------------------------------------------"
        fi
done
