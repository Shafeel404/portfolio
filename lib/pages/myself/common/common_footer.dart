import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommonFooter extends StatelessWidget {
  final double width;
  final bool isDark;

  const CommonFooter({super.key, required this.width, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width, vertical: 20),
      child: Text(
        '© ${DateTime.now().year} Shafeel T. All rights reserved.',
        style: TextStyle(
          color: isDark ? Colors.white24 : Colors.black,
          fontSize: 12,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
