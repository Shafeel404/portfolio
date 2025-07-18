import 'package:flutter/material.dart';

class CommonFooter extends StatelessWidget {
  final double width;
  const CommonFooter({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width,
        vertical: 20,
      ),
      child: Text(
        '© ${DateTime.now().year} Shafeel T. All rights reserved.',
        style: TextStyle(color: Colors.white24, fontSize: 12),
        textAlign: TextAlign.center,
      ),
    );
  }
}
