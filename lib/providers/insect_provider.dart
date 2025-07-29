import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/model/insect.dart';

class InsectNotifier extends StateNotifier<List<Insect>> {
  InsectNotifier() : super([]) {
    // Add initial insects
    for (int i = 0; i < 30; i++) {
      state = [...state, Insect(x: Random().nextDouble() * 300, y: Random().nextDouble() * 500)];
    }
  }

  void moveAll() {
    state = [
      for (final insect in state) insect.moveRandomly(),
    ];
  }

  void squash(Insect target) {
    state = state.where((i) => i != target).toList();
  }
}

final insectProvider = StateNotifierProvider<InsectNotifier, List<Insect>>((ref) {
  return InsectNotifier();
});
