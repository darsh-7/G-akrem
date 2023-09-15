import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery
        .of(context)
        .platformBrightness == Brightness.dark;
    var iconColor = isDark ? AppColors.mainColor : AppColors.mainColor;


    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: iconColor.withOpacity(0.1),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title, style: Theme
          .of(context)
          .textTheme
          .bodyText1
          ?.apply(color: textColor)),
      trailing: endIcon ? Transform.rotate(
        angle: 180 * math.pi / 180,
        child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.withOpacity(0.1),
            ),
            child: Icon(Icons
                .arrow_back_ios_new_rounded) //const Icon(LineAwesomeIcons.angle_right, size: 18.0, color: Colors.grey)
        ),
      ): null,
    );
  }
}