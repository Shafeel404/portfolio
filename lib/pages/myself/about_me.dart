import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/animation/transparent_insect_animation.dart';
import 'package:portfolio/pages/bug_overlay/bug_overlay.dart';
import 'package:portfolio/pages/myself/common/common_app_bar.dart';
import 'package:portfolio/pages/myself/common/common_footer.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/providers/theme_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AboutMe extends ConsumerWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF232425) : Colors.white,
      appBar: CommonAppBar(),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: ResponsiveValue(
                                  context,
                                  defaultValue: 8.0,
                                  conditionalValues: const [
                                    Condition.largerThan(
                                      name: TABLET,
                                      value: 40.0,
                                    ),
                                    Condition.largerThan(
                                      name: MOBILE,
                                      value: 20.0,
                                    ),
                                  ],
                                ).value,
                                vertical: ResponsiveValue(
                                  context,
                                  defaultValue: 8.0,
                                  conditionalValues: const [
                                    Condition.largerThan(
                                      name: TABLET,
                                      value: 40.0,
                                    ),
                                    Condition.largerThan(
                                      name: MOBILE,
                                      value: 20.0,
                                    ),
                                  ],
                                ).value,
                              ),
                              constraints: const BoxConstraints(maxWidth: 800),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 30),
                                  Text(
                                    'About',
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: isDark
                                          ? Colors.white54
                                          : Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Text(
                                    'Hey there!',
                                    style: TextStyle(
                                      fontSize: 38,
                                      color: isDark
                                          ? Colors.white54
                                          : Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "I'm a curious and hands-on Full-Stack Developer with a strong foundation in Java Spring Boot, React, and Flutter,"
                                    " always looking for ways to simplify complex systems and build things that just work. Over time, I’ve grown deeply"
                                    " interested in how things connect—from backend APIs to mobile apps, microcontrollers, and even vehicle electronics."
                                    " I enjoy diving into low-level debugging as much as crafting clean UI experiences. Whether I’m optimizing code,"
                                    " hacking on side projects, or experimenting with ESP32 boards and Telegram bots, I always aim to learn something "
                                    "new and useful. When I'm not coding, you’ll probably find me exploring tech communities, reverse-engineering gadgets,"
                                    " or tweaking my setup just to see how far I can push it.",
                                    style: TextStyle(
                                      color: isDark
                                          ? Colors.white54
                                          : Colors.black,
                                    ),
                                  ),
                                  Divider(
                                    color: isDark
                                        ? Colors.white24
                                        : Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        CommonFooter(width: 20.0, isDark: isDark),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          ?isDark?null:
          const Positioned.fill(
            child: IgnorePointer(
              child: TransparentInsectAnimation(
                insectCount: 8, // Adjust number of insects
              ),
            ),
          ),
        ],
      ),
    );
  }
}
