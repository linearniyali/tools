#!/bin/bash
#
# Get the current gold price
# and send an notification if the price exceed the expected selling price.
#

re='^[0-9]+$'
notified_email=$1
selling_price=$2

display_usage() {
    echo -e "\nUsage: $0 [notified_email] [selling_price]\n"
}

# if no two arguments supplied, display usage
if [  $# -ne 2 ]
then
    display_usage
    exit 1
fi

# check whether user had supplied -h or --help . If yes display usage
if [[ ( $# == "--help") ||  $# == "-h" ]]
then
    display_usage
    exit 0
fi

# get the current gold price
price=$(curl -s https://rate.bot.com.tw/gold/chart/ltm/TWD | grep text-right | awk -F">" '{print $2}' | awk -F"<" '{print $1}'      | sed -n 1p)

# if the price isn't a number, then set it to 0
if ! [[ $price =~ $re  ]]; then
    price=0;
else
    echo "It's $price now."
fi

if [ "$price" -gt "$selling_price" ]; then
    echo "It's $price now. \nSell it" | mail -s "Sell it!" $notified_email
fi
