import 'package:flutter/material.dart';

class HeaderLink extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color? color;

  const HeaderLink({super.key, required this.title, required this.onTap, required this.color});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
      ),
    );
  }
}
