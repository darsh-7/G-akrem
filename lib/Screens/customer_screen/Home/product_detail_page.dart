import 'package:akrem/Screens/customer_screen/Home/basket/cart_page.dart';
import 'package:akrem/Screens/customer_screen/Home/basket_page.dart';
import 'package:akrem/Screens/customer_screen/shared/cart_buttom.dart';
import 'package:akrem/controller/shopping_card_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';

class ProductDetailPage extends StatefulWidget {
  final int id;
  final String name;
  final String imagePath;
  final double price;
  final int quantity;


  const ProductDetailPage(
      {Key? key,
      required this.id,
        required this.name,
        required this.price ,
        required this.imagePath, required this.quantity,
      })
      : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  // shopping cart count
  int _shoppingCartCount = 3;
  final ShoppingCardController shoppingCardController = Get.find();

  bool isShowMore = false;

  @override
  void initState() {
    // image slider for the product

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 3);
    return Scaffold(
        appBar: AppBar(
          title: Container(
            margin: EdgeInsets.only(right: 16),
            child: Text("View Product"),
          ),
          actions: [
            IconButton(
                padding: EdgeInsets.all(0),
                constraints: BoxConstraints(),
                icon: customShoppingCart(),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TabShoppingCartPage()));
                }),
          ],
          // bottom: PreferredSize(
          //     child: Container(
          //       color: Colors.grey[100],
          //       height: 1.0,
          //     ),
          //     preferredSize: Size.fromHeight(1.0)),
        ),
        body: WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
            return Future.value(true);
          },
          child: Column(
            children: [
              Flexible(
                child: ListView(
                  children: [
                    _createProductSlider(),
                    _createProductPriceTitleEtc(),
                    _createDeliveryEstimated(),
                    _createProductInformation(),
                    _createProductDescription(),
                    SizedBox(height: 16)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 2.0,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            shoppingCardController.addMedic(
                              id: widget.id,
                              ImageUrl: widget.imagePath,
                              name: widget.name,
                              price: widget.price,
                            );
                          });
                            Fluttertoast.showToast(msg: 'Item has been added to Shopping Cart', toastLength: Toast.LENGTH_LONG);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Get.theme.primaryColor),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      10) //         <--- border radius here
                                  )),
                          child: Text('Add to Shopping Cart',
                              style: TextStyle(
                                  color: Get.theme.primaryColor,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _createProductSlider() {
    return buildCacheNetworkImage(url: widget.imagePath);
  }

  Widget _createProductPriceTitleEtc() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Text(widget.name,
              style: TextStyle(
                fontSize: 22,
              )),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(widget.price.toString() + " EG",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(width: 5),
                    Text(widget.price.toString() + ' EG',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: 20,
                        )),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: Text("20" + '%',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          IntrinsicHeight(
            child: Row(
              children: [
                Icon(Icons.location_on, color: Colors.blue, size: 16),
                Text('Brooklyn',
                    style: TextStyle(fontSize: 13, color: Colors.blue)),
                VerticalDivider(
                  width: 30,
                  thickness: 1,
                  color: Colors.grey[300],
                ),
                Icon(Icons.factory, color: Colors.grey, size: 16),
                Text(' Company name',
                    style: TextStyle(fontSize: 13, color: Colors.grey)),
                VerticalDivider(
                  width: 30,
                  thickness: 1,
                  color: Colors.grey[300],
                ),
                Icon(Icons.bloodtype_outlined, color: Colors.grey, size: 16),
                Text(' Medic type',
                    style: TextStyle(fontSize: 13, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDeliveryEstimated() {
    return GestureDetector(
      onTap: () {
        //   Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryEstimatedPage()));
      },
      child: Container(
          margin: EdgeInsets.only(top: 12),
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Delivery'),
                    SizedBox(
                      height: 16,
                    ),
                    RichText(
                      text: new TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: new TextStyle(
                          fontSize: 15.5,
                          color: Colors.grey,
                        ),
                        children: <TextSpan>[
                          new TextSpan(
                              text:
                                  'Calculate the estimated cost for shipping goods to '),
                          new TextSpan(
                              text: 'West New York, NJ',
                              style:
                                  new TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, size: 36, color: Colors.blue)
            ],
          )),
    );
  }

  Widget _createProductInformation() {
    return Container(
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Information'),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tablets', style: TextStyle(color: Colors.grey)),
                Text('24', style: TextStyle(color: Colors.grey))
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Weight', style: TextStyle(color: Colors.grey)),
                Text('300 Gram', style: TextStyle(color: Colors.grey))
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Condition', style: TextStyle(color: Colors.grey)),
                Text('Second', style: TextStyle(color: Colors.grey))
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Category', style: TextStyle(color: Colors.grey)),
                GestureDetector(
                  onTap: () {
                    //  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductCategoryPage(categoryId: 3, categoryName: 'Electronic')));
                  },
                  child:
                      Text('Electronic', style: TextStyle(color: Colors.blue)),
                )
              ],
            ),
          ],
        ));
  }

  Widget _createProductDescription() {
    return Container(
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 16,
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n\nQuisque tortor tortor, ultrices id scelerisque a, elementum id elit. Maecenas feugiat tellus sed augue malesuada, id tempus ex sodales.',
              maxLines: isShowMore ? null : 3,
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                isShowMore = !isShowMore;
              },
              child: Center(
                child: TextButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    setState(() {
                      isShowMore = !isShowMore;
                    });
                  },
                  child: Text(
                    isShowMore ? 'Show Less' : 'Show More',
                    // style: const TextStyle(fontSize: 18)
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
