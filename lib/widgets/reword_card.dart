import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';

class VerticalCouponExample extends StatelessWidget {
  const VerticalCouponExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CouponCard(
      height: 150,
      backgroundColor: Colors.blue,
      curveAxis: Axis.vertical,
      firstChild: Container(
        decoration: const BoxDecoration(
          color: Colors.blue,
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '23%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'OFF',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: Colors.white54, height: 0),
            Expanded(
              child: Center(
                child: Text(
                  'Valid Till \n30 Jan 2022',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      secondChild: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Coupon Code',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'FREESALES',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[300],
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Container(
                width: double.maxFinite,
                // decoration: const BoxDecoration(
                //   border: Border(
                //     top: BorderSide(color: Colors.white),
                //   ),
                // ),
                // margin: const EdgeInsets.symmetric( horizontal: 8, vertical: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                    // padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    //   const EdgeInsets.symmetric(horizontal: 80),
                    // ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.white,
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'REDEEM',
                    style: TextStyle(
                        fontSize: 14,
                        foreground: Paint()
                          ..shader = LinearGradient(
                            colors: <Color>[Colors.cyanAccent,Colors.cyan, Colors.blue],
                          ).createShader(Rect.fromLTWH(100.0, 0.0, 200.0, 70.0))),
                  ),
                )),
            // Text(
            //   'Valid Till - 30 Jan 2022',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     color: Colors.black45,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
