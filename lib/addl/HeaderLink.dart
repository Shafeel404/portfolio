import 'package:flutter/material.dart';

class HeaderLink extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const HeaderLink({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
      ),
    );
  }
}
