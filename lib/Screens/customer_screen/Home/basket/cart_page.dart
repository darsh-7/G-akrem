import 'dart:ffi';

import 'package:akrem/Screens/customer_screen/Home/basket/delivery_page.dart';
import 'package:akrem/Screens/customer_screen/Home/basket_page.dart';
import 'package:akrem/controller/shopping_card_controller.dart';
import 'package:akrem/model/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabShoppingCartPage extends StatefulWidget {
  @override
  _TabShoppingCartPageState createState() => _TabShoppingCartPageState();
}

class _TabShoppingCartPageState extends State<TabShoppingCartPage> {
  // initialize global function and reusable widget

  double _totalPrice = 0;
  final ShoppingCardController shoppingCardController = Get.find();

  @override
  void initState() {
    _countTotalPrice();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _countTotalPrice(){
    _totalPrice = shoppingCardController.getPrice();
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 5);

    return Scaffold(
        appBar: AppBar(
         // automaticallyImplyLeading: false,
          title: Text(
            'Shopping Cart',
          ),
        ),
        body: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: List.generate(shoppingCardController.cart.length,(index){
                  return _buildItem(shoppingCardController.cart[index].id, boxImageSize,shoppingCardController.cart[index].name,shoppingCardController.cart[index].image,shoppingCardController.cart[index].quantity,shoppingCardController.cart[index].price );
                }),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  ///_createUseCoupon(),
                  _createTotalPrice(),
                ],
              ),
            )
          ],
        )
    );
  }

  // Widget _createUseCoupon(){
  //   return GestureDetector(
  //     behavior: HitTestBehavior.translucent,
  //     onTap: (){
  //       //Navigator.push(context, MaterialPageRoute(builder: (context) => CouponPage()));
  //     },
  //     child: Container(
  //       alignment: Alignment.center,
  //       padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
  //       margin: EdgeInsets.only(bottom: 16),
  //       decoration: BoxDecoration(
  //           color: Colors.white,
  //           border: Border.all(
  //               width: 1,
  //               color: Colors.grey[300]!
  //           ),
  //           borderRadius: BorderRadius.all(
  //               Radius.circular(10) //         <--- border radius here
  //           )
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Row(
  //             children: [
  //               Icon(Icons.local_offer, color: Get.theme.primaryColor),
  //               SizedBox(width: 12),
  //               Text('Use coupons', style: TextStyle(
  //                   color: CHARCOAL, fontWeight: FontWeight.bold
  //               )),
  //             ],
  //           ),
  //           Icon(Icons.chevron_right, size: 20, color: SOFT_GREY),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _createTotalPrice(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total', style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold
            )),
            SizedBox(height: 5),
            Text(_totalPrice.toString(), style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold
            )),
          ],
        ),
        TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) => Get.theme.primaryColor,
              ),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  )
              ),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryPage()));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Next',
                style: TextStyle(
                  color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )
        )
      ],
    );
  }

  Column _buildItem(int id, boxImageSize,String name,String imgUrl,int quantity,double price) {
    //int quantity = shoppingCartData[index].quantity;
    return Column(
      children: [
        Container(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                  //  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(name: shoppingCartData[index].name, image: shoppingCartData[index].image, price: shoppingCartData[index].price, rating: 4, review: 23, sale: 36)));
                  },
                  child: ClipRRect(
                      borderRadius:
                      BorderRadius.all(Radius.circular(4)),
                      child: buildCacheNetworkImage(width: boxImageSize, height: boxImageSize, url: imgUrl)),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (){
                       //   Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(name: shoppingCartData[index].name, image: shoppingCartData[index].image, price: shoppingCartData[index].price, rating: 4, review: 23, sale: 36)));
                        },
                        child: Text(
                          name,
                        //  style: GlobalStyle.productName.copyWith(fontSize: 14),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          "Price: " + price.toString(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                showPopupDelete(id, boxImageSize);
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: 1, color: Colors.grey[300]!)),
                                child: Icon(Icons.delete,
                                    color: Colors.grey, size: 20),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    setState(() {

                                      shoppingCardController.removeItem(id: id);
                                      _countTotalPrice();
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    height: 28,
                                    decoration: BoxDecoration(
                                        color: Get.theme.primaryColor,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Icon(Icons.remove,
                                        color: Colors.white, size: 20),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  child: Text(quantity.toString(), style: TextStyle(

                                  )),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    setState(() {
                                      shoppingCardController.addMedic(id: id, ImageUrl: imgUrl, name: name, price: price);
                                      _countTotalPrice();
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    height: 28,
                                    decoration: BoxDecoration(
                                        color: Get.theme.primaryColor,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Icon(Icons.add,
                                        color: Colors.white, size: 20),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        (id == shoppingCardController.cart.length - 1)
            ? Wrap()
            : Divider(
          height: 32,
          color: Colors.grey[400],
        )
      ],
    );
  }

  void showPopupDelete(index, boxImageSize) {
    // set up the buttons
    Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('No', style: TextStyle(color: Get.theme.primaryColor))
    );
    Widget continueButton = TextButton(
        onPressed: () {
          setState(() {
            shoppingCardController.removeItem(id: index, forceDelete: true);
            _countTotalPrice();
          });
          Navigator.pop(context);
          // Fluttertoast.showToast(msg: 'Item has been deleted from your Shopping Cart', toastLength: Toast.LENGTH_LONG);
        },
        child: Text('Yes', style: TextStyle(color: Get.theme.primaryColor))
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text('Delete from Shopping Cart', style: TextStyle(fontSize: 18),),
      content: Text('Are you sure to delete this item from your Shopping Cart ?', style: TextStyle(fontSize: 13, color: Colors.grey)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
