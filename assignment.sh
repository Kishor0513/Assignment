#!/bin/bash

while true; do
  clear
  echo "Welcome to the Sports Center Billing System"
  echo "------------------------------------------"
  echo "1. Jersey - NPR 1500"
  echo "2. Football - NPR 4000"
  echo "3. Shorts - NPR 1000"
  echo "4. Football Boots - NPR 3000"
  echo "------------------------------------------"
  read -p "Enter the product number (1-4): " product

  case $product in
    1)
      rate=1500
      discount_percent=10
      discount_quantity=3
      ;;
    2)
      rate=4000
      discount_percent=0
      discount_quantity=0
      ;;
    3)
      rate=1000
      discount_percent=15
      discount_quantity=0
      ;;
    4)
      rate=3000
      discount_percent=10
      discount_quantity=5
      extra_discount_percent=20
      ;;
    *)
      echo "Invalid product number. Please try again."
      sleep 2
      continue
      ;;
  esac

  read -p "Enter the Customer ID: " customer_id
  read -p "Enter the Customer Name: " customer_name
  read -p "Enter the quantity: " quantity

  total=$(($rate * $quantity))

  if [[ $product -eq 4 && $quantity -gt $discount_quantity ]]; then
    if [[ $quantity -gt 5 ]]; then
      discount_percent=$extra_discount_percent
    fi      
  elif [[ $product -eq 4 && $quantity -lt $discount_quantity ]]; then
    if [[ $quantity -lt 3 ]]; then
      discount_percent=0     
    fi  
  elif [[ $product -eq 1 && $quantity -lt $discount_quantity ]]; then
    discount_percent=0
  fi

  discount_amount=$(($total * $discount_percent / 100))
  discounted_total=$(($total - $discount_amount))
  tax=$(($discounted_total * 13 / 100))
  final_amount=$(($discounted_total + $tax))

  clear
  echo "Sports Center Bill"
  echo "-----------------"
  echo "Customer ID: $customer_id"
  echo "Customer Name: $customer_name"
  echo "Product: $product"
  echo "Quantity: $quantity"
  echo "Total Amount: NPR $total"
  echo "Discount: $discount_percent%"
  echo "Discounted Amount: NPR $discounted_total"
  echo "Tax (13%): NPR $tax"
  echo "Final Amount: NPR $final_amount"
  echo "-----------------"

  read -p "Do you want to create another bill? (Y/N): " choice

  if [[ $choice == "N" || $choice == "n" ]]; then
    break
  fi
done
