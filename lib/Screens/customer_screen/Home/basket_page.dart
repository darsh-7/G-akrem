import 'package:akrem/Screens/customer_screen/Home/NavigationBar.dart';
import 'package:akrem/Screens/customer_screen/Home/basket/cart_page.dart';
import 'package:akrem/Screens/customer_screen/Home/product_detail_page.dart';
import 'package:akrem/Screens/customer_screen/provider/cart.dart';
import 'package:akrem/Screens/customer_screen/shared/appbar.dart';
import 'package:akrem/Screens/customer_screen/shared/cart_buttom.dart';
import 'package:akrem/Screens/map/Select_location.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/controller/market_controller.dart';
import 'package:akrem/controller/user_controller.dart';
import 'package:akrem/model/category.dart';
import 'package:akrem/model/market_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:akrem/model/item.dart';
import 'dart:math' as math;

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  //final textt = Provider.of<Cart>(context);
  //List<Product> product = items;
  final userController = Get.put(UserController());
  final testController = Get.put(MarketController());
  final scrollController = ScrollController();

  List<MarketContent> get product {
    return testController.productsList;
  }


  @override
  void initState() {
    testController.getProducts();


    scrollController.addListener(() {

      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        testController.getProducts(end: product.length+10);
      }
    });

    super.initState();  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border:
                        Border.all(width: 1.0, color: Get.theme.shadowColor),
                    color: Colors.blueAccent.withOpacity(0.9),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(-8, 8), // Shadow position
                      ),
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(8, 8), // Shadow position
                      ),
                    ]),
                child: RichText(
                  text: TextSpan(
                    text:
                        'you can get more help or medication by visiting our ',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                    /*defining default style is optional */
                    children: <TextSpan>[
                      TextSpan(
                          text: "Hub",
                          style: TextStyle(color: Colors.cyanAccent)),
                      TextSpan(
                        text: " click for more",
                        //style: TextStyle(color: Colors.red)
                      ),
                    ],
                  ),
                ),
              ),
              _createGridCategory(),
              Container(
                margin: EdgeInsets.only(top: 30, left: 16, right: 16),
                child: Text('Recommended Product',
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              GetBuilder<MarketController>(builder: (_) {
                return CustomScrollView(
                      shrinkWrap: true,
                      primary: false,
                      slivers: <Widget>[
                        SliverPadding(
                          padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                          sliver: SliverGrid(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              childAspectRatio: 0.625,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return _buildProductCard(index, context);
                              },
                              childCount: product.length,
                            ),
                          ),
                        ),
                      ]);
                }
              ),
            ],
          ),
          appBar: _buildAppBar(context)
      ),
    );
  }

  Widget _buildProductCard(index, BuildContext context) {
    final double boxImageSize =
        ((MediaQuery.of(context).size.width) - 24) / 2 - 12;
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        color: Get.theme.scaffoldBackgroundColor,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetailPage(
                        id: product[index].id!,
                        name: product[index].name!,
                        imagePath: product[index].imagePath!,
                        price: product[index].price!,
                        quantity: product[index].totalQuantity!,
                    )));
          },
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: buildCacheNetworkImage(
                          width: boxImageSize,
                          height: boxImageSize,
                          url: product[index].imagePath)),
                  Container(
                    margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                          child: Text(
                            product[index].name!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(product[index].price.toString() + " EG",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                              SizedBox(width: 5),
                              Text(product[index].price.toString() + ' EG',
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                    fontSize: 11,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Icon(Icons.location_on,
                                  color: Colors.grey, size: 12),
                              Text(' ' ,
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.grey))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Positioned(
                bottom: 30,
                right: (Get.locale == Locale('ar', "EG")) ? null  :4,
                left: (Get.locale == Locale('ar', "EG")) ? 4  :null,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: Text("20" + '%',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

AppBar _buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Get.theme.primaryColor,
    actions:  [

      IconButton(
          padding: EdgeInsets.all(0),
          constraints: BoxConstraints(),
          icon: customShoppingCart(),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TabShoppingCartPage()));
          }),

    ],
    title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      const Icon(
        Icons.location_on_rounded,
        color: Colors.deepOrange,
        size: 30,
      ),
      GetBuilder<UserController>(builder: (_) {
        print("location string ${userController.user.locationString}");
        return GestureDetector(
          child: Row(
            children: [
              SizedBox(
                width: Get.mediaQuery.size.width - 200,
                child: Text(
                  userController.user.locationString ?? "No Location",
                  style: TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Transform.rotate(
                  angle: 270 * math.pi / 180,
                  child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.withOpacity(0.23),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ))),
            ],
          ),
          onTap: () {
            Get.offAll(() => SelectLocation());
          },
        );
      }),
    ]),
  );
}

CachedNetworkImage buildCacheNetworkImage(
    {double? width, double? height, url, plColor, imageColor}) {
  if (width == 0 && height == 0) {
    return CachedNetworkImage(
      placeholder: (context, url) {
        return Container(
          color: plColor == null ? Colors.grey[200] : plColor,
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          color: Colors.grey[200],
        );
      },
      imageUrl: url,
      fit: BoxFit.cover,
      color: imageColor == null ? null : imageColor,
    );
  } else if (height == 0) {
    return CachedNetworkImage(
      placeholder: (context, url) {
        return Container(
          width: width,
          color: plColor == null ? Colors.grey[200] : plColor,
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          width: width,
          color: Colors.grey[200],
        );
      },
      imageUrl: url,
      fit: BoxFit.cover,
      width: width,
    );
  } else {
    return CachedNetworkImage(
      placeholder: (context, url) {
        return SizedBox.shrink();
      },
      errorWidget: (context, url, error) {
        return SizedBox.shrink();
      },
      imageUrl: url,
      fit: BoxFit.cover,
      width: width,
      height: height,
    );
  }
}
Widget _createGridCategory(){
  return SizedBox(
    height: 200,
    child: GridView.count(
      padding: EdgeInsets.fromLTRB(8, 16, 8, 0),
      primary: false,
      childAspectRatio: 1.1,
      shrinkWrap: true,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      crossAxisCount: 4,
      children: List.generate(categoryData.length, (index) {
        return GestureDetector(
            onTap: () {
             // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductCategoryPage(categoryId: categoryData[index].id, categoryName: categoryData[index].name)));
            },
            child: Column(
                children: [
                  buildCacheNetworkImage(width: 40, height: 40, url: categoryData[index].image, plColor: Colors.transparent),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Text(
                        categoryData[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ]));
      }),
    ),
  );
}