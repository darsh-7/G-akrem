import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  // const Color primaryColor = Color(0xFF2967FF);
  // const Color grayColor = Color(0xFF8D8D8E);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(16.0 / 2),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.4),
          borderRadius:
          const BorderRadius.all(Radius.circular(16.0))),
    );
  }
}



class NewsCardSkelton extends StatelessWidget {
  const NewsCardSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Skeleton(height: 120, width: 120),
        SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton(width: 80),
              SizedBox(height: 16.0 / 2),
              Skeleton(),
              SizedBox(height: 16.0 / 2),
              Skeleton(),
              SizedBox(height: 16.0 / 2),
              Row(
                children: [
                  Expanded(
                    child: Skeleton(),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Skeleton(),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({Key? key, this.size = 24}) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}