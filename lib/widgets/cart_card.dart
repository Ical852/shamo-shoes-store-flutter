import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/cart_model.dart';
import 'package:shamo/providers/cart_provider.dart';
import 'package:shamo/theme.dart';

class CartCartd extends StatelessWidget {

  CartModel cart;
  CartCartd(this.cart);

  @override
  Widget build(BuildContext context) {

    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Container(
      margin: EdgeInsets.only(
        top: defaultMargin
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10
      ),
      decoration: BoxDecoration(
        color: bgColor4,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  cart.product.galleries[0].url,
                  width: 60,
                  height: 60,
                ),
              ),
              SizedBox(width: 12,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cart.product.name,
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold
                      ),
                    ),
                    SizedBox(height: 2,),
                    Text(
                      "\$${cart.product.price * cart.quantity}",
                      style: priceTextStyle,
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      cartProvider.addQuantity(cart.id);
                    },
                    child: Image.asset(
                      "assets/add_btn.png",
                      width: 16,
                      height: 16,
                    ),
                  ),
                  SizedBox(height: 2,),
                  Text(
                    cart.quantity.toString(),
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium
                    ),
                  ),
                  SizedBox(height: 2,),
                  GestureDetector(
                    onTap: (){
                      cartProvider.reduceQuantity(cart.id);
                    },
                    child: Image.asset(
                      "assets/min_btn.png",
                      width: 16,
                      height: 16,
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 12,),
          GestureDetector(
            onTap: (){
              cartProvider.removeCart(cart.id);
            },
            child: Row(
              children: [
                Image.asset(
                  "assets/ic_trash.png",
                  width: 10,
                  height: 12,
                ),
                SizedBox(width: 4,),
                Text(
                  "Remove",
                  style: alertTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: light
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}