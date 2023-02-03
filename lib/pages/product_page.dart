import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/pages/detail_chat_page.dart';
import 'package:shamo/providers/cart_provider.dart';
import 'package:shamo/providers/wishlist_provider.dart';
import 'package:shamo/theme.dart';

class ProductPage extends StatefulWidget {

  ProductModel product;
  ProductPage(this.product);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  int currentIndex = 0;

  List images = [
    'assets/image_shoes.png',
    'assets/image_shoes2.png',
    'assets/image_shoes3.png',
  ];

  List familiarShoes = [
    'assets/other1.png',
    'assets/other2.png',
    'assets/other3.png',
    'assets/other4.png',
    'assets/other5.png',
    'assets/other6.png',
    'assets/other7.png',
  ];

  @override
  Widget build(BuildContext context) {

    WishListProvider wishlist = Provider.of<WishListProvider>(context);
    CartProvider cart = Provider.of<CartProvider>(context);

    Future<void> showSuccessDialog() async {
      return showDialog(
        context: context, 
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width - (2 * defaultMargin),
            child: AlertDialog(
              backgroundColor: bgColor3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: primaryTextColor,
                        ),
                      ),
                    ),
                    Image.asset(
                      "assets/ic_success.png",
                      height: 100,
                      width: 100,
                    ),
                    SizedBox(height: 12,),
                    Text(
                      "Hurray :)",
                      style: primaryTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: semiBold
                      ),
                    ),
                    SizedBox(height: 12,),
                    Text(
                      "Item added successfully",
                      style: secondaryTextStyle,
                    ),
                    SizedBox(height: 20,),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 24
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                        )
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/cart");
                      }, 
                      child: Text(
                        "View My Cart",
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium
                        ),
                      )
                    )
                  ],
                ),
              ),
            ),
          );
        }
      );
    }

    int index = -1;

    Widget indicator(int index) {
      return Container(
        height: 4,
        width: index == currentIndex ? 16 : 4,
        margin: EdgeInsets.symmetric(
          horizontal: 2
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: index == currentIndex ? primaryColor : Color(0xffC4C4C4)
        ),
      );
    }

    Widget header() {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 20,
              left: defaultMargin,
              right: defaultMargin
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.chevron_left,
                    size: 30,
                    color: bgColor1,
                  ),
                ),
                Icon(
                  Icons.shopping_bag,
                  color: bgColor1,
                )
              ],
            ),
          ),
          CarouselSlider(
            items: widget.product.galleries
              .map((image) => 
                Image.network(
                  image.url,
                  width: MediaQuery.of(context).size.width,
                  height: 310,
                  fit: BoxFit.cover,
                )
            ).toList(), 
            options: CarouselOptions(
              initialPage: 0,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              }
            )
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.product.galleries.map((e) {
              index++;
              return indicator(index); 
            }).toList(),
          )
        ],
      );
    }

    Widget familiarShoesContainer(String image, int index) {
      return Container(
        width: 54,
        height: 54,
        margin: EdgeInsets.only(
          right: 16,
          left: index == 0 ? 30 : 0
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          image: DecorationImage(
            image: AssetImage(image)
          )
        ),
      );
    }

    Widget content() {
      
      int index = -1;

      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 17),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24)
          ),
          color: bgColor1
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name
                          ,
                          style: primaryTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: semiBold
                          ),
                        ),
                        Text(
                          widget.product.category.name,
                          style: secondaryTextStyle.copyWith(
                            fontSize: 12
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      wishlist.setProduct(widget.product);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                            wishlist.isWishlist(widget.product) ? "Has been added to the Whitelist" : "Has been removed from the Whitelist",
                            style: primaryTextStyle.copyWith(
                              fontSize: 12
                            ),
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: wishlist.isWishlist(widget.product) ? secondaryColor : alertColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(8)
                            )
                          ),
                        )
                      );
                    },
                    child: Image.asset(
                      wishlist.isWishlist(widget.product) 
                        ? "assets/btn_wishlist_active.png" 
                        : "assets/btn_wishlist.png",
                      width: 46,
                      height: 46,
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(
                top: 20,
                left: defaultMargin,
                right: defaultMargin
              ),
              decoration: BoxDecoration(
                color: bgColor2,
                borderRadius: BorderRadius.circular(4)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Price starts from",
                    style: primaryTextStyle,
                  ),
                  Text(
                    "\$${widget.product.price}",
                    style: priceTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium
                    ),
                  ),
                  SizedBox(height: 12,),
                  Text(
                    widget.product.description,
                    style: subTitleTextStyle.copyWith(
                      fontWeight: light
                    ),
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: defaultMargin
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      "Familiar Shoes",
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium
                      ),
                    ),
                  ),
                  SizedBox(height: 12,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: familiarShoes.map((image) {
                        index++;
                        return familiarShoesContainer(image, index);
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(30),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => DetailChatPage(widget.product)
                        )
                      );
                    },
                    child: Image.asset(
                      "assets/btn_chat.png",
                      width: 54,
                      height: 54,
                    ),
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: EdgeInsets.symmetric(
                          vertical: 15
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                        )
                      ),
                      onPressed: (){
                        cart.addCart(widget.product);
                        showSuccessDialog();
                      }, 
                      child: Text(
                        "Add to Cart",
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold
                        ),
                      )
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: cardColor,
      body: ListView(
        children: [
          header(),
          content()
        ],
      ),
    );
  }
}