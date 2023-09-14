import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearshAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  const SearshAppBar({required this.controller, this.onChanged});


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: CupertinoSearchTextField(
          controller: controller,
          onChanged: onChanged,
        ),

      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(136);
}
