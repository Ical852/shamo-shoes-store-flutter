import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/providers/page_provider.dart';
import 'package:shamo/providers/wishlist_provider.dart';
import 'package:shamo/theme.dart';
import 'package:shamo/widgets/wishlist_card.dart';

class WishlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    PageProvider pageProvider = Provider.of<PageProvider>(context);

    WishListProvider wishlist = Provider.of<WishListProvider>(context);

    Widget header() {
      return Container(
        child: AppBar(
          backgroundColor: bgColor1,
          centerTitle: true,
          title: Text(
            "Favourite Shoes",
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: medium,
            ),
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
      );
    }

    Widget emptyWishlist() {
      return Expanded(
        child: Container(
          width: double.infinity,
          color: bgColor3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/ic_love.png",
                width: 74,
                height: 62,
              ),
              SizedBox(height: 23,),
              Text(
                "You don't have dream shoes?",
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium
                ),
              ),
              SizedBox(height: 12,),
              Text(
                "Let's find your favorite shoes",
                style: secondaryTextStyle,
              ),
              SizedBox(height: 20,),
              Container(
                height: 44,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 24
                    )
                  ),
                  onPressed: (){
                    pageProvider.currentIndex = 0;
                  }, 
                  child: Text(
                    "Explore Store",
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium
                    ),
                  )
                ),
              )
            ],
          ),
        )
      );
    }

    Widget content() {
      return Expanded(
        child: Container(
          color: bgColor3,
          child: ListView(
            padding: EdgeInsets.only(
              left: defaultMargin,
              right: defaultMargin,
              top: 10
            ),
            children: wishlist.wishlist.map((product) => WishlistCard(product)).toList(),
          ),
        )
      );
    }

    return Column(
      children: [
        header(),
        wishlist.wishlist.isNotEmpty ? content() : emptyWishlist()
      ],
    );
  }
}