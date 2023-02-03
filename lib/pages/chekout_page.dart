import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/providers/auth_provider.dart';
import 'package:shamo/providers/cart_provider.dart';
import 'package:shamo/providers/transaction_provider.dart';
import 'package:shamo/theme.dart';
import 'package:shamo/widgets/checkout_cart.dart';
import 'package:shamo/widgets/loading_button.dart';

class CheckoutPage extends StatefulWidget {
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    TransactionProvider transactionProvider = Provider.of<TransactionProvider>(context);

    handleCheckout() async {
      setState(() {
        isLoading = true;
      });
      if (await transactionProvider.checkout(
          authProvider.user.token, 
          cartProvider.carts, 
          cartProvider.totalPricee()
      )) {
        cartProvider.carts = [];
        Navigator.pushNamed(context, "/checkout-success");
      }
      setState(() {
        isLoading = false;
      });
    }

    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: bgColor1,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Checkout Details",
          style: primaryTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium
          ),
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin
        ),
        children: [
          Container(
            margin: EdgeInsets.only(
              top: defaultMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "List Items",
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium
                  ),
                ),
                Column(
                  children: cartProvider.carts.map((cart) => CheckoutCard(cart)).toList(),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(
              top: defaultMargin
            ),
            decoration: BoxDecoration(
              color: bgColor4,
              borderRadius: BorderRadius.circular(12)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Address Details",
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          "assets/ic_store_location.png",
                          height: 40,
                          width: 40,
                        ),
                        Image.asset(
                          "assets/ic_line.png",
                          height: 30,
                        ),
                        Image.asset(
                          "assets/ic_your_address.png",
                          width: 40,
                          height: 40,
                        )
                      ],
                    ),
                    SizedBox(width: 12,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Store Location",
                          style: secondaryTextStyle.copyWith(
                            fontWeight: light,
                            fontSize: 12
                          ),
                        ),
                        SizedBox(height: 1,),
                        Text(
                          "Adidas Core",
                          style: primaryTextStyle.copyWith(
                            fontWeight: medium
                          ),
                        ),
                        SizedBox(height: 30,),
                        Text(
                          "Your Address",
                          style: secondaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: light
                          ),
                        ),
                        SizedBox(height: 1,),
                        Text(
                          "Marsemoon",
                          style: primaryTextStyle.copyWith(
                            fontWeight: medium
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 30
            ),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: bgColor4,
              borderRadius: BorderRadius.circular(12)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Payment Summary",
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium
                  ),
                ),
                SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Product Quantity",
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12
                      ),
                    ),
                    Text(
                      "${cartProvider.totalItem()} Items",
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium
                      ),
                    )
                  ],
                ),
                SizedBox(height: 13,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Product Price",
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12
                      ),
                    ),
                    Text(
                      "\$${cartProvider.totalPricee()}",
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium
                      ),
                    )
                  ],
                ),
                SizedBox(height: 13,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shipping",
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12
                      ),
                    ),
                    Text(
                      "Free",
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium
                      ),
                    )
                  ],
                ),
                SizedBox(height: 11,),
                Divider(
                  thickness: 1,
                  color: subTitleTextColor,
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: priceTextStyle.copyWith(
                        fontWeight: semiBold
                      ),
                    ),
                    Text(
                      "\$${cartProvider.totalPricee()}",
                      style: priceTextStyle.copyWith(
                        fontWeight: semiBold
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: defaultMargin,),
          Divider(
            thickness: 0.5,
            color: subTitleTextColor,
          ),
          isLoading ? Container(margin: EdgeInsets.only(bottom: defaultMargin),child: LoadingButton()) : Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              vertical: defaultMargin
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                padding: EdgeInsets.symmetric(
                  vertical: 13
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              ),
              onPressed: (){
                handleCheckout();
              },
              child: Text(
                "Checkout Now",
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold
                ),
              ),
            ),
          )
        ],
      );
    }

    return Scaffold(
      appBar: header(),
      backgroundColor: bgColor3,
      body: content(),
    );
  }
}