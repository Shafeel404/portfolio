// import 'dart:math';
// import 'package:flutter/material.dart';
//
// class InsectAnimation extends StatefulWidget {
//   const InsectAnimation({super.key});
//
//   @override
//   State<InsectAnimation> createState() => _InsectAnimationState();
// }
//
// class _InsectAnimationState extends State<InsectAnimation> with SingleTickerProviderStateMixin {
//   final Random _random = Random();
//   final List<Insect> _insects = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _spawnInsects();
//   }
//
//   void _spawnInsects() {
//     // Create 3-8 insects randomly
//     final count = 3 + _random.nextInt(6);
//     for (int i = 0; i < count; i++) {
//       _insects.add(Insect(
//         speed: 0.5 + _random.nextDouble() * 2.0,
//         size: 10.0 + _random.nextDouble() * 20.0,
//         direction: _random.nextDouble() * 2 * pi,
//         x: _random.nextDouble(),
//         y: _random.nextDouble(),
//         sprite: _random.nextInt(3), // 3 different insect sprites
//       ));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTap: _spawnInsects,
//         child: CustomPaint(
//           painter: InsectPainter(insects: _insects),
//           size: Size.infinite,
//         ),
//       ),
//     );
//   }
// }
//
// class Insect {
//   double x, y; // Position (0.0-1.0)
//   double direction; // Angle in radians
//   double speed; // Speed multiplier
//   double size; // Size in logical pixels
//   int sprite; // Which sprite to use
//
//   Insect({
//     required this.x,
//     required this.y,
//     required this.direction,
//     required this.speed,
//     required this.size,
//     required this.sprite,
//   });
//
//   void update(Random random, Size size) {
//     // Move forward
//     x += cos(direction) * speed / 1000;
//     y += sin(direction) * speed / 1000;
//
//     // Random direction changes
//     if (random.nextDouble() < 0.02) {
//       direction += (random.nextDouble() - 0.5) * pi / 4;
//     }
//
//     // Bounce off edges
//     if (x < 0) {
//       x = 0;
//       direction = pi - direction;
//     } else if (x > 1) {
//       x = 1;
//       direction = pi - direction;
//     }
//
//     if (y < 0) {
//       y = 0;
//       direction = -direction;
//     } else if (y > 1) {
//       y = 1;
//       direction = -direction;
//     }
//   }
// }
//
// class InsectPainter extends CustomPainter {
//   final List<Insect> insects;
//
//   InsectPainter({required this.insects}) : super(repaint: _ticker);
//
//   static final _ticker = ValueNotifier<int>(0);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     // Update all insects
//     final random = Random();
//     for (final insect in insects) {
//       insect.update(random, size);
//
//       // Draw insect
//       final paint = Paint()
//         ..color = _getInsectColor(insect.sprite)
//         ..style = PaintingStyle.fill;
//
//       final x = insect.x * size.width;
//       final y = insect.y * size.height;
//
//       // Draw body
//       canvas.drawCircle(Offset(x, y), insect.size / 2, paint);
//
//       // Draw legs (simplified)
//       for (int i = 0; i < 6; i++) {
//         final angle = insect.direction + (i - 2.5) * 0.5;
//         final legLength = insect.size * 0.6;
//         canvas.drawLine(
//           Offset(x, y),
//           Offset(
//             x + cos(angle) * legLength,
//             y + sin(angle) * legLength,
//           ),
//           paint..strokeWidth = 1,
//         );
//       }
//     }
//
//     // Schedule next frame
//     Future.delayed(const Duration(milliseconds: 16), () {
//       _ticker.value++;
//     });
//   }
//
//   Color _getInsectColor(int sprite) {
//     return [
//       const Color(0xFF8B4513), // Brown
//       const Color(0xFF000000), // Black
//       const Color(0xFF556B2F), // Dark olive green
//     ][sprite];
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }