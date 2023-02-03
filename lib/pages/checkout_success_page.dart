import 'package:flutter/material.dart';
import 'package:shamo/theme.dart';

class CheckoutSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: bgColor1,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Checkout Success",
          style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
        ),
      );
    }

    Widget content() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/ic_empty_cart.png",
              width: 80,
              height: 69,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "You made a transaction",
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              width: 190,
              child: Text(
                "Stay at home while we prepare your dream shoes",
                style: secondaryTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/home", (route) => false);
                },
                child: Text(
                  "Order Other Shoes",
                  style: primaryTextStyle.copyWith(
                      fontSize: 16, fontWeight: medium),
                )),
            SizedBox(
              height: 12,
            ),
            TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Color(0xff39374B),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                onPressed: () {},
                child: Text(
                  "View My Order",
                  style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                      color: Color(0xffB7B6BF)),
                ))
          ],
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      backgroundColor: bgColor3,
      body: content(),
    );
  }
}