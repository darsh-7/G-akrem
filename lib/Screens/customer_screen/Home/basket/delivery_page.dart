import 'dart:async';

import 'package:akrem/Screens/customer_screen/Home/NavigationBar.dart';
import 'package:akrem/Screens/customer_screen/Home/basket_page.dart';
import 'package:akrem/controller/shopping_card_controller.dart';
import 'package:akrem/model/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryPage extends StatefulWidget {
  final bool fromList;

  const DeliveryPage({Key? key, this.fromList = false})
      : super(key: key);

  @override
  _DeliveryPageState createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  // initialize global function and reusable widget

  double _subTotal = 0;
  String _delivery = '';
  double _deliveryPrice = 0;
  final ShoppingCardController shoppingCardController = Get.find();

  @override
  void initState() {
    countSubTotal();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void countSubTotal() {
    _subTotal = 0;
    for (int i = 0; i < shoppingCardController.cart.length; i++) {
      _subTotal += shoppingCardController.cart[i].price * shoppingCardController.cart[i].quantity;
    }
    _subTotal += _deliveryPrice;
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 6);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Delivery',
          ),
        ),
        body: ListView(
          children: [
            //_createDeliveryInformation(),
            _createOrderListInformation(boxImageSize),
            _createChooseDeliveryInformation(),
            _createSubTotalInformation()
          ],
        ));
  }

  // Widget _createDeliveryInformation(){
  //   return Container(
  //     padding: EdgeInsets.all(16),
  //     color: Colors.white,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Flexible(
  //               child: Text('Home Address', style: TextStyle(
  //                   fontSize: 16, fontWeight: FontWeight.bold
  //               )),
  //             ),
  //             SizedBox(
  //               width: 8,
  //             ),
  //             Container(
  //               margin: EdgeInsets.only(right: 8),
  //               padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
  //               decoration: BoxDecoration(
  //                   color: Get.theme.primaryColor,
  //                   borderRadius: BorderRadius.circular(2)
  //               ),
  //               child: Row(
  //                 children: [
  //                   Text('Default', style: TextStyle(
  //                       color: Colors.white, fontSize: 13
  //                   )),
  //                   SizedBox(
  //                     width: 4,
  //                   ),
  //                   Icon(Icons.done, color: Colors.white, size: 11)
  //                 ],
  //               ),
  //             )
  //           ],
  //         ),
  //         SizedBox(
  //           height: 16,
  //         ),
  //         Container(
  //           child: Text('Robert Steven', style: TextStyle(
  //               color: CHARCOAL, fontSize: 14
  //           )),
  //         ),
  //         Container(
  //           margin: EdgeInsets.only(top: 4),
  //           child: Text('0811888999', style: TextStyle(
  //               color: CHARCOAL, fontSize: 14
  //           )),
  //         ),
  //         Container(
  //           margin: EdgeInsets.only(top: 4),
  //           child: Text('6019 Madison St', style: TextStyle(
  //               color: CHARCOAL, fontSize: 14
  //           )),
  //         ),
  //         Container(
  //           margin: EdgeInsets.only(top: 4),
  //           child: Text('West New York, NJ 07093', style: TextStyle(
  //               color: CHARCOAL, fontSize: 14
  //           )),
  //         ),
  //         Container(
  //           margin: EdgeInsets.only(top: 4),
  //           child: Text('USA', style: TextStyle(
  //               color: CHARCOAL, fontSize: 14
  //           )),
  //         ),
  //         SizedBox(height: 4),
  //         GestureDetector(
  //           onTap: (){
  //             Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeAddressPage()));
  //           },
  //           child: Container(
  //             alignment: Alignment.topRight,
  //             child: Text('Change Address', style: TextStyle(
  //                 color: PRIMARY_COLOR, fontSize: 14
  //             )),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _createOrderListInformation(boxImageSize) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order List',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Column(
            children: List.generate(shoppingCardController.cart.length, (index) {
              int quantity = shoppingCardController.cart[index].quantity;
              return GestureDetector(
                onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(name: shoppingCartData[index].name, image: shoppingCartData[index].image, price: shoppingCartData[index].price, rating: 4, review: 23, sale: 36)));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: buildCacheNetworkImage(
                              width: boxImageSize,
                              height: boxImageSize,
                              url: shoppingCardController.cart[index].image)),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              shoppingCardController.cart[index].name,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 4),
                                child: Text(
                                    quantity.toString() + ' item (150 gr)')),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: Text("awdawd"),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _createChooseDeliveryInformation() {
    return Container(
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Delivery',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return _showDeliveryPopup();
                  },
                );
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey[300]!),
                    borderRadius: BorderRadius.all(
                        Radius.circular(10) //         <--- border radius here
                        )),
                child: _delivery == ''
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.local_shipping,
                                  color: Get.theme.primaryColor),
                              SizedBox(width: 12),
                              Text('Choose Delivery',
                                  style: TextStyle(
                                      color: Get.theme.primaryColor,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Icon(Icons.chevron_right,
                              size: 20, color: Colors.grey),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_delivery,
                                  style: TextStyle(
                                      color: Get.theme.primaryColor,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 5,
                              ),
                              Text('\$' + _deliveryPrice.toString()),
                            ],
                          ),
                          Icon(Icons.chevron_right,
                              size: 20, color: Colors.grey),
                        ],
                      ),
              ),
            ),
          ],
        ));
  }

  Widget _showDeliveryPopup() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter mystate) {
      return Container(
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 8,
                  margin: EdgeInsets.only(top: 12, bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text('Choose Delivery method'),
            ),
            Flexible(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: <Widget>[
                  Text('Regular'),
                  // GestureDetector(
                  //   behavior: HitTestBehavior.translucent,
                  //   onTap: () {
                  //     setState(() {
                  //       _delivery = 'DHL Regular';
                  //       _deliveryPrice = 13;
                  //     });
                  //     countSubTotal();
                  //     Navigator.pop(context);
                  //   },
                  //   child: Container(
                  //     margin: EdgeInsets.only(top: 16),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text('Regular'),
                  //         Text('\$13'),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        _delivery = 'Regular';
                        _deliveryPrice = 22;
                      });
                      countSubTotal();
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Cost'),
                          Text('22'),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 32,
                    color: Colors.grey[400],
                  ),
                  Text('Fast Delivery'),
                  // GestureDetector(
                  //   behavior: HitTestBehavior.translucent,
                  //   onTap: () {
                  //     setState(() {
                  //       _delivery = 'FedEx Regular';
                  //       _deliveryPrice = 9;
                  //     });
                  //     countSubTotal();
                  //     Navigator.pop(context);
                  //   },
                  //   child: Container(
                  //     margin: EdgeInsets.only(top: 16),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text('Regular'),
                  //         Text('\$9'),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        _delivery = 'Fast Delivery';
                        _deliveryPrice = 35;
                      });
                      countSubTotal();
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Express'),
                          Text('35'),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 32,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _createSubTotalInformation() {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Payment Method',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () {
                        // showModalBottomSheet<void>(
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return _createChoosePayment();
                        //   },
                        // );
                      },
                      child: Text('Change',
                          style: TextStyle(
                              color: Get.theme.primaryColor, fontSize: 14)),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      // Container(
                      //   margin: EdgeInsets.only(right: 8),
                      //   padding: EdgeInsets.all(4),
                      //   decoration: BoxDecoration(
                      //     border: Border.all(
                      //       color: Color(0xffcccccc),
                      //       width: 1.0,
                      //     ),
                      //   ),
                      //   child: Image.asset('assets/images/visa.png', height: 10),
                      // ),
                      Text('Visa card ending in 4392',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Get.theme.primaryColor))
                    ],
                  ),
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal',
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Expanded(child:
              Divider(height: 1,thickness: 0.6,color: Get.theme.hintColor,indent: 15,endIndent: 15,)
              ),
              Text(_subTotal.toString(),
                  style: TextStyle(
                    fontSize: 14,
                  )),
            ],
          ),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delivery',
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Expanded(child:
              Divider(height: 1,thickness: 0.6,color: Get.theme.hintColor,indent: 15,endIndent: 15,)
              ),
              Text("30",
                  style: TextStyle(
                    fontSize: 14,
                  )),
            ],
          ),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total amount',
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Expanded(child:
              Divider(height: 1,thickness: 0.6,color: Get.theme.hintColor,indent: 15,endIndent: 15,)
              ),
              Text((_subTotal+30).toString(),
                  style: TextStyle(
                    fontSize: 14,
                  )),
            ],
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(32),
            child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) => Get.theme.primaryColor,
                  ),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  )),
                ),
                onPressed: () {
                  showLoading('Your payment is success, we will prepare your order as soon as possible');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    'Pay',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )),
          ),
        ],
      ),
    );
  }

  void showLoading(String textMessage) {
    _progressDialog(context);
    Timer(Duration(seconds: 2), () {
      Navigator.pop(context);
      _buildShowDialog(context, textMessage);
    });
  }

  Future _progressDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Future _buildShowDialog(BuildContext context, String textMessage) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)), //this right here
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.fromLTRB(40, 20, 40, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      textMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) => Get.theme.primaryColor,
                            ),
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            )),
                          ),
                          onPressed: () {
                            //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (Route<dynamic> route) => false);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            if (!widget.fromList) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => BasketPage()));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16),
                            child: Text(
                              'OK',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
