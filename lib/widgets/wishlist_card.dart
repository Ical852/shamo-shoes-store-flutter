import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/pages/product_page.dart';
import 'package:shamo/providers/wishlist_provider.dart';
import 'package:shamo/theme.dart';

class WishlistCard extends StatelessWidget {

  ProductModel product;
  WishlistCard(this.product);


  @override
  Widget build(BuildContext context) {

    WishListProvider wishlist = Provider.of<WishListProvider>(context);

    return GestureDetector(
      onTap: (){
        Navigator.push(
          context, MaterialPageRoute(
            builder: (context) => ProductPage(product)
          )
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.only(
          top: 12,
          left: 12,
          bottom: 12,
          right: 20 
        ),
        decoration: BoxDecoration(
          color: bgColor4,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product.galleries[0].url,
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
                    product.name,
                    style: primaryTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: semiBold
                    ),
                  ),
                  SizedBox(height: 2,),
                  Text(
                    "\$${product.price}",
                    style: priceTextStyle
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                wishlist.setProduct(product);
              },
              child: Image.asset(
                "assets/ic_love_btn.png",
                width: 34,
                height: 34,
              ),
            )
          ],
        ),
      ),
    );
  }
}