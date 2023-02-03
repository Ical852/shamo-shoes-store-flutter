import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/message_model.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/providers/auth_provider.dart';
import 'package:shamo/services/message_service.dart';
import 'package:shamo/theme.dart';
import 'package:shamo/widgets/chat_bubble.dart';

class DetailChatPage extends StatefulWidget {
  ProductModel product;
  DetailChatPage(this.product);

  @override
  State<DetailChatPage> createState() => _DetailChatPageState();
}

class _DetailChatPageState extends State<DetailChatPage> {

  TextEditingController messageController = TextEditingController(text:  "Hallo Apakah Barang Ini Ready?");

  @override
  Widget build(BuildContext context) {

  AuthProvider authProvider = Provider.of<AuthProvider>(context);

  handleChat() async {
    if (messageController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text(
          "Isi Pesan terlebih dahulu",
          style: primaryTextStyle.copyWith(fontSize: 12),
          textAlign: TextAlign.center,
        ),
        backgroundColor:alertColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
      ));
    } else {
      await MessageService().addMessage(
        user: authProvider.user,
        isFromUser: true,
        message: messageController.text,
        product: widget.product
      );
      setState(() {
        widget.product = UnitializedProductModel();
        messageController.text = "";
      });
    }
  }
  
    PreferredSize header() {
      return PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Container(
          margin: EdgeInsets.only(top: 18),
          child: AppBar(
            backgroundColor: bgColor1,
            centerTitle: false,
            title: Row(
              children: [
                Image.asset(
                  "assets/image_shop_online.png",
                  width: 50,
                  height: 50,
                ),
                SizedBox(width: 12,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Shoe Store",
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: medium
                      ),
                    ),
                    Text(
                      "Online",
                      style: secondaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: light
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ), 
      );
    }

    Widget productPreview() {
      return Container(
        width: 225,
        height: 74,
        margin: EdgeInsets.only(
          bottom: 20
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: productsPreviewColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: primaryColor,
          )
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.product.galleries[0].url,
                width: 54,
                height: 54,
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    overflow: TextOverflow.ellipsis,
                    style: primaryTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: reguler
                    ),
                  ),
                  SizedBox(height: 2,),
                  Text(
                    "\$${widget.product.price}",
                    style: priceTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  widget.product = UnitializedProductModel();
                });
              },
              child: Image.asset(
                "assets/ic_close.png",
                width: 22,
                height: 22,
              ),
            ),
          ],
        ),
      );
    }

    Widget chatInput() {
      return Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.product is UnitializedProductModel ? SizedBox() : productPreview(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16
                    ),
                    decoration: BoxDecoration(
                      color: bgColor4,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: messageController,
                        style: primaryTextStyle,
                        decoration: InputDecoration.collapsed(
                          hintText: "Type Message",
                          hintStyle: subTitleTextStyle
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                GestureDetector(
                  onTap: (){
                    handleChat();
                  },
                  child: Image.asset(
                    'assets/btn_send.png',
                    width: 45,
                    height: 45,
                  ),
                )
              ],
            ),
          ],
        )
      );
    }

    Widget content() {
      return StreamBuilder<List<MessageModel>>(
        stream: MessageService().getMessagesByUserId(userId: authProvider.user.id),
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            return ListView(
              padding: EdgeInsets.symmetric(
                horizontal: defaultMargin
              ),
              children: snapshot.data!.map((MessageModel message) => ChatBubble(
                isSeller: !message.isFromUser,
                text: message.message,
                product: message.product,
              )).toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        }
      );
    }

    return Scaffold(
      backgroundColor: bgColor3,
      appBar: header(),
      bottomNavigationBar: chatInput(),
      body: content(),
    );
  }
}