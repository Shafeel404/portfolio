import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/insect_provider.dart';

class BugOverlay extends ConsumerStatefulWidget {
  const BugOverlay({super.key});

  @override
  ConsumerState<BugOverlay> createState() => _BugOverlayState();
}

class _BugOverlayState extends ConsumerState<BugOverlay> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      ref.read(insectProvider.notifier).moveAll();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final insects = ref.watch(insectProvider);

    return IgnorePointer(
      // Prevents bugs from blocking your main UI
      child: Stack(
        children: insects.map((insect) {
          return AnimatedPositioned(
            duration: const Duration(seconds: 2),
            left: insect.x,
            top: insect.y,
            child: GestureDetector(
              onTap: () => ref.read(insectProvider.notifier).squash(insect),
              behavior: HitTestBehavior.translucent,
              child: Image.asset('assets/images/bug.png', width: 40, height: 40),
            ),
          );
        }).toList(),
      ),
    );
  }
}
