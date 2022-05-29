#!/bin/bash

#currently just making a simple file in another cases we can take tag and revision number from user which are hardcoded right now
PAYMENT_DIR=$PWD/payment-provider
INVOICE_DIR=$PWD/invoice-app

function image_exists_payment () {
  image_payment=$(docker images vpts/payment-provider11 -q)	
  if [ "$image_payment" ]; then
    return 0;
  else
    return 1;
  fi
}

function image_exists_invoice () {
  image_invoice=$(docker images vpts/invoice-app11 -q)

  if [ "$image_invoice" ]; then
    return 0;
  else
    return 1;
  fi
}

function build_image () {
  docker build -t $1 -f $2 .
}

if image_exists_payment
then
  # Do nothing.
  echo "Local image already exist. Skip build.\n"
  true;
else
  echo "Start building Image"
  build_image vpts/payment-provider:latest1 $PAYMENT_DIR/Dockerfile
fi

if image_exists_invoice
then
  # Do nothing.
  echo "Local image already exist. Skip build.\n"
  true;
else
  echo "Start building Image"
  build_image vpts/invoice-app:latest1 $INVOICE_DIR/Dockerfile
fi


