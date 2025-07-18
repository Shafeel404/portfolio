import 'package:portfolio/pages/error.dart';
import 'package:portfolio/pages/myself/about_me.dart';
import 'package:portfolio/pages/myself/myself.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterConfigs {
  GoRouter router = GoRouter(
    initialLocation: "/myself",
    routes: [
      GoRoute(
        name: "about_me",
        path: "/about_me",
        pageBuilder: (context, state) {
          return MaterialPage(child: AboutMe());
        },
      ),
      GoRoute(
        name: "myself",
        path: "/myself",
        pageBuilder: (context, state) {
          return MaterialPage(child: Myself());
        },
      ),
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(child: Error());
    },
  );
}
