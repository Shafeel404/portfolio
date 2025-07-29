import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/addl/HeaderLink.dart';
import 'package:portfolio/providers/theme_provider.dart';

class CommonAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CommonAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);
    final theme = Theme.of(context);
    return AppBar(
      automaticallyImplyLeading: false, // removes default back arrow
      backgroundColor: isDark
          ? Color(0xFF1B1C1B)
          : theme.colorScheme.surfaceContainerHighest,
      actions: [
        IconButton(
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: isDark
                ? const Icon(Icons.wb_sunny, key: ValueKey('sunny'))
                : const Icon(Icons.brightness_2, key: ValueKey('moon')),
          ),
          onPressed: () {
            !isDark
                ? ref.read(themeProvider.notifier).state = true
                : showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Bug Alert 🚨'),
                      content: const Text(
                        'Light attracts bugs. So only dark mode available now.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                        TextButton(
                          onPressed: () => {
                            ref.read(themeProvider.notifier).state = false,
                            Navigator.of(context).pop(),
                          },
                          child: const Text(
                            'Force Light mode',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                      actionsAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  );
          },
        ),
      ],
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
                HeaderLink(
                  color: Theme.of(context).colorScheme.onSurface,
                  title: 'About',
                  onTap: () {
                    context.goNamed('about_me');
                  },
                ),
                HeaderLink(
                  color: Theme.of(context).colorScheme.onSurface,
                  title: 'CV',
                  onTap: () {},
                ),
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
