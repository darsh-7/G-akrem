import 'package:flutter/material.dart';

class StatisticsCard extends StatelessWidget {
  const StatisticsCard({super.key, this.width = 100 , this.color = Colors.black , this.textColor = Colors.white, required this.value, required this.valueName});

  final double width;
  final Color color ;
  final Color textColor ;
  final String value ;
  final String valueName;


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(4),
      color: color,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
           ),
        child: RichText(
          textAlign: TextAlign.center,
          text:  TextSpan(
            text: '$value\n',
            style: TextStyle(height: 1.5, fontSize: 28),
            children: [
              TextSpan(
                text: valueName,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
