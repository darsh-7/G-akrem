import 'package:flutter/material.dart';

Widget _createChoosePayment(){
  return StatefulBuilder(builder: (BuildContext context, StateSetter mystate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 12, bottom: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(10)
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Text('Payment Method', style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold
          )),
        ),
        Flexible(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: <Widget>[
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffcccccc),
                          width: 1.0,
                        ),
                      ),
                      child: Image.asset('assets/images/visa.png', height: 10),
                    ),
                    Text('Visa card ending in 4392')
                  ],
                ),
              ),
              Divider(
                height: 32,
                color: Colors.grey[400],
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffcccccc),
                          width: 1.0,
                        ),
                      ),
                      child: Image.asset('assets/images/mastercard.png', height: 20),
                    ),
                    Text('MasterCard ending in 5309')
                  ],
                ),
              ),
              Divider(
                height: 32,
                color: Colors.grey[400],
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffcccccc),
                          width: 1.0,
                        ),
                      ),
                      child: Image.asset('assets/images/visa.png', height: 10),
                    ),
                    Text('Visa card ending in 2285')
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  });
}