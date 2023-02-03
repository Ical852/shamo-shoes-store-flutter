//@dart=2.9

import 'package:flutter/material.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/pages/product_page.dart';
import 'package:shamo/theme.dart';

class ChatBubble extends StatelessWidget {

  String text;
  bool isSeller;
  ProductModel product;

  ChatBubble({this.isSeller = false, this.text= "", this.product,});

  @override
  Widget build(BuildContext context) {

    Widget productPreview() {
      return GestureDetector(
        onTap: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProductPage(product)));
        },
        child: Container(
          width: 231,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSeller ? bgColor4 : productsPreviewColor,
            borderRadius: BorderRadius.only(
              topLeft: isSeller ? Radius.circular(0) : Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
              topRight: isSeller ? Radius.circular(12) : Radius.circular(0)
            )
          ),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product.galleries[0].url,
                      height: 70,
                      width: 70,
                    ),
                  ),
                  SizedBox(width: 8,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: primaryTextStyle,
                        ),
                        SizedBox(height: 4,),
                        Text(
                          "\$${product.price}",
                          style: priceTextStyle.copyWith(
                            fontWeight: medium
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: primaryColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      )
                    ),
                    onPressed: (){}, 
                    child: Text(
                      "Add to Cart",
                      style: purpleTextStyle,
                    )
                  ),
                  SizedBox(width: 8,),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      )
                    ),
                    onPressed: (){}, 
                    child: Text(
                      "Buy Now",
                      style: blackTextStyle.copyWith(
                        fontWeight: medium,
                        color: productsPreviewColor
                      ),
                    )
                  )
                ],
              )
            ],
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        top: 30
      ),
      child: Column(
        crossAxisAlignment: isSeller ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          product is UnitializedProductModel ?  SizedBox() :  productPreview(),
          SizedBox(height: 12,),
          Row(
            mainAxisAlignment: isSeller ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16
                  ),
                  decoration: BoxDecoration(
                    color: isSeller ? bgColor4 : productsPreviewColor,
                    borderRadius: BorderRadius.only(
                      topLeft: isSeller ? Radius.circular(0) : Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                      topRight: isSeller ? Radius.circular(12) : Radius.circular(0)
                    )
                  ),
                  child: Text(
                    text,
                    style: primaryTextStyle
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}