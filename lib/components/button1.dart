import 'package:flutter/material.dart';

class MyButton1 extends StatelessWidget {
  final IconData iconData;
  final Function()? onTap;

  const MyButton1({
    super.key,
    required this.onTap,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color(0xFF78C850),
      child: IconButton(
        icon: Icon(iconData),
        onPressed: onTap,
      ),
    );
  }
}
