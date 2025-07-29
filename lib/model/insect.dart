import 'dart:math';

class Insect {
  final double x;
  final double y;

  Insect({required this.x, required this.y});

  Insect moveRandomly() {
    final rand = Random();
    double newX = x + rand.nextDouble() * 100 - 50;
    double newY = y + rand.nextDouble() * 100 - 50;

    return Insect(
      x: newX.clamp(0, 300),
      y: newY.clamp(0, 500),
    );
  }
}
