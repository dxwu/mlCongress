#!/bin/bash
#
# Script name: get_texts.sh [passfiles] [failfiles]
#           ex: ./get_texts.sh pass105.txt pass106.txt fail105.txt fail106.txt
#
# Description: Extracts and separates most recent versions of bill
# texts into different directories
#
# Input: Text files containing lists of urls that correspond to bills on govtrack.us
#
# Output: Directories containing the most recent versions of bill texts
#         If the files are named passN.txt failN.txt where N is the number of congress,
#         the directories will be named "pass" "fail"


# get current location
loc=`pwd`

function get_text 
{
    # make directory from file name
    dirName=`echo $1 | cut -d'.' -f1 | sed 's/[0-9]*//g'`
    mkdir ${loc}/../${dirName}

    # read each line of text file
    while read line
    do
        # reset most recent date
        newest=`gdate -d"1900-01-01" +%y%m%d`

        # parse url into array containing bill information
        substr=`grep -o 'bills/.*' <<< $line`
        IFS="/" read -ra txtInfo <<< "$substr"

        cong=${txtInfo[1]}      # congress number
        bill=${txtInfo[2]}      # bill type and number
        typ=${bill//[!A-z]/}    # bill type

        # text locations base url
        dirURL="../Congress/${cong}/bills/${typ}/${bill}/text-versions"

        # look at each version of text
        for ver in $(find ${loc}/${dirURL}/* -type d)
        do
            # get text date
            issued=`cat $ver/data.json | grep "issued_on" | cut -d':' -f2 | sed s/[\",]//g`
            issued=`gdate -d"${issued}" +%y%m%d`

            # compare date to most recent text date
            # store the more recent of the two
            if [ $issued -gt $newest ]
            then
                newest=$issued
                docType=$ver
            fi
        done

        # create bill text document in appropriate directory
        cat ${docType}/document.txt > ${loc}/../${dirName}/${bill}.txt

    done < $1   
}

# get texts for each text file given
for file in "$@"
do
    get_text "$file"
done

exit 0
