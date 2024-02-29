import 'package:akrem/Screens/customer_screen/Home/NavigationBar.dart';
import 'package:akrem/Screens/customer_screen/Home/basket/details_view.dart';
import 'package:akrem/Screens/customer_screen/provider/cart.dart';
import 'package:akrem/Screens/customer_screen/shared/appbar.dart';
import 'package:akrem/Screens/map/Select_location.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:akrem/model/item.dart';
import 'dart:math' as math;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    final textt = Provider.of<Cart>(context);
    return SafeArea(
      child: Scaffold(
          body: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(width: 1.0, color: Get.theme.shadowColor),
                  color: Colors.red.withOpacity(0.9),
                  boxShadow:[
                    BoxShadow(
                      color: Colors.red.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(-8, 8), // Shadow position
                    ),
                    BoxShadow(
                      color: Colors.red.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(8, 8), // Shadow position
                    ),
                  ]
                ),
                child:  RichText(
                  text: TextSpan(
                    text: 'you can get more help or medication by visiting our ',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Get.theme.shadowColor),
                    /*defining default style is optional */
                    children: <TextSpan>[
                      TextSpan(
                          text: "Hub",
                          style: TextStyle(color: AppColors.mainColor)),
                      TextSpan(
                        text: " click for more",
                        //style: TextStyle(color: Colors.red)
                      ),
                    ],
                  ),
                ),
              ),
              GridView.builder(
                padding: EdgeInsets.only(bottom: 20),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 4 / 4.4,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 10),
                itemCount: textt.selectedProducts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Details(product: items[index]),
                            ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 8, right: 8),
                        decoration: BoxDecoration(
                          color: Get.theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(0, 2), // Shadow position
                            ),
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 4), // Shadow position
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: ListTile(
                            minVerticalPadding: 0,
                            contentPadding: EdgeInsets.all(0),
                            title: Container(
                              margin: EdgeInsets.only(top: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: AspectRatio(
                                aspectRatio: 5 / 4,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(55),
                                    child: Image.asset(
                                        textt.selectedProducts[index].imgPath)),
                              ),
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: 40,
                                    decoration: const BoxDecoration(
                                        // color: Colors.blue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40))),
                                    child: Container(
                                      child: const Text(
                                        'Name',
                                        style: TextStyle(
                                            overflow: TextOverflow.clip),
                                        maxLines: 2,
                                      ),
                                    )),
                                const Text(
                                  '\$12.99',
                                  style: TextStyle(overflow: TextOverflow.clip),
                                  maxLines: 1,
                                ),
                                // Container(
                                //   height: 30,
                                //   width: 30,
                                //   decoration: const BoxDecoration(
                                //       color: Colors.blue,
                                //       borderRadius:
                                //           BorderRadius.all(Radius.circular(40))),
                                //   child: IconButton(
                                //     padding: const EdgeInsets.all(0),
                                //     visualDensity: VisualDensity.comfortable,
                                //     onPressed: () {
                                //       textt.add(items[index]);
                                //     },
                                //     icon: const Icon(
                                //       Icons.add,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      )

                      // Card(
                      //   color: Colors.white,
                      //   //surfaceTintColor: Colors.white,
                      //   child: Container(
                      //     child:
                      //     ListTile(
                      //     //contentPadding: EdgeInsets.all(0),
                      //     title: Padding(
                      //       padding: const EdgeInsets.all(0),
                      //       child:
                      //       AspectRatio(
                      //         aspectRatio: 4/2,
                      //         child:  ClipRRect(
                      //             borderRadius: BorderRadius.circular(55),
                      //             child: Image.asset(items[index].imgPath)),
                      //       ),
                      //
                      //     ),
                      //     subtitle: const ListTile(
                      //       title: Text("name"),
                      //       subtitle: Text('price'),
                      //     ),
                      //   ),)
                      // )

                      // child: Stack(
                      //   children: [
                      //     Positioned(
                      //       top: -3,
                      //       bottom: -9,
                      //       right: 0,
                      //       left: 0,
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(bottom: 40),
                      //         child: ClipRRect(
                      //             borderRadius: BorderRadius.circular(55),
                      //             child: Image.asset(items[index].imgPath)),
                      //       ),
                      //     )
                      //   ],
                      // ),

                      );
                },
              ),
            ],
          ),
          appBar: _buildAppBar()),
    );
  }
}

AppBar _buildAppBar() {
  return AppBar(
    backgroundColor: Get.theme.primaryColor,
    actions: const [
      ProductsAndPrice(),
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
                width: Get.mediaQuery.size.width - 250,
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
