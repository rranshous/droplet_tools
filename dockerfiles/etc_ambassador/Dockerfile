FROM ubuntu

RUN apt-get update && apt-get install -y socat
CMD socat TCP4-LISTEN:4001,fork,reuseaddr TCP4:`route | grep default | tr -s " " | cut -d " " -f 2`:4001
