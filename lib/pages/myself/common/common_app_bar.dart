import 'package:portfolio/addl/HeaderLink.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // removes default back arrow
      backgroundColor: Color(0xFF1B1C1B),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Left side logo
          Expanded(
            flex: 1,
            child: Center(
              child: TextButton(
                onPressed: () {
                  context.goNamed('myself');
                },
                child: Text(
                  '> ~/',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

          /// Right side menu
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                HeaderLink(title: 'About', onTap: () {context.goNamed('about_me');}),
                HeaderLink(title: 'CV', onTap: () {}),
                // HeaderLink(title: 'Projects', onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
